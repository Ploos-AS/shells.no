#!/bin/sh
set -eu
cat <<'EOF'
table inet shells_netns {
  chain forward {
    type filter hook forward priority filter; policy drop;
    ct state established,related accept
    iifname "shh*" ct state new accept
  }
}
EOF
