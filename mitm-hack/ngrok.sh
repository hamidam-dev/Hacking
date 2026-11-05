DESC="نمایش سرویس محلی روی اینترنت"
REQ="ngrok + توکن"
RISK="MED"

termux(){ echo "pkg install ngrok; ngrok http 8080"; }

kali(){
cat <<'EOF'
ngrok config add-authtoken <TOKEN>
ngrok http 8080
# جایگزین‌ها:
cloudflared tunnel --url http://localhost:8080
ssh -R 80:localhost:8080 serveo.net
EOF
}