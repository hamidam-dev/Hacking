DESC="اسکن شبکه‌های وای‌فای اطراف"
REQ="کارت با مانیتور مود"
RISK="LOW"

termux(){
cat <<'EOF'
# ترموکس روی گوشی روت‌شده
su -c "ip link set wlan0 down"
su -c "iw dev wlan0 set type monitor"
su -c "ip link set wlan0 up"
su -c "iw dev wlan0 scan" | grep -E 'SSID|signal|DS Parameter'
EOF
}

kali(){
cat <<'EOF'
sudo airmon-ng check kill
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon
# ذخیره برای مراحل بعد:
sudo airodump-ng wlan0mon -w scan --output-format csv
EOF
}
