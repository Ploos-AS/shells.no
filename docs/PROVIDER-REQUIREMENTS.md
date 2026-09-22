# VPS Provider Qualification Requirements

Shells.no is designed to start small on inexpensive VPS nodes and scale horizontally by adding nodes. Price matters, but a provider is usable only when the Shells.no workload is permitted and the networking model works for IRC.

## Hard requirements

- commercial multi-user Unix shell hosting is permitted
- IRC clients, bouncers and bots are permitted
- multiple customers may make outbound IRC connections
- at least one public IPv4 address per production node
- native IPv6 with multiple simultaneously usable source addresses
- KVM or equivalent isolation suitable for modern Linux
- Debian-compatible Linux and cgroups v2
- customer workloads can run with the Shells.no isolation model
- abuse reports provide a workable operational process
- no prohibition on our managed/containerized multi-user model

A provider that fails a hard requirement is not production-qualified.

## Strong preferences

- routed IPv6 /64 or larger
- IPv4 included in base price
- PTR/rDNS control for individual IPv4 and IPv6 addresses
- delegated IPv6 reverse DNS, or API-driven PTR management
- API and/or Terraform/OpenTofu support
- cloud-init
- snapshots and rescue console
- provider firewall
- European locations
- high traffic allowance and good peering
- month-to-month billing
- easy horizontal scaling
- predictable pricing
- volume options when the service grows

## IRC qualification tests

Before production qualification, a test node should verify:

1. IPv4 IRC connectivity and reconnect behaviour.
2. Native IPv6 IRC connectivity.
3. Multiple simultaneous IPv6 source addresses.
4. Forward and reverse DNS behaviour.
5. Long-lived IRC connections without provider-induced idle/session timeouts.
6. Representative clients: Irssi, WeeChat and BitchX.
7. Representative bouncers from the ircsh catalog.
8. Representative bots from the ircsh catalog.
9. Rootless/container isolation and cgroup quotas.
10. Backup and restore.
11. Resource exhaustion controls.
12. Abuse-response contact/process.

## Qualification states

- `CANDIDATE` — identified but not sufficiently investigated.
- `CONTACTED` — pre-sales/abuse-policy clarification requested.
- `PILOT` — promising enough for a test VPS.
- `QUALIFIED` — policy and technical qualification passed.
- `REJECTED` — one or more hard requirements failed.

## Cost target

The initial target is a low fixed monthly node cost, ideally below roughly EUR 10 before optional backup services, while still satisfying the hard requirements. Cost per usable customer matters more than headline VPS price.
