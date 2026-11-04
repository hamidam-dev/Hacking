DESC="بررسی و بهره‌برداری SMB"
REQ="پورت ۴۴۵"
RISK="HIGH"

termux(){ echo "nmap -p445 --script smb-os-discovery,smb-enum-shares <IP>"; }

kali(){
cat <<'EOF'
nmap -p 445 --script "smb-vuln-*,smb-enum-shares,smb-os-discovery" <IP>
enum4linux-ng -A <IP>
nxc smb <IP> -u '' -p '' --shares
nxc smb <IP> -u user -p pass --shares
EOF
}
