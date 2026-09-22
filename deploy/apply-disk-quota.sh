#!/bin/sh
set -eu

[ "$(id -u)" -eq 0 ] || { echo "error: run as root" >&2; exit 1; }
[ "$#" -eq 1 ] || { echo "usage: $0 LOGIN" >&2; exit 2; }
login="$1"
id "$login" >/dev/null 2>&1 || { echo "error: unknown user $login" >&2; exit 1; }

LIMITS="${SHELLS_LIMITS_FILE:-/etc/shells-no/limits.env}"
[ -r "$LIMITS" ] || LIMITS="config/limits.example.env"
. "$LIMITS"

path="/srv/shells/users"
sh deploy/qualify-disk-quota.sh "$path"

fstype="$(findmnt -n -o FSTYPE -T "$path")"
soft_kb=$((SHELLS_DISK_SOFT_MB * 1024))
hard_kb=$((SHELLS_DISK_HARD_MB * 1024))

case "$fstype" in
  ext4)
    command -v setquota >/dev/null 2>&1 || {
      echo "error: setquota missing; install quota package" >&2; exit 1;
    }
    mountpoint="$(findmnt -n -o TARGET -T "$path")"
    setquota -u "$login" "$soft_kb" "$hard_kb" 0 0 "$mountpoint"
    ;;
  xfs)
    command -v xfs_quota >/dev/null 2>&1 || {
      echo "error: xfs_quota missing; install xfsprogs" >&2; exit 1;
    }
    mountpoint="$(findmnt -n -o TARGET -T "$path")"
    xfs_quota -x -c "limit bsoft=${SHELLS_DISK_SOFT_MB}m bhard=${SHELLS_DISK_HARD_MB}m $login" "$mountpoint"
    ;;
esac

echo "applied disk quota for $login: soft=${SHELLS_DISK_SOFT_MB}MB hard=${SHELLS_DISK_HARD_MB}MB"
