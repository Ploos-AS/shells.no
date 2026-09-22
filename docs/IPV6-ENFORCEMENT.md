# IPv6 activation and enforcement

Allocated identities can be activated on a qualified node with:

```sh
sudo deploy/apply-ipv6-identities.sh eth0
```

The script only applies addresses already present in the allocator state and uses /128 host addresses so provider routing remains authoritative.

`deploy/render-ipv6-nft.sh` renders an nftables inventory set containing every managed customer IPv6 identity. It does **not** yet claim per-account source-address enforcement.

That distinction is security-critical: adding an address to a shared host does not by itself prevent another local user from binding that source address. Production qualification therefore requires one of:

- per-account network namespaces with explicit address ownership; or
- a verified cgroup-aware nftables/eBPF source policy.

Until that gate passes, customer IPv6 identities are considered allocated/activated but not isolation-qualified.
