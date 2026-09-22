#!/bin/sh
set -eu
f=bin/shells-ipv6
grep -q "ipaddress.ip_network" "$f"
grep -q "u-" "$f"
grep -q "ipv6.json" "$f"
grep -q "Reserve the first 16" "$f"
grep -q "count must be 1..256" "$f"
echo "PASS IPv6 allocator static checks"
