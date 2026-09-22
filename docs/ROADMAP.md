# Roadmap

## M0 — Bootstrap

- [x] establish Shells.no brand/repository
- [x] define SSH-first product direction
- [x] define relationship with `ircsh`
- [x] document control/node/workload architecture
- [x] document threat model
- [x] define inexpensive horizontal VPS scaling
- [x] add repository validation CI

## M1 — Single-node prototype

- [ ] choose supported Linux baseline
- [ ] repeatable node bootstrap
- [ ] account provisioning
- [ ] per-user isolation and quotas
- [ ] initial `ircsh` client/bouncer/bot catalog
- [ ] persistent home/service storage
- [ ] SSH key lifecycle
- [ ] backup + restore test
- [ ] health/capacity report
- [ ] operator CLI

## M2 — Pilot

- [ ] provisioning API and desired-state model
- [ ] second-node placement
- [ ] Prometheus-compatible metrics
- [ ] centralized logs/audit events
- [ ] abuse controls/runbook
- [ ] IPv6 allocation model
- [ ] automated upgrades with rollback
- [ ] pilot documentation

## M3 — Hosted beta

- [ ] customer self-service
- [ ] plan/quota model
- [ ] billing integration boundary
- [ ] encrypted off-node backups and restore automation
- [ ] status page integration
- [ ] terms/AUP/privacy operational checklist
- [ ] production security qualification

## Future

BBS, retro-development and developer shell profiles may follow, but must not delay a small, reliable IRC service.
