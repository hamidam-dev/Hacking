DESC="اسکن CMS (وردپرس/جوملا)"
RISK="HIGH"

termux(){ echo "pip install wpscan? ندارد؛ از api استفاده کن: https://wpscan.com/api"; }

kali(){
cat <<'EOF'
wpscan --url https://<TARGET> --enumerate vp,vt,u --api-token <TOKEN>
wpscan --url https://<TARGET> --passwords rockyou.txt --usernames admin
joomscan -u https://<TARGET>
droopescan scan drupal -u https://<TARGET>
EOF
}
