# IRC bot qualification matrix

Shells.no treats IRC bots as first-class managed services. A catalog entry is not production-ready until it passes the reference-node qualification.

## Initial bot set

- Eggdrop
- EnergyMech
- Psotnic
- Limnoria
- Sopel

## Qualification gates

Each bot must pass:

1. install/build on the Debian stable reference node;
2. unprivileged execution as the customer Unix account;
3. managed lifecycle through `shells-service`;
4. persistent config/data layout and clean restart;
5. CPU, memory, PID and disk limits;
6. IPv4 IRC connection;
7. IPv6 IRC connection and explicit source-address binding where supported;
8. TLS and certificate validation;
9. reconnect after IRC/network interruption;
10. no access to another account's service tree;
11. backup plus restore of persistent bot state;
12. log/journal behavior without leaking secrets;
13. 24-hour soak test before production qualification.

## Status vocabulary

- CATALOGUED: definition exists.
- BUILD-PASS: installation/build works on reference Debian.
- RUNTIME-PASS: lifecycle and persistence pass.
- NETWORK-PASS: IPv4/IPv6/TLS/reconnect pass.
- ISOLATION-PASS: account/resource/security checks pass.
- RESTORE-PASS: backup/restore test passes.
- SOAK-PASS: 24-hour soak passes.
- QUALIFIED: all required gates pass.

No bot is advertised as production-qualified solely because a service definition exists.
