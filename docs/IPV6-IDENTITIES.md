# IPv6 identity allocation

Shells.no can allocate stable IPv6 identities from a routed node prefix without hard-coding provider-specific addressing.

```sh
sudo SHELLS_IPV6_PREFIX=2001:db8:1234:5678::/64 \
  bin/shells-ipv6 allocate alice --count 4
bin/shells-ipv6 list alice
sudo bin/shells-ipv6 release alice
```

The allocator stores state in `/var/lib/shells-no/ipv6.json` mode 0600 and keys allocations by stable account ID (`u-UID`). The first 16 host IDs are reserved for node/infrastructure use.

This command allocates identities in Shells.no state only. A separate privileged network-apply layer must add/remove addresses on the node, enforce ownership and anti-spoofing, and integrate provider DNS/PTR APIs. Allocation alone must never be presented as proof that an address is routed or usable.

The provider must delegate or route the configured prefix to the node. Production pools should normally be substantially larger than /112; the /112 limit here is only a guard against accidentally treating a tiny prefix as a customer pool.
