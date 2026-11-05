DESC="بررسی لو رفتن ایمیل"
RISK="LOW"

termux(){ echo "curl -s https://haveibeenpwned.com/api/v3/breachedaccount/target@gmail.com"; }

kali(){
cat <<'EOF'
curl -s "https://haveibeenpwned.com/api/v3/breachedaccount/target@gmail.com" \
  -H "hibp-api-key: <KEY>" | jq '.[].Name'
curl -s "https://haveibeenpwned.com/api/v3/pasteaccount/target@gmail.com"
EOF
}
