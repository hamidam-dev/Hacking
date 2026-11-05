DESC="شناسایی پروفایل فیس‌بوک"
RISK="LOW"

termux(){ echo "curl -s 'https://www.facebook.com/username' | grep -oE '<title>[^<]*'"; }

kali(){
cat <<'EOF'
curl -s "https://www.facebook.com/target" | grep -oE '<title>[^<]*'
# گراف عمومی:
curl -s "https://graph.facebook.com/target?fields=name,id"
# ابزار:
pipx install sherlock && sherlock target
EOF
}
