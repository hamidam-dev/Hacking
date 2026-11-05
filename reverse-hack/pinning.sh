DESC="دور زدن SSL pinning"
REQ="objection apk-mitm"
RISK="MED"

termux(){
cat <<'EOF'
pip install objection frida-tools
objection -g com.package explore
# داخل شل: android sslpinning disable
EOF
}

kali(){
cat <<'EOF'
# روش ۱ (بدون روت، وصله‌ی APK):
apk-mitm app.apk
# روش ۲ (روت):
objection -g com.package explore -s "android sslpinning disable"
# روش ۳ (اسکریپت frida):
#   https://github.com/httptoolkit/frida-interception-and-unpinning
EOF
}
