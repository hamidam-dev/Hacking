DESC="کشف زیردامنه"
REQ="subfinder assetfinder"
RISK="LOW"

termux(){
cat <<'EOF'
pkg install golang
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
subfinder -d <TARGET> -all -silent
EOF
}

kali(){
cat <<'EOF'
subfinder -d <TARGET> -all -silent | anew subs.txt
assetfinder --subs-only <TARGET> | anew subs.txt
curl -s "https://crt.sh/?q=%25.<TARGET>&output=json" | jq -r '.[].name_value' | sort -u | anew subs.txt
dnsx -l subs.txt -silent -a -resp
EOF
}
