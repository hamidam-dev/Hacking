DESC="لیست اپ‌های نصب‌شده و کشیدن دیتای یک اپ"
REQ="ADB"
RISK="MED"

termux(){
cat <<'EOF'
pm list packages -3
pm list packages -f | head -20
EOF
}

kali(){
cat <<'EOF'
adb shell pm list packages -3 | sed 's/package://'
PKG=$(adb shell pm list packages -3 | sed 's/package://' | head -1 | tr -d '\r')
adb shell pm path "$PKG"
adb shell run-as "$PKG" ls -R /data/data/"$PKG"/ 2>/dev/null | head -40
adb shell run-as "$PKG" cat /data/data/"$PKG"/shared_prefs/*.xml 2>/dev/null
EOF
}
