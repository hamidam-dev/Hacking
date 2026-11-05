DESC="گوگل‌دورک برای افشا"
RISK="LOW"

termux(){
cat <<'EOF'
site:<TARGET> ext:pdf
site:<TARGET> ext:xls OR ext:xlsx
site:<TARGET> inurl:admin
site:<TARGET> intitle:"index of"
site:<TARGET> intext:"password"
EOF
}

kali(){
cat <<'EOF'
# دستی در گوگل، یا با ابزار:
pip install pagodo
pagodo.py -d <TARGET> -g dorks.txt
# یا یک‌خطی:
for d in "ext:pdf" "ext:xlsx" "inurl:admin" "intitle:index of" "intext:password"; do
  echo "site:<TARGET> $d"
done
EOF
}
