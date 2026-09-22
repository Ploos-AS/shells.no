#!/bin/sh
set -eu
f=bin/shells-key
test -f "$f"
grep -q 'ssh-keygen -lf' "$f"
grep -q 'chmod 0600' "$f"
grep -q '0700' "$f"
grep -q 'rotation complete' "$f"
echo "PASS SSH key lifecycle static checks"
