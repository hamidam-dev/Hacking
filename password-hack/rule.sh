DESC="ساخت قاعده‌ی تغییر رمز برای hashcat"
RISK="LOW"

termux(){ echo "hashcat --stdout base.txt -r rules/best64.rule > mutated.txt"; }

kali(){
cat <<'EOF'
hashcat --stdout base.txt -r /usr/share/hashcat/rules/best64.rule > mutated.txt
# قاعده‌ی سفارشی:
echo 'c sa4 se3 $1 $!' > my.rule
hashcat --stdout base.txt -r my.rule
EOF
}