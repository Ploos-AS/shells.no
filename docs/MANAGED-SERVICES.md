# Managed service lifecycle

M1 now has a common operator lifecycle for persistent IRC services:

```sh
sudo bin/shells-service install alice znc
sudo bin/shells-service start alice znc
sudo bin/shells-service status alice znc
sudo bin/shells-service restart alice znc
sudo bin/shells-service logs alice znc
sudo bin/shells-service stop alice znc
```

ZNC is the first executable reference implementation. Other catalog entries remain declared but are not runtime-qualified yet.

The host supplies the binary while the service runs as the customer Unix account under its systemd user manager. Linger provides persistence after SSH logout. The unit uses restart-on-failure, NoNewPrivileges, a private temporary directory and read-only system paths. Account CPU, memory and PID limits remain enforced by user-UID.slice.

Before ZNC becomes qualified it must pass real VPS tests for configuration, lifecycle, reboot persistence, reconnect, IPv4, explicitly bound IPv6, resource limits, logging, backup and restore. The same lifecycle will then be extended to the remaining bouncers and bots.
