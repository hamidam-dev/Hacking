#!/usr/bin/env bash
# hack — dispatcher
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="1.0.0"
source "$ROOT/lib/common.sh"
source "$ROOT/lib/detect.sh"

FORCE_ENV=""; RUN=0; BOTH=0

parse_flags(){
  local args=()
  for a in "$@"; do
    case "$a" in
      --termux) FORCE_ENV=termux ;;
      --kali)   FORCE_ENV=kali ;;
      --both)   BOTH=1 ;;
      --run)    RUN=1 ;;
      -h|--help) usage; exit 0 ;;
      *) args+=("$a") ;;
    esac
  done
  printf '%s\n' "${args[@]}"
}

usage(){
cat <<'EOF'
hack — جعبه‌ابزار تهاجمی

  hack list                فهرست دسته‌ها
  hack <دسته>              منوی ماژول‌های آن دسته
  hack <دسته> <ماژول>      اجرای ماژول
  hack <دسته> <ماژول> --both    هر دو روش (ترموکس + کالی)
  hack doctor              بررسی محیط و ابزارها

پرچم‌ها:
  --termux   اجبار به روش ترموکس
  --kali     اجبار به روش کالی
  --both     هر دو روش
  --run      اجرای واقعی (پیش‌فرض: فقط نمایش دستور)
EOF
}

list_categories(){
  printf '%s\n' "${!CAT_DESC[@]}" 2>/dev/null | sort
  echo
  for d in "$ROOT"/*-hack; do
    [[ -d "$d" ]] || continue
    local c; c=$(basename "$d")
    local t=""
    [[ -f "$d/category.conf" ]] && t=$(grep '^TITLE=' "$d/category.conf" | cut -d= -f2-)
    printf '  %-16s %s\n' "$c" "$t"
  done
}

doctor(){
  echo "محیط: $(detect_env)"
  echo "کرنل: $(uname -srm)"
  local miss=0
  while read -r t; do
    [[ -z "$t" ]] && continue
    command -v "$t" >/dev/null && printf '  ok   %s\n' "$t" || { printf '  miss %s\n' "$t"; ((miss++)); }
  done < "$ROOT/conf/deps.txt"
  echo; ((miss)) && warn "$miss ابزار نصب نیست — bash install.sh" || log "همه‌چیز آماده"
}

dispatch(){
  local cat="$1"; shift
  local mod="${1:-}"; [[ -n "$mod" ]] && shift

  local dir="$ROOT/$cat"
  [[ -d "$dir" ]] || { err "دسته نبود: $cat"; list_categories; exit 1; }

  if [[ -z "$mod" ]]; then menu "$dir"; return; fi

  local file="$dir/$mod.sh"
  [[ -f "$file" ]] || { err "ماژول نبود: $mod"; menu "$dir"; exit 1; }

  run_module "$cat" "$mod" "$file" "$@"
}

menu(){
  local dir="$1"; local conf="$dir/category.conf"
  local title=""; [[ -f "$conf" ]] && title=$(grep '^TITLE=' "$conf" | cut -d= -f2-)
  hr; printf ' %s\n' "${title:-$(basename "$dir")}"; hr
  local i=0; local -a keys=()
  while IFS='|' read -r k d; do
    [[ -z "$k" || "$k" == \#* ]] && continue
    ((i++)); keys+=("$k")
    printf '  %2d) %-18s %s\n' "$i" "$k" "$d"
  done < <(grep '^MODULES=' -A999 "$conf" 2>/dev/null | sed '1d' | sed '/^$/q')
  echo
  printf ' شماره یا نام: '; read -r pick
  local sel=""
  if [[ "$pick" =~ ^[0-9]+$ ]]; then sel="${keys[$((pick-1))]:-}"; else sel="$pick"; fi
  [[ -z "$sel" ]] && { err "انتخاب نامعتبر"; exit 1; }
  local file="$dir/$sel.sh"
  [[ -f "$file" ]] || { err "نبود: $sel"; exit 1; }
  run_module "$(basename "$dir")" "$sel" "$file"
}

main(){
  local -a a; mapfile -t a < <(parse_flags "$@")
  (( ${#a[@]} )) || { usage; exit 0; }
  local cmd="${a[0]}"; unset 'a[0]'
  case "$cmd" in
    list) list_categories ;;
    doctor) doctor ;;
    version) echo "$VERSION" ;;
    *) dispatch "$cmd" "${a[@]}" ;;
  esac
}

main "$@"
