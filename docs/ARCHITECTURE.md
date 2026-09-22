# Architecture

## Goal

Shells.no provides low-cost hosted Unix/IRC environments that can grow from one VPS to multiple nodes without redesigning the service.

## Planes

**Access:** SSH is primary. HTTPS is reserved for future account management, documentation and API access.

**Control:** owns account metadata, node placement, desired service state, provisioning and lifecycle operations. Customer workloads never receive control-plane credentials.

**Nodes:** replaceable VPS hosts running the approved Shells.no stack. Nodes host isolated customer environments and report capacity and health.

**Workloads:** IRC clients, bouncers and bots are sourced from or aligned with Ploos `ircsh`. Workloads should be OCI-reproducible; persistent data lives outside ephemeral layers.

## Initial node model

M0/M1 targets ordinary Linux VPS hosts and rootless Podman where practical. Kubernetes is intentionally not a prerequisite. Each customer receives a distinct Unix identity and isolation boundary with CPU, memory, PID and storage policy.

## Networking

IPv6 is first-class. Stable per-account/per-service IPv6 can be supported where provider allocations permit. IPv4 may be shared. Management interfaces are private by default.

## Persistence and secrets

Persistent data is divided into configuration, user data and service state. Secrets are provisioned separately and never committed to Git.

## Scaling

Start with one production node, but never encode an assumption that it is the only node. Add nodes when capacity thresholds are reached and place new accounts accordingly. Live migration is not an M0 requirement.

## Observability and backups

Nodes expose operator health and capacity signals. Backups must be encrypted, restorable and tested; a backup is not considered functional until a restore succeeds.

## Dependency boundary

Shells.no orchestrates hosted lifecycle. Component build/runtime work belongs in `ircsh` or the appropriate Ploos component repository whenever practical.
