# Capacity and cost model

Shells.no should price from measured capacity rather than guesses.

## Node cost

Track the complete recurring cost:

- VPS
- public IPv4
- storage
- snapshots/backups
- traffic overages
- monitoring/auxiliary services
- payment/provider overhead where applicable

## Capacity signals

Placement decisions should consider at least:

- memory committed and actually used
- CPU load/steal
- PID count
- disk quota and I/O
- network usage
- IPv6 identity pool usage
- number and type of managed IRC services

Account count alone is not a sufficient capacity metric.

## Headroom

Production nodes must retain operational headroom. New-account placement should stop before resource exhaustion and continue on another node.

Exact thresholds are an M1/M2 benchmark output, not an M0 assumption.

## Pricing objective

Keep infrastructure cost a minority of recurring revenue at normal utilization so there is room for backup, support, payment fees, abuse handling, taxes and spare capacity.

No free plan is assumed. A low-cost paid entry plan can reduce abuse while keeping the service accessible.

## Benchmark workload

M1 should create repeatable idle and active profiles covering representative clients, bouncers and bots from the ircsh catalog. Results will drive plan limits and the first production-node size.
