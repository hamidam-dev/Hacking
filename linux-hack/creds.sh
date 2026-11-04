DESC="جستجوی رمز در فایل‌های سیستم"
REQ="shell"
RISK="MED"

termux(){ echo "grep -rniE 'pass|secret|token' ~/.config 2>/dev/null | head -50"; }

kali(){
cat <<'EOF'
grep -rniE "(password|passwd|secret|api_key|token)" /var/www /home /opt /etc 2>/dev/null | head -100
cat ~/.bash_history
cat ~/.ssh/id_rsa 2>/dev/null
find / -name "*.kdbx" -o -name "id_rsa" -o -name "*.env" 2>/dev/null
EOF
}
