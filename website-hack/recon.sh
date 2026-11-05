DESC="شناسایی سطح حمله‌ی سایت"
REQ="subfinder httpx"
RISK="MED"
NOTE="همیشه اول robots.txt و security.txt"

termux(){
cat <<'EOF'
curl -s https://<TARGET>/robots.txt
curl -s https://<TARGET>/.well-known/security.txt
whois <TARGET>
dig +short <TARGET> ANY
nmap -sV -p 80,443,8080,8443 <TARGET>
EOF
}

kali(){
cat <<'EOF'
T=<TARGET>
mkdir -p out/$T && cd out/$T
curl -s "https://$T/robots.txt" | tee robots.txt
curl -s "https://$T/.well-known/security.txt" | tee security.txt
whois $T | tee whois.txt
dig +short $T ANY | tee dns.txt
subfinder -d $T -all -silent | anew subs.txt
httpx -l subs.txt -silent -title -tech-detect -o alive.txt
EOF
}
