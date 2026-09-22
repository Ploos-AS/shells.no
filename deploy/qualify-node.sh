#!/bin/sh
set -eu

fail=0
check() {
  name="$1"
  shift
  if "$@" >/dev/null 2>&1; then
    printf 'PASS  %s\n' "$name"
  else
    printf 'FAIL  %s\n' "$name"
    fail=1
  fi
}

echo "Shells.no node qualification"
echo "============================"
check "Debian" sh -c '. /etc/os-release && [ "$ID" = debian ]'
check "systemd" test -d /run/systemd/system
check "cgroups v2" test -f /sys/fs/cgroup/cgroup.controllers
check "OpenSSH server" command -v sshd
check "nftables" command -v nft
check "Podman" command -v podman
check "newuidmap" command -v newuidmap
check "tmux" command -v tmux
check "screen" command -v screen
check "state root" test -d /srv/shells/state
check "user root" test -d /srv/shells/users
check "node config" test -f /etc/shells-no/node.env

printf '\nNetwork inventory\n-----------------\n'
ip -brief address || true
printf '\nDefault routes\n--------------\n'
ip route show default || true
ip -6 route show default || true

exit "$fail"
