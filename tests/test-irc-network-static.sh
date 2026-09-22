#!/bin/sh
set -eu
f=deploy/qualify-irc-network.sh
grep -q "nc -4" "$f"
grep -q "nc -6" "$f"
grep -q "openssl s_client" "$f"
grep -q "IRC_SOURCE_IPV6" "$f"
grep -q "verify_return_error" "$f"
echo "PASS IRC network qualification static checks"
