DESC="آنالیز ترافیک اپ واتساپ (پینینگ و رمزنگاری)"
REQ="frida + mitmproxy"
RISK="MED"
NOTE="واتساپ پینینگ سخت دارد. apk-mitm سریع‌ترین راه است"

termux(){
cat <<'EOF'
pkg install python
pip install mitmproxy frida-tools
mitmproxy -p 8080
EOF
}

kali(){
cat <<'EOF'
apk-mitm WhatsApp.apk
# نصب نسخه‌ی وصله‌شده
mitmproxy -p 8080 --set confdir=~/.mitm
# اگر باز هم نشد:
objection -g com.whatsapp explore -s "android sslpinning disable"
EOF
}
