DESC="تشخیص فایروال وب"
REQ="wafw00f"
RISK="LOW"

termux(){ echo "pip install wafw00f && wafw00f https://<TARGET>"; }

kali(){
cat <<'EOF'
wafw00f https://<TARGET>
# اگر کلادفلر بود، دنبال origin IP بگرد:
curl -s "https://crt.sh/?q=%25.<TARGET>&output=json" | jq -r '.[].name_value' | sort -u
# favicon hash + shodan
python3 -c "
import mmh3,requests,codecs
r=requests.get('https://<TARGET>/favicon.ico')
print(mmh3.hash(codecs.encode(r.content,'base64')))
"
EOF
}
