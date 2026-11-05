DESC="کشف میزبان‌های زنده"
RISK="LOW"

termux(){ echo "nmap -sn 192.168.1.0/24"; }

kali(){
cat <<'EOF'
sudo nmap -sn 192.168.1.0/24
sudo arp-scan --localnet
fping -a -g 192.168.1.0/24 2>/dev/null
EOF
}
