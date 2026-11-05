DESC="آنالیز استاتیک APK"
REQ="MobSF apkid"
RISK="LOW"

termux(){ echo "pkg install aapt; aapt dump badging app.apk"; }

kali(){
cat <<'EOF'
docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf
# بعد APK را در http://localhost:8000 آپلود کن
apkid app.apk
aapt dump badging app.apk
unzip -l app.apk | head -40
EOF
}
