#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib/common.sh"

h1 "به‌روزرسانی"

if ! command -v git >/dev/null; then
  err "git نصب نیست"
  exit 1
fi

cd "$ROOT" || exit 1

STASHED=0
if [[ -n "$(git status --porcelain)" ]]; then
  warn "تغییرات محلی داری. موقتاً کنار گذاشته می‌شود."
  if git stash push -u -m "auto-$(date +%s)" >/dev/null 2>&1; then
    STASHED=1
  else
    err "stash شکست خورد"
  fi
fi

if git pull --rebase; then
  log "به‌روزرسانی شد"
else
  err "pull شکست خورد"
fi

if (( STASHED )); then
  if git stash pop >/dev/null 2>&1; then
    log "تغییرات محلی برگردانده شد"
  else
    warn "تعارض داشت. تغییرات در stash مانده:"
    echo "  git stash list"
    echo "  git stash pop"
  fi
fi

chmod +x "$ROOT/hack" "$ROOT/install.sh" "$ROOT/update.sh" 2>/dev/null || true
find "$ROOT" -mindepth 2 -maxdepth 2 -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true

log "تمام شد."
