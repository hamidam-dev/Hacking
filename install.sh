#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib/common.sh"
source "$ROOT/lib/detect.sh"

ENV="$(detect_env)"
h1 "نصب hackit — محیط: $ENV"

AIRCRACK_DEB="https://raw.githubusercontent.com/pitube08642/aircrack-ng-for-termux/main/dists/termux/aircrack-ng/binary-i686/aircrack-ng_3_1.7_i686.deb"

case "$ENV" in
termux)
  BIN="$PREFIX/bin"; SUDO=""
  pkg update -y >/dev/null 2>&1 || true
  pkg install -y root-repo x11-repo >/dev/null 2>&1 || true

  for p in git curl wget jq python nmap openssh android-tools termux-api \
           clang make which golang rust binutils python-cryptography; do
    pkg install -y "$p" >/dev/null 2>&1 && log "ok: $p" || warn "نصب نشد: $p"
  done

  if ! have aircrack-ng; then
    ( cd "$HOME" && curl -fsLO "$AIRCRACK_DEB" && dpkg -i "$(basename "$AIRCRACK_DEB")" ) \
      >/dev/null 2>&1 && log "ok: aircrack-ng" || warn "aircrack-ng نصب نشد"
  fi

  pip install --quiet sqlmap 2>/dev/null && log "ok: sqlmap" || warn "sqlmap نصب نشد"
  pip install --quiet frida-tools objection 2>/dev/null && log "ok: frida" || warn "frida نصب نشد"
  pip install --quiet mitmproxy 2>/dev/null && log "ok: mitmproxy" \
    || warn "mitmproxy نصب نشد — در debian proot نصب کن"

  export PATH="$PATH:$HOME/go/bin"
  for m in github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest \
           github.com/projectdiscovery/httpx/cmd/httpx@latest \
           github.com/ffuf/ffuf/v2/cmd/ffuf@latest; do
    GOMAXPROCS=1 go install -v "$m" >/dev/null 2>&1 && log "ok: $(basename "${m%%@*}")" \
      || warn "نصب نشد: $m"
  done
  ;;
*)
  SUDO="sudo"
  $SUDO apt-get update -qq
  $SUDO apt-get install -y -qq git curl wget jq python3 python3-pip nmap hydra sqlmap \
       aircrack-ng adb scrcpy openssh-client net-tools dnsutils 2>/dev/null || warn "بعضی پکیج‌ها نصب نشد"
  command -v msfconsole >/dev/null || warn "Metasploit: https://github.com/rapid7/metasploit-framework"
  BIN="/usr/local/bin"
  ;;
esac

chmod +x "$ROOT/hack" "$ROOT/install.sh" 2>/dev/null || true
find "$ROOT" -mindepth 2 -maxdepth 2 -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true

mkdir -p "$BIN"
LINKED=0
if $SUDO ln -sf "$ROOT/hack" "$BIN/hack" 2>/dev/null; then LINKED=1; fi
if $SUDO ln -sf "$ROOT/hack" "$BIN/hk"   2>/dev/null; then LINKED=1; fi

if (( LINKED )); then
  log "دستور نصب شد. از هر جا:"
  echo "  hack list"
  echo "  hk list"
else
  warn "لینک نشد. دستی بزن:"
  echo "  ln -sf $ROOT/hack $BIN/hack"
  echo "  ln -sf $ROOT/hack $BIN/hk"
fi

log "نصب تمام شد."
warn "Termux API را از F-Droid نصب کن وگرنه دوربین/میکروفن/موقعیت کار نمی‌کند"
