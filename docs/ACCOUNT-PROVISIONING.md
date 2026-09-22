# Account provisioning

M1 introduces a minimal operator CLI, `bin/shells-admin`.

## Create an account

```sh
sudo bin/shells-admin account create alice /root/alice.pub
```

The operation:

- validates the login name
- creates a dedicated Unix user
- uses the unprivileged `shells-users` group
- creates a private home directory
- creates private account data directories under `/srv/shells/users/u-UID/`
- records immutable account identity under `/srv/shells/state/accounts/`
- optionally installs an SSH public key
- locks password authentication for the account

The numeric UID-derived M1 account ID is deliberately separate from the login name so later display/login renames do not define storage ownership.

## Inspect

```sh
sudo bin/shells-admin account show alice
```

## Security properties

Customer directories are mode 0700. Customers are not added to sudo or container-administration groups. Password login is locked by default; the initial M1 path is SSH public keys.

Account creation currently requires root because it creates Unix identities. The future control plane should invoke a narrowly scoped privileged provisioning component rather than exposing general root access.

## Not implemented yet

- deletion/suspension lifecycle
- SSH key add/remove/rotation commands
- UID allocation independent of local useradd
- disk quotas
- cgroup limits
- IPv6 identity allocation
- service catalog provisioning
- desired-state reconciliation

These are intentionally separate milestones so their security behaviour can be tested independently.
