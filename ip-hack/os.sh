DESC="تشخیص سیستم‌عامل هدف"
RISK="MED"

termux(){ echo "nmap -O --osscan-guess <IP>"; }

kali(){
cat <<'EOF'
sudo nmap -O --osscan-guess --fuzzy <IP>
sudo nmap -p 445 --script smb-os-discovery <IP>
ping -c 3 <IP>   # TTL را ببین: 64=لینوکس، 128=ویندوز
EOF
}
