# IRC managed-service catalog

Shells.no is IRC-first. The initial catalog deliberately covers classic shell usage as well as persistent bouncers and bots.

The reusable application definitions belong in the Ploos-AS `ircsh` project. Shells.no owns hosting concerns: account placement, quotas, persistence, network identity, backups, monitoring and lifecycle operations.

## Initial catalog

Clients: Irssi, WeeChat and BitchX.

Bouncers: ZNC, soju, psyBNC, muh and shroudBNC (sBNC). shroudBNC is treated as a legacy/classic service and requires enhanced build, runtime and security qualification before production use.

Bots: Eggdrop, EnergyMech, Limnoria, Sopel, Dancer and Psotnic. Dancer is treated as a legacy/classic service and requires enhanced build, runtime and security qualification before production use.

## Persistence

Interactive clients initially use tmux-style persistent sessions. Long-running bouncers and bots should use per-user systemd services so they remain supervised after SSH logout. Account linger is already enabled by provisioning.

## Network identity

Every managed service must eventually be able to request an allocated Shells.no IPv6 identity. Binding is explicit and must never silently consume another customer's address. IPv4 remains available through the node's shared/public IPv4 policy.

## Security

Managed services inherit the customer's user slice CPU, memory and PID controls. No service receives root, privileged containers, the Docker socket, arbitrary host mounts or host networking by default.

## Qualification

A service moves from `planned` to `qualified` only after installation, start/stop/restart, persistence, reconnect, IPv4, IPv6, resource-limit and backup/restore tests pass on a qualified node.
