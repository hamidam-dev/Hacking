#!/usr/bin/env bash
R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; B='\033[0;36m'; M='\033[0;35m'; N='\033[0m'
log(){ printf "${G}[+]${N} %s\n" "$*"; }
warn(){ printf "${Y}[!]${N} %s\n" "$*"; }
err(){ printf "${R}[-]${N} %s\n" "$*"; }
hr(){ printf "${B}%s${N}\n" "────────────────────────────────────────────"; }
h1(){ hr; printf "${M} %s${N}\n" "$*"; hr; }
kv(){ printf "  ${B}%-14s${N} %s\n" "$1" "$2"; }
have(){ command -v "$1" >/dev/null 2>&1; }
need(){ have "$1" || { err "نصب نیست: $1"; return 1; }; }
ask(){ local p="$1" d="${2:-}"; printf "${Y}?${N} %s " "$p"; read -r r; echo "${r:-$d}"; }

_exec(){
  local label="$1"; shift
  local out
  out=$("$@" 2>/dev/null) || { warn "این ماژول روش $label ندارد"; return 1; }
  printf '%s\n' "$out"
  if (( RUN )); then
    echo; log "اجرا…"
    printf '%s\n' "$out" | grep -vE '^[[:space:]]*(#|$)' | bash
    echo; warn "اگر خطا دیدی، جای‌نگهدارها (TARGET / IP / BSSID…) را پر کن"
  fi
  return 0
}

run_module(){
  local cat="$1" mod="$2" file="$3"; shift 3
  # shellcheck disable=SC1090
  source "$file"
  local env="${FORCE_ENV:-$(detect_env)}"

  h1 "$cat / $mod"
  kv "کار" "${DESC:-—}"
  [[ -n "${REQ:-}" ]] && kv "نیاز" "$REQ"
  [[ -n "${RISK:-}" ]] && kv "ریسک" "$RISK"
  hr

  if (( BOTH )); then
    printf "${M}══ روش ۱: ترموکس ══${N}\n"; _exec termux termux "$@"
    echo; printf "${M}══ روش ۲: کالی/لینوکس ══${N}\n"; _exec kali kali "$@"
  elif [[ "$env" == "termux" ]]; then
    _exec termux termux "$@" || _exec "کالی" kali "$@"
  else
    _exec kali kali "$@" || _exec "ترموکس" termux "$@"
  fi
  echo
  [[ -n "${NOTE:-}" ]] && { printf "${Y}نکته:${N} %s\n" "$NOTE"; }
}
