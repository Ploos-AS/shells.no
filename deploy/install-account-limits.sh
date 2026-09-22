#!/bin/sh
set -eu

[ "$(id -u)" -eq 0 ] || { echo "error: run as root" >&2; exit 1; }
[ "$#" -eq 1 ] || { echo "usage: $0 LOGIN" >&2; exit 2; }
login="$1"
id "$login" >/dev/null 2>&1 || { echo "error: unknown user $login" >&2; exit 1; }

LIMITS="${SHELLS_LIMITS_FILE:-/etc/shells-no/limits.env}"
[ -r "$LIMITS" ] || LIMITS="config/limits.example.env"
. "$LIMITS"

uid="$(id -u "$login")"
dropin="/etc/systemd/system/user-$uid.slice.d"
install -d -m 0755 "$dropin"

cat >"$dropin/50-shells-no.conf" <<EOF
[Slice]
MemoryHigh=$SHELLS_MEMORY_HIGH
MemoryMax=$SHELLS_MEMORY_MAX
TasksMax=$SHELLS_TASKS_MAX
CPUQuota=$SHELLS_CPU_QUOTA
EOF

systemctl daemon-reload

# Persist non-system customer user managers so managed services can run
# without an active SSH session.
loginctl enable-linger "$login"

echo "installed cgroup limits for $login (user-$uid.slice)"
echo "disk quota target: soft=${SHELLS_DISK_SOFT_MB}MB hard=${SHELLS_DISK_HARD_MB}MB"
echo "note: filesystem quota enforcement is qualified separately"
