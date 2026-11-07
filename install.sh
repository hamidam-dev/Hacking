#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib/common.sh"
source "$ROOT/lib/detect.sh"

ENV="$(detect_env)"
h1 "نصب hackit — محیط: $ENV"

AIRCRACK_DEB="https://raw.githubusercontent.com/pitube08642/aircrack-ng-for-termux/main/dists/termux/aircrack-ng/binary-i686/aircrack-ng_3_1.7_i686.deb"
LOG="/tmp/hackit-install.log"

export DEBIAN_FRONTEND=noninteractive
APT="-y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold -o Acquire::Retries=3"

pkg_ok(){ dpkg -s "$1" >/dev/null 2>&1; }

run_apt(){
  local desc="$1"; shift
  printf "  %s " "$desc"
  $SUDO apt-get "$@" >>"$LOG" 2>&1 &
  local pid=$!
  while kill -0 "$pid" 2>/dev/null; do printf "."; sleep 3; done
  wait "$pid"
  local rc=$?
  echo
  return $rc
}

fix_apt(){
  log "بررسی سلامت apt"
  run_apt "به‌روزرسانی فهرست" update
  $SUDO dpkg --configure -a >>"$LOG" 2>&1 || true

  if $SUDO apt-get check >/dev/null 2>&1; then
    log "apt سالم است"
    return 0
  fi

  warn "وابستگی خراب. تعمیر هدفمند (ممکن است چند دقیقه طول بکشد)"
  run_apt "همگام‌سازی postgresql" install --allow-downgrades postgresql-client-common postgresql-common || true
  run_apt "تعمیر وابستگی‌ها" -f install || true

  if $SUDO apt-get check >/dev/null 2>&1; then
    log "apt تعمیر شد"
    return 0
  fi

  warn "ارتقای کامل (حجیم، صبر کن)"
  run_apt "full-upgrade" full-upgrade || true

  if $SUDO apt-get check >/dev/null 2>&1; then
    log "apt تعمیر شد"
    return 0
  fi

  err "apt هنوز خراب است. دستی بزن:"
  echo "  apt-get install -y --allow-downgrades postgresql-client-common postgresql-common"
  echo "  apt-get -f install -y"
  return 1
}

apt_one(){
  local p="$1"
  pkg_ok "$p" && { log "از قبل: $p"; return 0; }
  if run_apt "$p" install $APT "$p"; then
    log "ok: $p"
    return 0
  fi
  warn "نصب نشد: $p"
  grep -iE 'unmet dep|unable to locate|broken' "$LOG" | tail -2
}

go_one(){
  local m="$1"
  local b="${m%%@*}"; b="${b##*/}"
  command -v "$b" >/dev/null 2>&1 && { log "از قبل: $b"; return 0; }
  command -v go >/dev/null 2>&1 || { warn "go نصب نیست، $b رد شد"; return 0; }
  printf "  نصب %s " "$b"
  GOMAXPROCS=2 go install "$m" >>"$LOG" 2>&1 &
  local pid=$!
  while kill -0 "$pid" 2>/dev/null; do printf "."; sleep 3; done
  wait "$pid"
  if (( $? == 0 )); then log "ok: $b"; else warn "نصب نشد: $b"; fi
}

: > "$LOG"

case "$ENV" in
termux)
  BIN="$PREFIX/bin"; SUDO=""
  pkg update -y >/dev/null 2>&1 || true
  pkg install -y root-repo x11-repo >/dev/null 2>&1 || true

  for p in git curl wget jq python nmap openssh android-tools termux-api \
           clang make which golang rust binutils python-cryptography; do
    if pkg_ok "$p"; then log "از قبل: $p"
    elif pkg install -y "$p" >>"$LOG" 2>&1; then log "ok: $p"
    else warn "نصب نشد: $p"; fi
  done

  if ! have aircrack-ng; then
    ( cd "$HOME" && curl -fsLO "$AIRCRACK_DEB" && dpkg -i "$(basename "$AIRCRACK_DEB")" ) \
      >>"$LOG" 2>&1 && log "ok: aircrack-ng" || warn "aircrack-ng نصب نشد"
  fi

  pip install --quiet sqlmap >>"$LOG" 2>&1 && log "ok: sqlmap" || warn "sqlmap نصب نشد"
  pip install --quiet frida-tools objection >>"$LOG" 2>&1 && log "ok: frida" || warn "frida نصب نشد"
  pip install --quiet mitmproxy >>"$LOG" 2>&1 && log "ok: mitmproxy" \
    || warn "mitmproxy نصب نشد — در debian proot نصب کن"

  export PATH="$PATH:$HOME/go/bin"
  go_one github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go_one github.com/projectdiscovery/httpx/cmd/httpx@latest
  go_one github.com/ffuf/ffuf/v2/cmd/ffuf@latest
  ;;

*)
  if [[ $EUID -eq 0 ]]; then SUDO=""; else SUDO="sudo"; fi
  BIN="/usr/local/bin"

  fix_apt || true

  for p in git curl wget jq python3 python3-pip pipx nmap hydra sqlmap \
           aircrack-ng adb scrcpy openssh-client net-tools dnsutils \
           unzip golang default-jdk; do
    apt_one "$p"
  done

  if ! have frida; then
    if pipx install frida-tools >>"$LOG" 2>&1; then log "ok: frida"
    elif pip install --break-system-packages -q frida-tools >>"$LOG" 2>&1; then log "ok: frida (pip)"
    else warn "frida نصب نشد"; fi
  fi
  pipx ensurepath >>"$LOG" 2>&1 || true

  if ! have msfconsole; then
    warn "Metasploit: https://www.kali.org/tools/metasploit-framework/"
  fi

  if ! have ngrok; then
    if curl -fsSL https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -o /tmp/n.zip \
       && $SUDO unzip -o -q /tmp/n.zip -d /usr/local/bin; then
      log "ok: ngrok"
    else
      warn "ngrok نصب نشد (به توکن نیاز دارد)"
    fi
  fi

  export PATH="$PATH:$HOME/go/bin:/root/go/bin:/usr/lib/go/bin:$HOME/.local/bin"
  go_one github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go_one github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
  go_one github.com/projectdiscovery/httpx/cmd/httpx@latest
  go_one github.com/projectdiscovery/ffuf/v2/cmd/ffuf@latest
  ;;
esac

chmod +x "$ROOT/hack" "$ROOT/install.sh" "$ROOT/update.sh" 2>/dev/null || true
find "$ROOT" -mindepth 2 -maxdepth 2 -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true

mkdir -p "$BIN"
LINKED=0
if $SUDO ln -sf "$ROOT/hack" "$BIN/hack" 2>/dev/null; then LINKED=1; fi
if $SUDO ln -sf "$ROOT/hack" "$BIN/hk"   2>/dev/null; then LINKED=1; fi

if (( LINKED )); then
  log "دستور نصب شد:"
  echo "  hack list"
else
  warn "لینک نشد:"
  echo "  ln -sf $ROOT/hack $BIN/hack"
fi

echo
if [[ -s "$LOG" ]]; then
  warn "خطاها در $LOG"
  tail -10 "$LOG"
else
  log "بدون خطا"
fi
