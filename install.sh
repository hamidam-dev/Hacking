#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib/common.sh"
source "$ROOT/lib/detect.sh"

ENV="$(detect_env)"
h1 "نصب hackit — محیط: $ENV"

AIRCRACK_DEB="https://raw.githubusercontent.com/pitube08642/aircrack-ng-for-termux/main/dists/termux/aircrack-ng/binary-i686/aircrack-ng_3_1.7_i686.deb"

apt_one(){
  local p="$1"
  command -v "$p" >/dev/null 2>&1 && { log "از قبل: $p"; return 0; }
  if $SUDO apt-get install -y "$p" >/tmp/apt.log 2>&1; then
    log "ok: $p"
  else
    warn "نصب نشد: $p"
    grep -iE 'unable to locate|no installation candidate' /tmp/apt.log | head -2
  fi
}

go_one(){
  local m="$1"
  local b="${m%%@*}"; b="${b##*/}"
  command -v "$b" >/dev/null 2>&1 && { log "از قبل: $b"; return 0; }
  if GOMAXPROCS=2 go install "$m" >/dev/null 2>&1; then log "ok: $b"; else warn "نصب نشد: $b"; fi
}

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
  go_one github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go_one github.com/projectdiscovery/httpx/cmd/httpx@latest
  go_one github.com/ffuf/ffuf/v2/cmd/ffuf@latest
  ;;

*)
  if [[ $EUID -eq 0 ]]; then SUDO=""; BIN="/usr/local/bin"; else SUDO="sudo"; BIN="/usr/local/bin"; fi

  $SUDO apt-get update >/tmp/apt.log 2>&1 || warn "apt update مشکل داشت"
  for p in git curl wget jq python3 python3-pip pipx nmap hydra sqlmap \
           aircrack-ng adb scrcpy openssh-client net-tools dnsutils \
           unzip golang-go default-jdk; do
    apt_one "$p"
  done

  if ! have frida; then
    pipx install frida-tools >/dev/null 2>&1 || pip install --break-system-packages -q frida-tools 2>/dev/null
    have frida && log "ok: frida" || warn "frida نصب نشد"
  fi

  if ! have msfconsole; then
    warn "Metasploit دستی: https://www.kali.org/tools/metasploit-framework/"
  fi

  if ! have ngrok; then
    curl -fsSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -o /tmp/n.zip \
      && $SUDO unzip -o -q /tmp/n.zip -d /usr/local/bin && log "ok: ngrok" \
      || warn "ngrok نصب نشد (به توکن نیاز دارد)"
  fi

  export PATH="$PATH:$HOME/go/bin:/root/go/bin"
  go_one github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go_one github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
  go_one github.com/projectdiscovery/httpx/cmd/httpx@latest
  go_one github.com/ffuf/ffuf/v2/cmd/ffuf@latest
  ;;
esac

chmod +x "$ROOT/hack" "$ROOT/install.sh" 2>/dev/null || true
find "$ROOT" -mindepth 2 -maxdepth 2 -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true

mkdir -p "$BIN"
LINKED=0
if $SUDO ln -sf "$ROOT/hack" "$BIN/hack" 2>/dev/null; then LINKED=1; fi
if $SUDO ln -sf "$ROOT/hack" "$BIN/hk"   2>/dev/null; then LINKED=1; fi

if (( LINKED )); then
  log "دستور نصب شد:"
  echo "  hack list"
  echo "  hk list"
else
  warn "لینک نشد:"
  echo "  ln -sf $ROOT/hack $BIN/hack"
fi

log "تمام شد."
