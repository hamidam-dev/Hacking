DESC="اسکرین‌میرور زنده + کنترل ماوس و کیبورد هدف"
REQ="adb + scrcpy"
RISK="LOW"
NOTE="کم‌تأخیرترین راه دیدن صفحه. با --no-audio روی USB2 اجرا کن"

termux(){
cat <<'EOF'
# داخل Termux با X11
pkg install x11-repo && pkg install scrcpy
export DISPLAY=:0
scrcpy --bit-rate 2M --max-size 1024
EOF
}

kali(){
cat <<'EOF'
scrcpy --bit-rate 2M --max-size 1280 --no-audio
# فقط تماشا:
scrcpy --no-control
# چند دستگاه:
scrcpy -s <SERIAL>
EOF
}
