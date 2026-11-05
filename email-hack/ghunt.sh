DESC="OSINT اکانت گوگل"
REQ="GHunt + کوکی"
RISK="LOW"

termux(){ echo "pip install ghunt && ghunt login"; }

kali(){
cat <<'EOF'
pipx install ghunt
ghunt login
ghunt email target@gmail.com
ghunt drive target@gmail.com
EOF
}
