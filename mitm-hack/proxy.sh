DESC="راه‌اندازی پروکسی برای شنود"
RISK="MED"

termux(){ echo "pip install mitmproxy; mitmproxy -p 8080"; }

kali(){
cat <<'EOF'
mitmproxy -p 8080
# یا حالت شفاف:
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
mitmproxy --mode transparent -p 8080
# نصب گواهی روی دستگاه هدف: mitm.it
EOF
}
