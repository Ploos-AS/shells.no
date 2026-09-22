#!/bin/sh
set -eu
f=bin/shells-service
test -f "$f"
for op in install start stop restart status logs; do grep -q "$op" "$f"; done
grep -q 'NoNewPrivileges=yes' "$f"
grep -q 'PrivateTmp=yes' "$f"
grep -q 'Restart=on-failure' "$f"
grep -q 'znc)' "$f"
grep -q 'service_root=' "$f"
for d in config data logs run; do grep -q "$d" "$f"; done
grep -q 'SHELLS_CONFIG_DIR' "$f"
grep -q 'SHELLS_DATA_DIR' "$f"
echo "PASS managed-service static checks"
