DESC="کنترل واتساپ با کلاینت غیررسمی (نیاز به QR یا OTP)"
REQ="Node یا Go"
RISK="ToS"

termux(){
cat <<'EOF'
pkg install nodejs
git clone https://github.com/WhiskeySockets/Baileys
cd Baileys && npm i
node Example/example.js
# QR را با گوشی هدف اسکن کن
EOF
}

kali(){
cat <<'EOF'
docker run -it --rm -p 3000:3000 aldinokemal/go-whatsapp-web-multidevice:latest
# یا:
git clone https://github.com/wppconnect-team/wppconnect
cd wppconnect && npm i && node src/index.js

# آرشیو کامل چت:
git clone https://github.com/WhiskeySockets/Baileys && cd Baileys && npm i
node Example/example.js
EOF
}
