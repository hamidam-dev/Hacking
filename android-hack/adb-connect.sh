DESC="اتصال ADB روی وای‌فای به گوشی هدف"
REQ="adb + اشتراک شبکه + دیباگ بی‌سیم روشن"
RISK="MED"
NOTE="اندروید ۱۱+ مسیر: تنظیمات > گزینه‌های توسعه‌دهنده > Wireless debugging > Pair device with pairing code"

termux(){
cat <<'EOF'
# ۱. پورت Pairing را از صفحه‌ی هدف بخوان، بعد:
adb pair 192.168.1.50:37123
# کد ۶ رقمی را وارد کن

# ۲. آدرس اتصال را از همان صفحه بردار:
adb connect 192.168.1.50:41234
adb devices
EOF
}

kali(){
cat <<'EOF'
ip a | grep 'inet '          # هم‌شبکه بودن را تأیید کن
adb pair <TARGET_IP>:<PAIR_PORT>
adb connect <TARGET_IP>:<PORT>
adb devices
adb -s <TARGET_IP>:<PORT> shell
EOF
}
