DESC="شناسایی اکانت ایکس/توییتر"
RISK="LOW"

termux(){ echo "curl -s 'https://x.com/username'"; }

kali(){
cat <<'EOF'
curl -s -A "Mozilla/5.0" "https://x.com/username" | grep -oE '<title>[^<]*'
curl -s "https://api.fxtwitter.com/username" | jq '{name:.user.name,followers:.user.followers}'
EOF
}
