cat > wifi-hack/scan.sh <<'ENDOFFILE'
DESC="اسکن شبکه‌های وای‌فای اطراف"
REQ="Termux:API بدون روت، یا root با کارت سازگار"
RISK="LOW"
NOTE="بدون مانیتور مود فقط لیست شبکه‌ها را می‌بینی؛ برای هندشیک مانیتور مود لازم است"

termux(){
cat <<'INNER'
termux-wifi-scaninfo | jq -r '.[] | "\(.ssid)  \(.bssid)  \(.frequency)"'
# با روت:
# su -c "iw dev wlan0 scan" | grep -E 'SSID|signal'
INNER
}

kali(){
cat <<'INNER'
sudo airmon-ng check kill
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon
INNER
}
ENDOFFILE
chmod +x wifi-hack/scan.sh
