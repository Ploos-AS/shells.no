# Shells.no

**IRC shells for humans.**  
Hosted by **Ploos AS**.

Shells.no is a modern, security-focused hosted shell service built around the IRC ecosystem: classic Unix shell access plus reproducible, isolated runtimes for IRC clients, bouncers and bots.

## M0 scope

M0 establishes the platform contract and repository structure. The first service profile is IRC hosting:

- irssi, WeeChat and BitchX-class clients
- bouncers and bots from the Ploos `ircsh` ecosystem
- SSH-first access
- per-user isolation and resource limits
- reproducible OCI workloads
- backups, health checks and observability hooks
- inexpensive VPS nodes that scale horizontally without requiring Kubernetes

## Principles

1. **SSH first** — `ssh user@shells.no` is the primary experience.
2. **Isolation by default** — no privileged customer workloads, runtime sockets or unrestricted host mounts.
3. **Small-node friendly** — start on an inexpensive VPS and add nodes as demand grows.
4. **Scriptable** — provisioning and service management are automatable.
5. **Reuse ircsh** — reuse existing Ploos IRC component work wherever practical.
6. **IPv6 first-class** — stable IPv6 identities where provider allocations permit.
7. **No secrets in Git.**
8. **Observable** — health, capacity and abuse signals are measurable before launch.

## Architecture

```text
shells.no -> SSH/HTTPS gateway -> provisioning
                                  |
                     +------------+------------+
                     |                         |
                  shell01                  shell02 ...
                     |                         |
              isolated users             isolated users
                     |                         |
             clients/bouncers/bots      clients/bouncers/bots
```

M0 deliberately avoids Kubernetes. Start with independently manageable VPS nodes and add centralized metadata/provisioning incrementally.

`shells.no` is the hosted-service/platform repository. `ircsh` remains the reusable component layer.

See [Architecture](docs/ARCHITECTURE.md), [Threat model](docs/THREAT-MODEL.md), and [Roadmap](docs/ROADMAP.md).

## Status

**M0 — bootstrap / architecture baseline**

## License

MIT for software in this repository unless a subdirectory explicitly states otherwise. Third-party components retain their upstream licenses.
