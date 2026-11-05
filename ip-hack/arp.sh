DESC="اسکن ARP در شبکه محلی"
RISK="LOW"

termux(){ echo "ip neigh"; }

kali(){
cat <<'EOF'
sudo arp-scan --localnet
sudo netdiscover -r 192.168.1.0/24
sudo bettercap -iface eth0 -eval "net.probe on; sleep 15; net.show; quit"
EOF
}
