DESC="کشف مسیر و فایل پنهان"
REQ="ffuf gobuster"
RISK="HIGH"
NOTE="نرخ را پایین نگه دار: -rate 40"

termux(){
cat <<'EOF'
pkg install ffuf
ffuf -u https://<TARGET>/FUZZ -w wordlist.txt -mc 200,301,302,401,403 -rate 20
EOF
}

kali(){
cat <<'EOF'
ffuf -u https://<TARGET>/FUZZ \
  -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt \
  -mc 200,204,301,302,401,403 -rate 40 -o dirs.json -of json

gobuster dir -u https://<TARGET> -w /usr/share/seclists/Discovery/Web-Content/common.txt -t 20

# فایل‌های حساس:
ffuf -u https://<TARGET>/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-small-files.txt \
  -mc 200 -rate 30
EOF
}
