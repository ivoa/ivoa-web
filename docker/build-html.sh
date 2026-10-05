#!/usr/bin/env bash
# Production-style static build inside the preview image.
# Writes ./public on the bind-mounted checkout (including public/index.html).
#
# Uses image-installed hugo/pagefind via Makefile HUGO_DIR/PAGEFIND_DIR
# overrides pointing at /usr/local/bin — never seeds checkout hugo-bin/.
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

# Point Makefile tool vars at container binaries so we do not create
# project-local hugo-bin/pagefind-bin shims on the host bind mount.
make \
  HUGO_DIR=/usr/local/bin \
  PAGEFIND_DIR=/usr/local/bin \
  generate-public-pages index-public-pages

test -f public/index.html
echo "docker-html OK: public/index.html present"
