#!/bin/sh
set -eu
f=deploy/qualify-bots.sh
for bot in eggdrop energymech psotnic limnoria sopel; do grep -q "$bot" "$f"; done
grep -q "SERVICE_BINARY" "$f"
grep -q "config" "$f"
grep -q "data" "$f"
grep -q "Network, isolation, restore and soak" "$f"
echo "PASS bot qualification runner static checks"
