#!/bin/sh
set -eu
grep -q "sha256sum" bin/shells-backup
grep -q "services/\*/run" bin/shells-backup
grep -q "services/\*/logs" bin/shells-backup
grep -q "sha256sum -c" bin/shells-restore
grep -q "unsafe archive path" bin/shells-restore
echo "PASS backup/restore static checks"
