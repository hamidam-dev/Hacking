DESC="فعال/غیرفعال کردن مانیتور مود"
RISK="LOW"

termux(){
cat <<'EOF'
su -c "svc wifi disable"
su -c "ip link set wlan0 down"
su -c "iw dev wlan0 set type monitor"
su -c "ip link set wlan0 up"
# بازگشت:
su -c "ip link set wlan0 down"
su -c "iw dev wlan0 set type managed"
su -c "ip link set wlan0 up"
EOF
}

kali(){
cat <<'EOF'
sudo airmon-ng check kill
sudo airmon-ng start wlan0
iw dev
sudo airmon-ng stop wlan0mon
sudo systemctl restart NetworkManager
EOF
}
