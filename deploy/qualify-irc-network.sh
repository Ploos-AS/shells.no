#!/bin/sh
set -eu
die(){ echo "error: $*" >&2; exit 1; }
host="${IRC_TEST_HOST:-}"
port="${IRC_TEST_PORT:-6697}"
source6="${IRC_SOURCE_IPV6:-}"
[ -n "$host" ] || die "set IRC_TEST_HOST to an approved IRC test endpoint"

pass=0; fail=0
check(){ name="$1"; shift; if "$@" >/dev/null 2>&1; then echo "PASS $name"; pass=$((pass+1)); else echo "FAIL $name"; fail=$((fail+1)); fi; }

command -v nc >/dev/null 2>&1 || die "nc is required"
command -v openssl >/dev/null 2>&1 || die "openssl is required"

check dns getent ahosts "$host"
check ipv4 nc -4 -z -w 10 "$host" "$port"
check ipv6 nc -6 -z -w 10 "$host" "$port"
check tls sh -c "printf '' | openssl s_client -connect '$host:$port' -servername '$host' -verify_return_error >/dev/null 2>&1"

if [ -n "$source6" ]; then
  ip -6 addr show | grep -Fq "$source6" || die "IRC_SOURCE_IPV6 is not configured locally"
  check ipv6-source nc -6 -s "$source6" -z -w 10 "$host" "$port"
else
  echo "SKIP ipv6-source (set IRC_SOURCE_IPV6)"
fi

echo "PASS=$pass FAIL=$fail"
[ "$fail" -eq 0 ]
