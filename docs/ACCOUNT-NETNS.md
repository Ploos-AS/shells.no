# Per-account network namespaces

Shells.no uses a dedicated Linux network namespace as the ownership boundary for customer IPv6 identities.

`deploy/create-account-netns.sh LOGIN` creates `shells-UID` and places only IPv6 identities allocated to that stable account ID inside it. `deploy/qualify-account-netns.sh LOGIN` verifies that owned identities are present and identities belonging to other accounts are absent.

This is the first anti-spoofing layer, not yet a complete routed namespace. The current implementation deliberately does **not** claim Internet connectivity from the namespace. Production requires a qualified host↔namespace link/routing design, forwarding/firewall rules, DNS behavior, service execution inside the namespace, and proof that a process cannot escape the namespace or bind another account's source address.

Moving customer /128 identities off the shared host namespace is preferable to merely relying on cooperative source binding.
