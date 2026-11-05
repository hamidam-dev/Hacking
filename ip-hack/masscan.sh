DESC="اسکن انبوه رنج IP"
REQ="masscan"
RISK="HIGH"
NOTE="نرخ بالا شبیه DoS دیده می‌شود. با 1000 شروع کن"

termux(){ echo "pkg install masscan; masscan -p80,443 --rate 1000 <CIDR>"; }

kali(){
cat <<'EOF'
sudo masscan -p1-65535 --rate 1000 <CIDR> -oL masscan.txt
sudo masscan -p80,443,22,3389 --rate 2000 <CIDR> -oJ masscan.json
awk '{print $4}' masscan.txt | sort -u > hosts.txt
nmap -sV -iL hosts.txt -p 80,443,22,3389
EOF
}
