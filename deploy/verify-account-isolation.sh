#!/bin/sh
set -eu

[ "$(id -u)" -eq 0 ] || { echo "error: run as root" >&2; exit 1; }
[ "$#" -eq 2 ] || { echo "usage: $0 USER_A USER_B" >&2; exit 2; }
a="$1"; b="$2"
id "$a" >/dev/null 2>&1
id "$b" >/dev/null 2>&1

fail=0
pass(){ printf 'PASS  %s\n' "$1"; }
bad(){ printf 'FAIL  %s\n' "$1"; fail=1; }

ha="/home/$a"; hb="/home/$b"
[ "$(stat -c %a "$ha")" -le 700 ] && pass "$a home private" || bad "$a home private"
[ "$(stat -c %a "$hb")" -le 700 ] && pass "$b home private" || bad "$b home private"

if runuser -u "$a" -- sh -c "test ! -r '$hb'"; then pass "$a cannot read $b home"; else bad "$a cannot read $b home"; fi
if runuser -u "$b" -- sh -c "test ! -r '$ha'"; then pass "$b cannot read $a home"; else bad "$b cannot read $a home"; fi

for u in "$a" "$b"; do
  uid="$(id -u "$u")"
  f="/etc/systemd/system/user-$uid.slice.d/50-shells-no.conf"
  [ -r "$f" ] && pass "$u cgroup policy exists" || bad "$u cgroup policy exists"
  grep -q '^MemoryMax=' "$f" 2>/dev/null && pass "$u memory limit configured" || bad "$u memory limit configured"
  grep -q '^TasksMax=' "$f" 2>/dev/null && pass "$u PID/task limit configured" || bad "$u PID/task limit configured"
  grep -q '^CPUQuota=' "$f" 2>/dev/null && pass "$u CPU quota configured" || bad "$u CPU quota configured"
done

exit "$fail"
