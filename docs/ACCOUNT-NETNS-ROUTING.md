# Account namespace routing

`connect-account-netns.sh` creates a deterministic veth pair for an existing account namespace. A private IPv4 /30 is used only as host↔namespace transit; customer IRC identity remains the allocated routed IPv6 /128s.

The namespace receives a default route through the host. Host IPv4 and IPv6 forwarding are enabled. `render-account-netns-nft.sh` supplies a deny-by-default forwarding baseline that permits established traffic and new traffic originating from Shells.no account veth interfaces.

This is still a qualification-stage design. Production must additionally verify provider IPv6 routing to namespace-owned /128s, explicit routes/proxy-NDP where required, DNS, IPv4 egress/NAT policy, per-account anti-spoof rules, persistence across reboot, and that managed services execute inside their assigned namespace.
