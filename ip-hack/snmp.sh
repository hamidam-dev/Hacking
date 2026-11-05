DESC="بررسی SNMP با community پیش‌فرض"
RISK="MED"

termux(){ echo "pkg install net-snmp; snmpwalk -v2c -c public <IP>"; }

kali(){
cat <<'EOF'
nmap -sU -p161 --script snmp-brute <IP>
onesixtyone -c /usr/share/seclists/Discovery/SNMP/common-snmp-community-strings.txt <IP>
snmpwalk -v2c -c public <IP>
EOF
}
