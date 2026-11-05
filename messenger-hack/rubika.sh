DESC="آنالیز روبیکا و کتابخانه‌ی آن"
RISK="ToS"
NOTE="روبیکا API عمومی ندارد؛ کتابخانه‌ها با هر آپدیت می‌شکنند"

termux(){ echo "pip install rubika-bot-api"; }

kali(){
cat <<'EOF'
# کتابخانه‌ی بات:
pip install rubika-bot-api
# ریپوهای فعال:
#   https://github.com/rubika-bot-api/rubika_bot_api
#   https://github.com/topics/rubika
# آنالیز اپ:
apk-mitm rubika.apk
mitmproxy -p 8080
# ترافیک WebSocket است؛ برای دیکد، متد رمزنگاری را با frida هوک کن:
frida -U -f ir.resaneh1.iptv -l hook.js
EOF
}
