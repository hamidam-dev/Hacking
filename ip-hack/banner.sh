DESC="گرفتن بنر سرویس و نسخه"
RISK="MED"

termux(){ echo "nc <IP> 22"; }

kali(){
cat <<'EOF'
nc -nv <IP> 22
nc -nv <IP> 80
nmap -sV --script banner <IP> -p 21,22,25,80,110,143,443,3306
EOF
}
