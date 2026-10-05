# Mock SSH credentials (TEST ONLY)

These keys exist **only** so contributors and CI can exercise the
`rsync-upload` action against the local `deploy-mock` Docker service.

- **Not** IVOA `webtest` / production deploy credentials.
- **Not** org GitHub `SFTP_*` secrets.
- Safe to commit; do not reuse these keys on any real host.

## Layout

| File | Purpose |
| --- | --- |
| `id_ed25519` | Private key used by local/CI smoke tests |
| `id_ed25519.pub` | Matching public key |
| `authorized_keys` | Installed into the `deploy-mock` container for user `deploy` |

## Local smoke

```bash
docker compose up -d deploy-mock
# build public/ somehow, then:
rsync -avz --delete \
  -e "ssh -i deploy/mock-ssh/id_ed25519 -p 2222 -o StrictHostKeyChecking=accept-new" \
  public/ deploy@localhost:/var/www/html/
```

Host port **2222** maps to SSH port 22 inside the container.
Document root inside the mock is `/var/www/html`.
