#!/bin/sh
set -eu
grep -q 'type veth' deploy/connect-account-netns.sh
grep -q 'route replace default' deploy/connect-account-netns.sh
grep -q 'net.ipv6.conf.all.forwarding=1' deploy/connect-account-netns.sh
grep -q 'policy drop' deploy/render-account-netns-nft.sh
grep -q 'ct state established,related' deploy/render-account-netns-nft.sh
echo "PASS account netns routing static checks"
