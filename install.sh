#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib/common.sh"
source "$ROOT/lib/detect.sh"

ENV="$(detect_env)"
h1 "نصب hackit — محیط: $ENV"

case "$ENV" in
termux)
  pkg update -y
  pkg install -y root-repo x11-repo 2>/dev/null || true
  pkg install -y git curl jq python nmap openssh android-tools termux-api \
                 clang make which 2>/dev/null || warn "بعضی پکیج‌ها نصب نشد"
  pkg install -y aircrack-ng hydra sqlmap 2>/dev/null || true
  pip install --quiet mitmproxy frida-tools objection 2>/dev/null || true
  BIN="$PREFIX/bin"
  ;;
*)
  sudo apt-get update -qq
  sudo apt-get install -y -qq git curl jq python3 python3-pip nmap hydra sqlmap \
       aircrack-ng adb scrcpy openssh-client net-tools dnsutils 2>/dev/null || warn "بعضی پکیج‌ها نصب نشد"
  command -v msfconsole >/dev/null || warn "Metasploit: https://github.com/rapid7/metasploit-framework"
  BIN="/usr/local/bin"
  ;;
esac

chmod +x "$ROOT/hack" "$ROOT"/scripts/*.sh 2>/dev/null || true
ln -sf "$ROOT/hack" "$BIN/hack" 2>/dev/null || warn "لینک نشد، دستی: $ROOT/hack"

log "نصب شد. اجرا: hack list"
warn "Termux API را از F-Droid نصب کن وگرنه دوربین/میکروفن/موقعیت کار نمی‌کند"
