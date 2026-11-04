#!/usr/bin/env bash
detect_env(){
  if [[ -n "${TERMUX_VERSION:-}" ]] || [[ "$(uname -o 2>/dev/null)" == "Android" ]]; then echo termux; return; fi
  if [[ -d /data/data/com.termux ]]; then echo termux; return; fi
  echo kali
}
is_termux(){ [[ "$(detect_env)" == "termux" ]]; }
LAN_IP(){ ip -4 addr show 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -1; }
