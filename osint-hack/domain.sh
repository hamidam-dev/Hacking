DESC="اطلاعات دامنه و مالکیت"
RISK="LOW"

termux(){ echo "whois target.com"; }

kali(){
cat <<'EOF'
whois target.com
dig +short target.com ANY
curl -s "https://crt.sh/?q=%25.target.com&output=json" | jq -r '.[].name_value' | sort -u
# تاریخچه:
curl -s "http://web.archive.org/cdx/search/cdx?url=target.com&output=json&limit=20"
EOF
}
