DESC="بررسی هدرهای امنیتی"
RISK="LOW"

termux(){ echo "curl -sI https://<TARGET>"; }

kali(){
cat <<'EOF'
curl -sI https://<TARGET> | grep -iE 'strict-transport|content-security|x-frame|x-content-type|referrer|permissions'
nuclei -u https://<TARGET> -tags headers -silent
# ارزیابی: https://securityheaders.com
EOF
}
