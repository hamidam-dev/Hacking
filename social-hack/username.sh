DESC="ردیابی یک یوزرنیم در همه‌ی سایت‌ها"
REQ="sherlock maigret"
RISK="LOW"

termux(){ echo "pip install maigret && maigret username"; }

kali(){
cat <<'EOF'
pipx install maigret
maigret target_user --html --pdf
sherlock target_user --output res.txt
EOF
}
