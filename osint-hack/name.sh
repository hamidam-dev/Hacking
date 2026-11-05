DESC="جستجوی نام در منابع عمومی"
RISK="LOW"

termux(){ echo "curl -s 'https://api.github.com/search/users?q=NAME'"; }

kali(){
cat <<'EOF'
pipx install maigret && maigret "first last"
curl -s "https://api.github.com/search/users?q=name" | jq '.items[].login'
# گوگل:
#   "first last" site:linkedin.com
#   "first last" site:instagram.com
EOF
}
