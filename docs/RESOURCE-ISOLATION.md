# Per-account resource isolation

M1 applies resource policy at the systemd `user-UID.slice` boundary. This covers the customer's interactive sessions and user services under the same account rather than relying only on individual container limits.

## Test policy

`config/limits.example.env` contains deliberately conservative M1 test values:

- 512 MiB memory maximum
- 448 MiB memory high watermark
- 256 tasks
- 50% of one CPU worth of quota
- 4 GiB disk soft target / 4.5 GiB hard target
- 4 IPv6 identities
- 4 managed services

These values exist to prove enforcement. They are not final Shells.no plans.

## Apply

Install the example limits on the node as `/etc/shells-no/limits.env`, then:

```sh
sudo sh deploy/install-account-limits.sh alice
sudo sh deploy/install-account-limits.sh bob
sudo sh deploy/verify-account-isolation.sh alice bob
```

## Boundary

The primary M1 boundary is the Unix UID plus systemd user slice. Rootless containers can add process/filesystem isolation for managed services, but they are not a substitute for host-level account resource limits.

## Disk quotas

Disk limits are recorded in the policy but are not yet claimed as enforced. Filesystem quota setup depends on the VPS filesystem/storage layout and must be qualified explicitly before M1 passes.

## Linger

Managed IRC services need to survive SSH logout. `loginctl enable-linger` is therefore enabled for managed accounts. This makes CPU/RAM/PID limits especially important because customer services can remain active indefinitely.

## Acceptance

Two test users must be unable to read each other's private homes/data, both must have systemd slice policies, and stress testing must demonstrate memory/task/CPU enforcement without destabilizing the node.
