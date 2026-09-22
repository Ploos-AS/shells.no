#!/bin/sh
set -eu

f=bin/shells-admin
test -f "$f"
grep -q "valid_login" "$f"
grep -q "useradd --create-home" "$f"
grep -q "passwd -l" "$f"
grep -q "authorized_keys" "$f"
grep -q "0700" "$f"

# Guard against accidentally granting obvious privileged groups.
if grep -E 'usermod.*(sudo|docker|podman)|useradd.*-G.*(sudo|docker|podman)' "$f"; then
  echo "privileged customer group assignment detected" >&2
  exit 1
fi

echo "PASS account provisioning static checks"
