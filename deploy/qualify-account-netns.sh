#!/bin/sh
set -eu
[ "$#" -eq 1 ] || { echo "usage: qualify-account-netns.sh LOGIN" >&2; exit 1; }
login="$1"; uid="$(id -u "$login")"; aid="u-$uid"; ns="shells-$uid"
state="${SHELLS_IPV6_STATE:-/var/lib/shells-no/ipv6.json}"
ip netns list | awk '{print $1}' | grep -Fxq "$ns" || { echo "FAIL namespace"; exit 1; }
fail=0
for addr in $(jq -r --arg aid "$aid" '.allocations[$aid][]?' "$state"); do
  if ip -n "$ns" -6 addr show | grep -Fq "$addr/"; then echo "PASS owned $addr"; else echo "FAIL missing $addr"; fail=1; fi
done
for addr in $(jq -r --arg aid "$aid" '.allocations | to_entries[] | select(.key != $aid) | .value[]?' "$state"); do
  if ip -n "$ns" -6 addr show | grep -Fq "$addr/"; then echo "FAIL foreign $addr"; fail=1; fi
done
[ "$fail" -eq 0 ] && echo "PASS namespace address ownership"
exit "$fail"
