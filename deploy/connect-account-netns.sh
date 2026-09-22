#!/bin/sh
set -eu
die(){ echo "error: $*" >&2; exit 1; }
[ "$(id -u)" -eq 0 ] || die "must run as root"
[ "$#" -eq 1 ] || die "usage: connect-account-netns.sh LOGIN"
login="$1"; uid="$(id -u "$login")"; ns="shells-$uid"
ip netns list | awk '{print $1}' | grep -Fxq "$ns" || die "namespace missing: $ns"
host="shh$uid"; peer="shn$uid"
# Deterministic RFC1918 transit /30 derived from UID. This is transport only;
# customer-visible IRC identity remains routed IPv6.
oct3=$(( (uid / 64) % 256 )); block=$(( (uid % 64) * 4 ))
host4="10.250.$oct3.$((block+1))/30"; peer4="10.250.$oct3.$((block+2))/30"
ip link show "$host" >/dev/null 2>&1 || {
  ip link add "$host" type veth peer name "$peer"
  ip link set "$peer" netns "$ns"
}
ip addr replace "$host4" dev "$host"; ip link set "$host" up
ip -n "$ns" addr replace "$peer4" dev "$peer"; ip -n "$ns" link set "$peer" up
ip -n "$ns" route replace default via "10.250.$oct3.$((block+1))" dev "$peer"
sysctl -qw net.ipv4.ip_forward=1
sysctl -qw net.ipv6.conf.all.forwarding=1
echo "$ns connected via $host/$peer"
