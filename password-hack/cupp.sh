DESC="وردلیست از اطلاعات شخصی هدف"
RISK="LOW"

termux(){ echo "pip install cupp; cupp -i"; }

kali(){
cat <<'EOF'
pipx install cupp
cupp -i
# اطلاعات: نام، نام خانوادگی، تاریخ تولد، حیوان، شرکت
# خروجی در فایل .txt
EOF
}