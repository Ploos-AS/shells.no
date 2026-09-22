# Backup and restore

M1 provides local account backup and restore primitives. They are intentionally simple so the same archive can later be copied to encrypted off-node storage.

```sh
sudo bin/shells-backup alice
sudo bin/shells-restore alice /srv/shells/backups/u-1001/20260922T120000Z.tar.gz
```

Backups include account `config/`, `data/` and persistent managed-service trees. Per-service `run/` is excluded. Application `logs/` are excluded from the M1 archive by default.

Each archive receives a SHA-256 checksum. Restore verifies it before extraction and rejects absolute or parent-traversal archive paths.

A local archive is not sufficient production disaster recovery. M1 acceptance still requires copying backups off-node, encryption at rest, retention/pruning policy, and a demonstrated restore onto a clean qualified node.
