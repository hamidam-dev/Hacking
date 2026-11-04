DESC="اجرای دستور از راه دور با WMI"
REQ="اعتبارنامه‌ی ادمین دامنه"
RISK="HIGH"

termux(){ echo "impacket-wmiexec domain/user:pass@<IP> 'whoami'"; }

kali(){
cat <<'EOF'
impacket-wmiexec domain/user:pass@<IP> "whoami /all"
impacket-psexec domain/user:pass@<IP>
impacket-atexec domain/user:pass@<IP> "cmd /c whoami"
EOF
}
