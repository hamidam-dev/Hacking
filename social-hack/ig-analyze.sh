DESC="آنالیز ترافیک اپ اینستاگرام"
REQ="frida mitmproxy"
RISK="MED"

termux(){ echo "pip install mitmproxy frida-tools"; }

kali(){
cat <<'EOF'
apk-mitm Instagram.apk
mitmproxy -p 8080
# پینینگ:
objection -g com.instagram.android explore -s "android sslpinning disable"
# دیدن توکن سشن در ترافیک:
mitmproxy -p 8080 --set flow_detail=3
EOF
}
