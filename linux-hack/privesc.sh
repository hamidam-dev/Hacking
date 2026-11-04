DESC="بررسی مسیرهای ارتقای دسترسی"
REQ="shell"
RISK="HIGH"

termux(){ echo "uname -a; sudo -l; id; cat /etc/os-release"; }

kali(){
cat <<'EOF'
uname -a
sudo -l
find / -perm -4000 -type f 2>/dev/null
getcap -r / 2>/dev/null
cat /etc/crontab; ls -la /etc/cron.*
cat /etc/passwd
ss -tulpn
# ابزار خودکار:
./linpeas.sh
EOF
}
