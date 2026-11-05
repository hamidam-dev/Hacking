DESC="تولید وردلیست هدفمند از اطلاعات هدف"
REQ="cupp"
RISK="LOW"

termux(){ echo "pip install cupp; cupp -i"; }

kali(){
cat <<'EOF'
pipx install cupp
cupp -i
# یا:
git clone https://github.com/urbanadventurer/username-anarchy
username-anarchy "First Last" > users.txt
EOF
}