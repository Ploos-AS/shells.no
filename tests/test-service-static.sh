#!/bin/sh
set -eu
f=bin/shells-service
test -f "$f"
for op in install start stop restart status logs; do grep -q "$op" "$f"; done
grep -q 'NoNewPrivileges=yes' "$f"
grep -q 'PrivateTmp=yes' "$f"
grep -q 'Restart=on-failure' "$f"
grep -q 'znc)' "$f"
echo "PASS managed-service static checks"
