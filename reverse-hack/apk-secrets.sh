DESC="استخراج کلید و سکرت از APK"
REQ="apkleaks"
RISK="LOW"

termux(){ echo "pip install apkleaks && apkleaks -f app.apk"; }

kali(){
cat <<'EOF'
pipx install apkleaks
apkleaks -f app.apk -o secrets.txt
# دستی:
jadx -d out app.apk
grep -rniE "(api_key|secret|firebase|aws_|Bearer|token)" out/ | head -60
grep -rn "google-services" out/ | head
EOF
}
