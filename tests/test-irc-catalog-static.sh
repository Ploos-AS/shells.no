#!/bin/sh
set -eu
f=catalog/irc.yaml
test -f "$f"
for id in irssi weechat bitchx znc soju psybnc muh shroudbnc eggdrop energymech limnoria sopel dancer psotnic; do
  grep -q "id: $id" "$f" || { echo "FAIL missing $id"; exit 1; }
done
grep -q 'ipv6_identity_aware: true' "$f"
grep -q 'privileged_services: false' "$f"
echo "PASS IRC catalog static checks"
