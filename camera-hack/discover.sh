DESC="کشف دوربین‌های IP در شبکه"
RISK="LOW"

termux(){ echo "nmap -sn 192.168.1.0/24"; }

kali(){
cat <<'EOF'
sudo arp-scan --localnet
sudo nmap -sS -p 80,554,8000,8080,8081,34567,37777 192.168.1.0/24 -oG cam.txt
grep -E 'open' cam.txt
# فینگرپرینت:
sudo nmap -sV -p 554 --script rtsp-methods <IP>
EOF
}
