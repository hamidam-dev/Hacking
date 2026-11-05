DESC="تشخیص اینکه شماره در واتساپ ثبت شده یا نه"
REQ="ignorant"
RISK="LOW"

termux(){ echo "pip install ignorant && ignorant +98912xxxxxxx"; }

kali(){
cat <<'EOF'
pipx install ignorant
ignorant +989121234567
ignorant -c 5 +989121234567 +989351234567
# فقط برای تأیید:
curl -s "https://wa.me/989121234567"
EOF
}
