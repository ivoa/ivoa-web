#!/usr/bin/env bash
# Docker preview entrypoint: mirrors `make preview` / local_preview.bash,
# but binds Hugo to 0.0.0.0 so the host can reach port 1313.
#
# Uses image-installed hugo/pagefind from PATH (/usr/local/bin). Does not
# write hugo-bin/ or pagefind-bin/ into the bind-mounted checkout.
set -euo pipefail

cd /site

if ! command -v hugo >/dev/null 2>&1 || ! command -v pagefind >/dev/null 2>&1; then
  echo "hugo and pagefind must be on PATH (image /usr/local/bin)" >&2
  exit 1
fi

# Prefer bind-mounted script so lockfile-hash logic updates without rebuild.
# shellcheck source=/dev/null
if [[ -f /site/docker/ensure-node-modules.sh ]]; then
  source /site/docker/ensure-node-modules.sh
else
  source /usr/local/bin/ensure-node-modules.sh
fi

echo "- Generating search index for preview..."
rm -rf .public_tmp static/pagefind preview
mkdir .public_tmp
hugo -d .public_tmp -DEF
pagefind --site .public_tmp
mkdir -p static
cp -r .public_tmp/pagefind static/pagefind
rm -rf .public_tmp

echo "- Listing draft pages..."
hugo list drafts | cut -d',' -f1 | tail -n+2 || true

PORT=1313
echo "- Starting Hugo preview on 0.0.0.0:${PORT} (http://localhost:${PORT}/)..."
echo "  (rendered pages available in 'preview/' while the preview is running)"

exec hugo server \
  -d preview \
  --watch \
  --bind 0.0.0.0 \
  --port "${PORT}" \
  -DEF \
  --printI18nWarnings
