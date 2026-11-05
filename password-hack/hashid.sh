DESC="تشخیص نوع هش"
RISK="LOW"

termux(){ echo "pip install hashid; hashid 'HASH'"; }

kali(){
cat <<'EOF'
pipx install hashid
hashid '5f4dcc3b5aa765d61d8327deb882cf99'
hash-identifier
EOF
}