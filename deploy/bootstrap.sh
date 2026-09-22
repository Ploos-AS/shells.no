#!/bin/sh
set -eu

# Shells.no M1 node bootstrap.
# Target: fresh Debian stable VPS. Designed to be safely repeatable.
# Run as root.

if [ "$(id -u)" -ne 0 ]; then
  echo "error: bootstrap must run as root" >&2
  exit 1
fi

if [ ! -r /etc/os-release ]; then
  echo "error: cannot identify operating system" >&2
  exit 1
fi

. /etc/os-release
if [ "${ID:-}" != "debian" ]; then
  echo "error: M1 reference platform is Debian (found ${ID:-unknown})" >&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
  ca-certificates curl jq openssh-server nftables \
  podman uidmap slirp4netns fuse-overlayfs \
  tmux screen rsync sudo git procps iproute2 dnsutils

install -d -m 0755 /etc/shells-no
install -d -m 0755 /srv/shells/users
install -d -m 0755 /srv/shells/state
install -d -m 0700 /srv/shells/backups
install -d -m 0755 /var/log/shells-no

# Dedicated group is informational/administrative only. It grants no
# container/runtime privileges.
getent group shells-users >/dev/null 2>&1 || groupadd --system shells-users

systemctl enable --now ssh
systemctl enable --now nftables

cat >/etc/shells-no/node.env <<EOF
SHELLS_NODE_VERSION=1
SHELLS_NODE_ROLE=combined-m1
SHELLS_DATA_ROOT=/srv/shells
EOF
chmod 0644 /etc/shells-no/node.env

echo "Shells.no M1 bootstrap complete."
echo "Next: run deploy/qualify-node.sh"
