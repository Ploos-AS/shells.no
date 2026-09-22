# Threat model

Shells.no is a hostile multi-user environment by design: customers execute approved software and connect to external networks. An account may be compromised or intentionally abusive.

## Assets

Customer credentials/configuration, other customers' data, host/control-plane credentials, backups, service availability and provider IP reputation.

## Trust boundaries

Internet -> gateway; customer session -> runtime; runtime -> host; runtime -> other users; node -> control plane; operator -> production; production -> backup storage.

## Baseline controls

- no privileged customer workloads
- no Docker/Podman control socket for customers
- separate Unix identities
- rootless containers where practical
- CPU, memory, PID and disk quotas
- restricted mounts and devices
- SSH key authentication
- brute-force/rate-limit controls
- centralized operator audit logging
- encrypted backups
- secrets outside Git
- management ports private by default
- explicit outbound abuse controls
- prompt security updates

## Abuse cases

IRC spam/flooding, compromised credentials, resource exhaustion/fork bombs, disk exhaustion, scanning, cloud metadata access, lateral movement, container escape, credential harvesting and malicious uploaded scripts.

## Production gate

No public paid launch until isolation and quota tests, backup restore, logging, abuse response and operator recovery procedures have passed.
