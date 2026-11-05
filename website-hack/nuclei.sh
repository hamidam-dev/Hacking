DESC="اسکن CVE و misconfiguration"
REQ="nuclei"
RISK="HIGH"
NOTE="با -rl شروع کن. بدون rate کنترل، سایت ضعیف می‌افتد"

termux(){
cat <<'EOF'
pkg install golang
go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
nuclei -u https://<TARGET> -severity critical,high -rl 10
EOF
}

kali(){
cat <<'EOF'
nuclei -update-templates
nuclei -u https://<TARGET> -severity critical,high,medium -rl 50 -o nuclei.txt
nuclei -l alive.txt -tags cve -rl 30 -o cve.txt
nuclei -u https://<TARGET> -tags exposure,config -rl 30
EOF
}
