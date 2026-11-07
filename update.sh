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

if [[ -n "$(git status --porcelain)" ]]; then
  warn "تغییرات محلی داری. بکاپ گرفته می‌شود."
  git stash push -u -m "auto-$(date +%s)" >/dev/null 2>&1 || true
fi

if git pull --rebase; then
  log "به‌روزرسانی شد"
  chmod +x "$ROOT/hack" "$ROOT/install.sh" 2>/dev/null || true
  find "$ROOT" -mindepth 2 -maxdepth 2 -name '*.sh' -exec chmod +x {} \; 2>/dev/null || true
else
  err "pull شکست خورد"
  warn "تغییرات در stash مانده: git stash list"
fi
