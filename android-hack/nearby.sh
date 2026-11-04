DESC="کشف گوشی‌های هم‌شبکه و پورت‌های بازشان"
REQ="nmap"
RISK="LOW"

termux(){
cat <<'EOF'
nmap -sn 192.168.1.0/24
nmap -sT -p 5555,8080,62078 192.168.1.0/24
EOF
}

kali(){
cat <<'EOF'
IP=$(ip -4 addr show | awk '/inet /{print $2}' | cut -d/ -f1 | grep -v 127.0.0.1 | head -1)
NET=$(echo "$IP" | cut -d. -f1-3).0/24
sudo nmap -sn "$NET"
sudo nmap -sS -p 5555,62078,8080,22 "$NET" -oG - | grep -E 'Ports:.*open'
EOF
}
