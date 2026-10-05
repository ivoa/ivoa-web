#!/usr/bin/env bash
# Local deploy-smoke: build public/ (or reuse), start deploy-mock, rsync, assert.
# Uses only the TEST-ONLY key under deploy/mock-ssh/ — never org SFTP secrets.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}"

MOCK_KEY="${ROOT}/deploy/mock-ssh/id_ed25519"
chmod 600 "${MOCK_KEY}"

if [[ ! -f public/index.html ]]; then
  echo "public/ missing; building via make docker-html..."
  make docker-html
fi

echo "Starting deploy-mock..."
docker compose up -d --build deploy-mock

echo "Waiting for SSH on localhost:2222..."
for i in $(seq 1 30); do
  if nc -z localhost 2222 2>/dev/null; then
    break
  fi
  if [[ "${i}" -eq 30 ]]; then
    echo "deploy-mock did not become ready" >&2
    docker compose logs deploy-mock || true
    exit 1
  fi
  sleep 1
done

# Clear known_hosts entry for ephemeral mock (port 2222).
ssh-keygen -R "[localhost]:2222" >/dev/null 2>&1 || true

echo "Rsync public/ -> deploy@localhost:/var/www/html/ ..."
ssh -i "${MOCK_KEY}" -p 2222 -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  deploy@localhost "mkdir -p /var/www/html"

rsync -avz --delete \
  -e "ssh -i ${MOCK_KEY} -p 2222 -o BatchMode=yes -o StrictHostKeyChecking=accept-new" \
  public/ deploy@localhost:/var/www/html/

docker compose exec -T deploy-mock test -f /var/www/html/index.html
docker compose exec -T deploy-mock ls -la /var/www/html/index.html
echo "deploy-smoke OK"
