DESC="اطلاعات شماره تلفن"
REQ="phoneinfoga"
RISK="LOW"

termux(){ echo "pip install phoneinfoga && phoneinfoga scan -n +989121234567"; }

kali(){
cat <<'EOF'
docker run -it --rm sundowndev/phoneinfoga scan -n +989121234567
pipx install ignorant && ignorant +989121234567
curl -s "https://api.telize.com/... " 2>/dev/null
# دستی:
#   https://wa.me/989121234567
#   https://t.me/+989121234567
EOF
}
