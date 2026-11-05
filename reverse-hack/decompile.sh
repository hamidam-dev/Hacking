DESC="دیکامپایل و خواندن سورس"
REQ="jadx"
RISK="LOW"

termux(){ echo "pkg install openjdk-17; wget jadx zip; jadx -d out app.apk"; }

kali(){
cat <<'EOF'
jadx -d out app.apk
jadx --show-bad-code -d out app.apk
grep -rn "class MainActivity" out/ | head
# اسمali:
apktool d app.apk -o smali
find smali -name "*.smali" | head -20
EOF
}
