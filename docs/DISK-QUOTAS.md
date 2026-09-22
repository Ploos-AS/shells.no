# Disk quotas

Shells.no must prevent one customer from exhausting node storage. M1 supports host filesystem user quotas for ext4 and XFS.

## Why qualify first

VPS images differ in filesystem, mount layout and enabled features. The repository must not blindly rewrite `/etc/fstab` or remount the provider's root filesystem.

Run:

```sh
sudo sh deploy/qualify-disk-quota.sh
```

The script reports the filesystem and whether user quota support is already enabled.

## Supported M1 paths

### ext4

The filesystem containing `/srv/shells/users` must have user quotas enabled. The node also needs the Debian `quota` package.

### XFS

The filesystem must be mounted with user quota support and the node needs `xfsprogs`.

## Apply

After qualification:

```sh
sudo sh deploy/apply-disk-quota.sh alice
```

Limits come from `/etc/shells-no/limits.env` or the repository example policy.

## Safety

Quota enablement itself is an operator/bootstrap concern because changing root filesystem mount options can require a reboot and is provider/image dependent. Shells.no therefore detects and verifies the capability but does not make potentially destructive filesystem changes automatically.

## M1 acceptance

A real pilot node must demonstrate that a test account can write up to its configured allowance, receives quota errors at the hard limit, and cannot cause another account or the host to lose its reserved operational headroom.
