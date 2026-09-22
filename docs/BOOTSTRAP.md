# Node bootstrap

M1 uses a deliberately small shell bootstrap before introducing a larger configuration-management dependency.

## Target

- fresh Debian stable KVM VPS
- root access for initial bootstrap
- public IPv4
- native IPv6
- systemd and cgroups v2

## Bootstrap

Copy or clone the repository on the new node and run:

```sh
sudo sh deploy/bootstrap.sh
sudo sh deploy/qualify-node.sh
```

The bootstrap installs only the M1 base dependencies and creates the Shells.no state directories. It does not create customer accounts, open customer-facing firewall rules, install secrets, or assume a particular VPS provider.

## Idempotency

Running `bootstrap.sh` again must be safe. Package installation, directories, group creation and service enablement are repeatable operations.

## Configuration

Copy `deploy/node.example.env` to the operator's protected configuration source and populate node/provider/network identity. Secrets must not be committed to Git.

## Security boundary

The bootstrap intentionally does not add users to `docker`, `podman`, `sudo` or other privileged groups. Customer runtime setup will be handled separately and must preserve per-user isolation.

## Qualification

`qualify-node.sh` verifies the baseline locally and prints network inventory for operator review. Provider/IRC qualification is a separate test suite because it requires real public network connectivity and allocated IPv6 identities.
