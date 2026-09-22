#!/bin/sh
set -eu
die(){ echo "error: $*" >&2; exit 1; }
[ "$(id -u)" -eq 0 ] || die "must run as root"
[ "$#" -eq 1 ] || die "usage: apply-ipv6-identities.sh INTERFACE"
iface="$1"
state="${SHELLS_IPV6_STATE:-/var/lib/shells-no/ipv6.json}"
command -v jq >/dev/null || die "jq required"
ip link show dev "$iface" >/dev/null 2>&1 || die "unknown interface: $iface"
[ -r "$state" ] || die "missing state: $state"

jq -r '.allocations[]?[]' "$state" | while IFS= read -r addr; do
  [ -n "$addr" ] || continue
  ip -6 addr show dev "$iface" | grep -Fq "$addr/" || ip -6 addr add "$addr/128" dev "$iface"
done

echo "IPv6 identities applied to $iface"
