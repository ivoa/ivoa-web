# Disposable OpenSSH + rsync target for local/CI deploy smoke tests.
# Authenticates only with the TEST-ONLY key under deploy/mock-ssh/.
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openssh-server \
        rsync \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd /var/www/html \
    && useradd -m -d /home/deploy -s /bin/bash deploy \
    && mkdir -p /home/deploy/.ssh \
    && chown -R deploy:deploy /var/www/html /home/deploy/.ssh

COPY deploy/mock-ssh/authorized_keys /home/deploy/.ssh/authorized_keys

RUN chown -R deploy:deploy /home/deploy/.ssh \
    && chmod 700 /home/deploy/.ssh \
    && chmod 600 /home/deploy/.ssh/authorized_keys \
    && sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && printf '\nAllowUsers deploy\n' >> /etc/ssh/sshd_config \
    && ssh-keygen -A

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
