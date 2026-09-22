# IRC network qualification

Run this only against an IRC endpoint that permits qualification traffic.

```sh
IRC_TEST_HOST=irc-test.example.net IRC_TEST_PORT=6697 \
  deploy/qualify-irc-network.sh
```

To verify that a provisioned vanity/source IPv6 can originate the connection:

```sh
IRC_SOURCE_IPV6=2001:db8::1234 IRC_TEST_HOST=irc-test.example.net \
  deploy/qualify-irc-network.sh
```

The runner checks DNS resolution, IPv4 TCP reachability, IPv6 TCP reachability, TLS certificate validation with SNI, and optional explicit IPv6 source binding.

This is deliberately transport-level qualification. Bot/client-specific IRC registration, SASL, reconnect behavior, flood limits and long-lived connection soak are separate gates. Do not point automated tests at public IRC networks without permission.
