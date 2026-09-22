# Managed service storage

Every persistent managed IRC service gets a predictable private storage tree under the account root:

```
/srv/shells/users/<account-id>/services/<service>/
  config/
  data/
  logs/
  run/
```

All directories are owned by the customer Unix account and mode 0700. The service root is part of account quota accounting.

## Semantics

- `config/`: persistent configuration and service-specific secrets. Backed up.
- `data/`: persistent databases, state, scripts and application data. Backed up.
- `logs/`: optional application logs. Retention policy applies; journald remains the supervisor log source.
- `run/`: ephemeral runtime files such as sockets and PID-compatible state. Not backed up.

Service definitions remain application metadata; customer state never belongs in Git.

## Backup boundary

M1 backup jobs include `config/` and `data/`. Logs are optional according to retention policy. `run/` is always excluded.

## Security

A service may access only its own account-owned storage and the paths explicitly required by its application. Managed-service installation must not create world-readable configuration or secrets.
