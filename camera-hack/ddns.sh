DESC="جستجوی دوربین‌های عمومی روی اینترنت"
REQ="Shodan"
RISK="LOW"

termux(){ echo "curl -s 'https://internetdb.shodan.io/1.1.1.1'"; }

kali(){
cat <<'EOF'
shodan search 'Server: Hikvision' --limit 20 --fields ip_str,port
shodan search 'port:554 has_screenshot:true' --limit 20
shodan search 'Dahua' --limit 20
# Insecam هم مرجع خوبی است: https://www.insecam.org
EOF
}
