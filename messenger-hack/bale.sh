DESC="آنالیز بله و کتابخانه‌ی آن"
RISK="ToS"

termux(){ echo "pip install balethon"; }

kali(){
cat <<'EOF'
pip install balethon
# کتابخانه:
#   https://github.com/Balethon/Balethon
#   https://github.com/python-bale-bot/python-bale-bot
# آنالیز اپ:
apk-mitm bale.apk && mitmproxy -p 8080
EOF
}
