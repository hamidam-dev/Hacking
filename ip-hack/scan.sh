DESC="اسکن پورت و نسخه‌ی سرویس"
REQ="nmap"
RISK="MED"
NOTE="-T3 برای سرور ضعیف. -T4 فقط وقتی عجله داری"

termux(){ echo "nmap -sT -sV -T3 -p 1-1000 <IP>"; }

kali(){
cat <<'EOF'
sudo nmap -sS -sV -T3 -p- --min-rate 500 <IP> -oA scan
sudo nmap -sU -T3 --top-ports 50 <IP>
nmap -sV -p 21,22,23,25,80,443,445,3306,3389,8080 <IP>
EOF
}
