DESC="کشف پارامترهای مخفی"
REQ="arjun"
RISK="MED"

termux(){ echo "pip install arjun && arjun -u https://<TARGET>/page"; }

kali(){
cat <<'EOF'
arjun -u https://<TARGET>/endpoint -m GET,POST
# از خروجی برای تست تزریق استفاده کن
cat urls.txt | grep '?' | cut -d? -f2 | tr '&' '\n' | cut -d= -f1 | sort -u
EOF
}
