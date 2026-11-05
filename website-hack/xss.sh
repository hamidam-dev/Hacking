DESC="تست XSS"
REQ="dalfox XSStrike"
RISK="HIGH"

termux(){ echo "pip install dalfox 2>/dev/null; dalfox url 'https://<TARGET>/?q=test'"; }

kali(){
cat <<'EOF'
dalfox url "https://<TARGET>/?q=test" --deep-domxss
dalfox file xss-candidates.txt --worker 5
# XSStrike:
python3 XSStrike/xsstrike.py -u "https://<TARGET>/?q=test" --crawl
EOF
}
