DESC="مسیر شبکه تا هدف"
RISK="LOW"

termux(){ echo "pkg install traceroute; traceroute <IP>"; }

kali(){
cat <<'EOF'
traceroute -T -p 443 <IP>
mtr -rw <IP>
nmap --traceroute -p 443 <IP>
EOF
}
