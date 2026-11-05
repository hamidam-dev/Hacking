DESC="تحلیل هدر ایمیل (جعل و مبدأ)"
RISK="LOW"

termux(){ echo "# هدر را در فایل ذخیره کن و در mxheader.com آپلود کن"; }

kali(){
cat <<'EOF'
cat header.txt | grep -iE 'received|spf|dkim|dmarc|return-path'
# ابزار:
pipx install parsedmarc
parsedmarc -f mail.eml -o out/
# آنالیز SPF:
dig +short TXT target.com | grep spf
EOF
}
