# SSH key lifecycle

Shells.no uses SSH public keys as the M1 account authentication mechanism. Password login for provisioned accounts remains locked.

## Commands

```sh
sudo bin/shells-key add alice alice-laptop.pub
bin/shells-key list alice
sudo bin/shells-key remove alice SHA256:...
sudo bin/shells-key rotate alice SHA256:old... alice-new.pub
```

Keys are identified by OpenSSH fingerprints rather than comments or filenames.

## Rotation

Rotation installs and validates the new public key before removing the old fingerprint. This ordering reduces the chance of accidental lockout.

## Permissions

`.ssh` is mode 0700 and `authorized_keys` is mode 0600, owned by the customer account.

## Future

The hosted control plane should expose key management without exposing filesystem access or privileged commands. Audit events, key labels, expiry policy and optional hardware-backed/WebAuthn administrative authentication belong to later milestones.
