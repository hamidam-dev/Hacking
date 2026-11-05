DESC="تشخیص و شناسایی اکانت تلگرام"
RISK="LOW"

termux(){ echo "curl -s 'https://t.me/+989121234567' | grep -oE 'tgme_page_title[^<]*<[^>]*>[^<]*'"; }

kali(){
cat <<'EOF'
curl -s "https://t.me/+989121234567" | grep -oE '<title>[^<]*'
pipx install telepathy
telepathy -u username
EOF
}
