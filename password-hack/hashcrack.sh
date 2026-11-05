DESC="کرک هش"
RISK="LOW"

termux(){ echo "hashcat -m 0 hash.txt pass.txt --force"; }

kali(){
cat <<'EOF'
hashcat -m 0 hash.txt /usr/share/wordlists/rockyou.txt
hashcat -m 1000 ntlm.txt rockyou.txt -r best64.rule
john --wordlist=rockyou.txt hash.txt
# آنلاین:
#   https://crackstation.net
EOF
}