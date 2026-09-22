#!/bin/sh
set -eu
grep -q 'ip netns add' deploy/create-account-netns.sh
grep -q 'allocations\[\$aid\]' deploy/create-account-netns.sh
grep -q 'select(.key != \$aid)' deploy/qualify-account-netns.sh
grep -q 'FAIL foreign' deploy/qualify-account-netns.sh
echo "PASS account netns static checks"
