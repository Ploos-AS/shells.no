#!/bin/sh
set -eu
die(){ echo "error: $*" >&2; exit 1; }
[ "$(id -u)" -eq 0 ] || die "must run as root"
[ "$#" -eq 1 ] || die "usage: create-account-netns.sh LOGIN"
login="$1"; id "$login" >/dev/null 2>&1 || die "unknown account"
uid="$(id -u "$login")"; aid="u-$uid"; ns="shells-$uid"
state="${SHELLS_IPV6_STATE:-/var/lib/shells-no/ipv6.json}"
command -v jq >/dev/null || die "jq required"
[ -r "$state" ] || die "missing IPv6 allocation state"
ip netns list | awk '{print $1}' | grep -Fxq "$ns" || ip netns add "$ns"
ip -n "$ns" link set lo up
# Move only account-owned /128 identities into the namespace.
jq -r --arg aid "$aid" '.allocations[$aid][]?' "$state" | while IFS= read -r addr; do
  [ -n "$addr" ] || continue
  if ip -6 addr show | grep -Fq "$addr/"; then ip -6 addr del "$addr/128" dev "${SHELLS_IPV6_INTERFACE:-eth0}" || true; fi
  ip -n "$ns" -6 addr show dev lo | grep -Fq "$addr/" || ip -n "$ns" -6 addr add "$addr/128" dev lo
done
echo "$ns"
