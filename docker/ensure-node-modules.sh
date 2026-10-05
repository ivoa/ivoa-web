#!/usr/bin/env bash
# Ensure /site/node_modules matches package-lock.json.
# Safe with Compose named volume at /site/node_modules (never rm the mount point).
set -euo pipefail

cd /site

if [[ ! -f package-lock.json ]]; then
  echo "package-lock.json not found in /site" >&2
  exit 1
fi

mkdir -p node_modules
LOCK_HASH="$(sha256sum package-lock.json | awk '{print $1}')"
MARKER="node_modules/.ivoa-lock-hash"

needs_install=0
if [[ ! -d node_modules/tailwindcss ]]; then
  needs_install=1
elif [[ ! -f "${MARKER}" ]]; then
  needs_install=1
elif [[ "$(cat "${MARKER}")" != "${LOCK_HASH}" ]]; then
  echo "- package-lock.json changed; refreshing Node dependencies..."
  needs_install=1
fi

if [[ "${needs_install}" -eq 0 ]]; then
  echo "- Node dependencies match package-lock.json (cache OK)."
  return 0 2>/dev/null || exit 0
fi

echo "- Installing Node dependencies..."
if [[ -d /opt/ivoa-web-node_modules ]]; then
  # Clear incomplete leftovers without deleting the mount point, then
  # seed from the image-prewarmed tree for a faster first start.
  find node_modules -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
  cp -a /opt/ivoa-web-node_modules/. node_modules/
fi
# npm ci replaces package contents inside the existing directory and
# works with both empty named volumes and host bind-mounts.
npm ci
printf '%s\n' "${LOCK_HASH}" > "${MARKER}"
