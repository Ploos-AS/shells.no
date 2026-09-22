# Product principles

## Mission

Build an exceptionally good dedicated IRC shell service: inexpensive to enter, secure by default, IRC-native, scriptable and able to grow from one low-cost VPS to many nodes.

## Principles

### IRC first

Shells.no is not a generic VPS reseller. IRC clients, bouncers, bots, persistent sessions, IRC networking and IRC identity are first-class product concerns.

### Affordable without being disposable

Low prices come from efficient infrastructure, automation and lightweight workloads — not from unsafe oversubscription or removing essential features.

### Start small, scale horizontally

A single inexpensive node must be useful. Growth happens primarily by adding replaceable nodes rather than requiring a large cluster on day one.

### Provider portable

No core feature may depend unnecessarily on one VPS vendor. Provider-specific IPv6, PTR, DNS and provisioning functionality belongs behind adapters.

### Real shell experience

Users should receive a useful Unix environment with SSH, tmux/screen and the curated IRC toolset. Product tiers should primarily differ by resources and service quotas rather than arbitrary removal of basic Unix functionality.

### IPv6 identity is a feature

Multiple IPv6 identities, forward DNS and vanity/vhost support are part of the IRC product experience, subject to quotas and provider capabilities.

### Secure multi-user design

Assume accounts can be compromised or malicious. Isolation, quotas, secrets handling, auditing and abuse controls are architecture requirements.

### Automation before scale

Adding customers or nodes should not require bespoke manual server configuration. Manual pilot operations are acceptable only when they define the automation that follows.

### Measure before pricing

Final plan limits and prices are based on real node benchmarks and operating costs. Headline VPS price alone does not determine profitability.
