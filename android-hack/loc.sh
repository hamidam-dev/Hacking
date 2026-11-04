DESC="موقعیت مکانی هدف"
REQ="ADB + Location روشن + اپ مجوزدار"
RISK="LOW"

termux(){
cat <<'EOF'
termux-location -p gps
termux-location -p network
EOF
}

kali(){
cat <<'EOF'
adb shell dumpsys location | grep -iE 'last location|gps:' | head -5
adb shell cmd location get-last-location 2>/dev/null
# روش دقیق‌تر: گرفتن از Google Maps باز
adb shell am start -a android.intent.action.VIEW -d "geo:0,0"
EOF
}
