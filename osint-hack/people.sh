DESC="جستجوی افراد در منابع عمومی"
RISK="LOW"

termux(){ echo "curl -s 'https://api.github.com/search/users?q=USERNAME'"; }

kali(){
cat <<'EOF'
pipx install sherlock && sherlock username
pipx install maigret && maigret username
# منابع ایران:
#   https://www.instagram.com/USERNAME
#   https://www.linkedin.com/in/USERNAME
#   https://divar.ir (نام و شماره)
EOF
}
