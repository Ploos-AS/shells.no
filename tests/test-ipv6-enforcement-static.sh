#!/bin/sh
set -eu
grep -q 'ip -6 addr add' deploy/apply-ipv6-identities.sh
grep -q 'allocations' deploy/apply-ipv6-identities.sh
grep -q 'managed_ipv6' deploy/render-ipv6-nft.sh
grep -q 'not claimed' deploy/render-ipv6-nft.sh
echo "PASS IPv6 activation/enforcement static checks"
