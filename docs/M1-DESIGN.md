# M1 — Single-node prototype design

M1 turns the M0 contracts into a reproducible single-node Shells.no prototype.

## Baseline

The reference node targets **Debian stable** on a KVM VPS. Debian is the production preference. **Ubuntu LTS** is the secondary compatibility target and may be used only when a provider does not support a suitable Debian image.

The baseline requires:

- one public IPv4
- native IPv6 with multiple usable source addresses
- systemd
- cgroups v2
- nftables
- rootless Podman where practical
- OpenSSH
- persistent local storage plus off-node backup target

Provider-specific setup must remain outside the core node model.

## Node roles

The first node combines roles for economy:

1. SSH access gateway
2. account/runtime host
3. local provisioning agent
4. metrics/log exporter
5. backup client

The interfaces between these roles must still be explicit so they can be separated later.

## Account model

Every customer gets a unique Unix account and an immutable internal account ID. Display/login names are not used as database identities.

Suggested layout:

```text
/home/<login>/
/srv/shells/users/<id>/
  config/
  data/
  services/
  backups/
```

Customer processes run under their own UID. No customer belongs to privileged runtime groups.

## Service model

A service is a managed instance of a catalog component.

```text
account
  +-- interactive shell
  +-- client: irssi
  +-- client: weechat
  +-- bouncer: znc
  +-- bot: eggdrop
```

The catalog should reuse `ircsh` definitions rather than duplicate component-specific knowledge.

## Resource policy

M1 must demonstrate enforceable limits for:

- memory
- CPU
- PIDs
- disk usage
- number of managed services
- number of assigned IPv6 identities

Plans are not finalized in M1; limits are technical test values.

## Networking

The node owns its public IPv4 and assigned IPv6 range/pool. The platform allocates IPv6 identities from that pool and records ownership.

A service must bind only addresses allocated to its account. Arbitrary source-address use is prohibited.

DNS/PTR automation is provider-dependent and belongs behind an adapter.

## Provisioning flow

```text
shells-admin account create pgo
        |
        +-- allocate account ID/UID
        +-- create home/data directories
        +-- install SSH key
        +-- apply quotas/cgroup policy
        +-- allocate network identity
        +-- write desired state
        +-- verify login/runtime
```

All operations should be safely repeatable.

## M1 acceptance

M1 passes when a fresh supported VPS can be bootstrapped reproducibly, two isolated test accounts can log in over SSH, resource limits are demonstrated, representative IRC workloads run over IPv4 and IPv6, one account cannot access another account's data/runtime, and backup/restore succeeds.
