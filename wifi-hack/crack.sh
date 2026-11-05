DESC="کرک هش WPA"
REQ="hashcat + وردلیست"
RISK="LOW"

termux(){ echo "hashcat -m 22000 hash.22000 wordlist.txt --force"; }

kali(){
cat <<'EOF'
# GPU:
hashcat -m 22000 hash.22000 /usr/share/wordlists/rockyou.txt
# CPU:
aircrack-ng -w /usr/share/wordlists/rockyou.txt cap-01.cap
# با قواعد:
hashcat -m 22000 hash.22000 wordlist.txt -r /usr/share/hashcat/rules/best64.rule
EOF
}
