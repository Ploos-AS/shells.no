#!/bin/sh
set -eu
state="${SHELLS_IPV6_STATE:-/var/lib/shells-no/ipv6.json}"
[ -r "$state" ] || { echo "missing state: $state" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq required" >&2; exit 1; }

cat <<'EOF'
table inet shells_no {
  set managed_ipv6 {
    type ipv6_addr
    flags interval
    elements = {
EOF
jq -r '[.allocations[]?[]] | unique | .[]' "$state" | awk '{printf "      %s,\n",$0}'
cat <<'EOF'
    }
  }

  chain output_guard {
    type filter hook output priority filter - 5; policy accept;
    # Inventory set for M1. Per-account ownership enforcement requires
    # cgroup/meta-cgroup matching or isolated network namespaces and is
    # intentionally not claimed by this ruleset.
  }
}
EOF
