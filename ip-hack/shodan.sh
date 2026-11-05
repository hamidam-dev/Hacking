DESC="جستجوی اطلاعات IP در Shodan"
REQ="shodan CLI + API key"
RISK="LOW"

termux(){ echo "pip install shodan && shodan host <IP>"; }

kali(){
cat <<'EOF'
shodan init <API_KEY>
shodan host <IP>
shodan search "net:192.168.0.0/16 port:22"
# بدون CLI:
curl -s "https://internetdb.shodan.io/<IP>" | jq
EOF
}
