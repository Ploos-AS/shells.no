#!/bin/sh
set -eu

path="${1:-/srv/shells/users}"
[ -d "$path" ] || { echo "FAIL  missing path: $path"; exit 1; }

fstype="$(findmnt -n -o FSTYPE -T "$path")"
opts="$(findmnt -n -o OPTIONS -T "$path")"
source="$(findmnt -n -o SOURCE -T "$path")"

echo "Shells.no disk quota qualification"
echo "filesystem=$fstype"
echo "source=$source"
echo "options=$opts"

case "$fstype" in
  ext4)
    echo "$opts" | grep -Eq '(^|,)(usrquota|usrjquota=)' && {
      echo "PASS  ext4 user quota mount option present"; exit 0;
    }
    echo "FAIL  ext4 filesystem lacks user quota mount option"
    echo "ACTION enable usrquota for the filesystem containing $path and reboot/remount"
    exit 1
    ;;
  xfs)
    echo "$opts" | grep -Eq '(^|,)(uquota|usrquota)(,|$)' && {
      echo "PASS  XFS user quotas enabled"; exit 0;
    }
    echo "FAIL  XFS filesystem lacks user quota support"
    echo "ACTION enable uquota/usrquota at mount time"
    exit 1
    ;;
  *)
    echo "FAIL  M1 quota automation currently supports ext4 or XFS, found $fstype"
    exit 1
    ;;
esac
