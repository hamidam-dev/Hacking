DESC="جستجوی لیک و پیست"
RISK="LOW"

termux(){ echo "curl -s 'https://psbdmp.ws/api/search/target'"; }

kali(){
cat <<'EOF'
curl -s "https://psbdmp.ws/api/search/target" | jq '.data[].id'
curl -s "https://haveibeenpwned.com/api/v3/breaches" | jq '.[].Name'
# جستجوی گیت‌هاب برای سکرت لو رفته:
curl -s "https://api.github.com/search/code?q=target.com+password" -H "Accept: application/vnd.github+json"
EOF
}
