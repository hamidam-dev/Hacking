DESC="اعتبارسنجی وجود ایمیل"
RISK="LOW"

termux(){ echo "dig +short MX target.com"; }

kali(){
cat <<'EOF'
dig +short MX target.com
dig +short TXT target.com
# بدون ارسال ایمیل:
pipx install emailharvester
emailharvester -d target.com
# SMTP دستی:
nc -nv mx.target.com 25
# HELO x / MAIL FROM:<a@b.c> / RCPT TO:<target@target.com>
EOF
}
