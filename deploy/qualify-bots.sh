#!/bin/sh
set -eu

die(){ echo "error: $*" >&2; exit 1; }
[ "$#" -ge 1 ] || die "usage: qualify-bots LOGIN [bot ...]"
login="$1"; shift
id "$login" >/dev/null 2>&1 || die "unknown account: $login"

bots="${*:-eggdrop energymech psotnic limnoria sopel}"
fail=0

printf '%-14s %-10s %-10s %-10s\n' BOT DEFINITION BINARY STORAGE
for bot in $bots; do
  def="services/$bot.env"
  definition=FAIL; binary=FAIL; storage=FAIL

  if [ -r "$def" ]; then
    definition=PASS
    # shellcheck disable=SC1090
    . "./$def"
    if command -v "$SERVICE_BINARY" >/dev/null 2>&1; then binary=PASS; fi
  fi

  uid="$(id -u "$login")"
  root="/srv/shells/users/u-$uid/services/$bot"
  if [ -d "$root/config" ] && [ -d "$root/data" ] &&
     [ -d "$root/logs" ] && [ -d "$root/run" ]; then
    storage=PASS
  fi

  printf '%-14s %-10s %-10s %-10s\n' "$bot" "$definition" "$binary" "$storage"
  [ "$definition" = PASS ] && [ "$binary" = PASS ] && [ "$storage" = PASS ] || fail=1
done

echo
if [ "$fail" -eq 0 ]; then
  echo "BUILD/storage qualification PASS"
else
  echo "BUILD/storage qualification INCOMPLETE"
fi
echo "Network, isolation, restore and soak gates require their dedicated qualification stages."
exit "$fail"
