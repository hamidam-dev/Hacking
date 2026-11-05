DESC="تشخیص تکنولوژی، نسخه و سرور"
REQ="httpx whatweb"
RISK="LOW"

termux(){ echo "curl -sI https://<TARGET>; curl -s https://<TARGET> | grep -iE 'generator|wp-content|laravel'"; }

kali(){
cat <<'EOF'
whatweb -a 3 https://<TARGET>
httpx -u https://<TARGET> -tech-detect -title -status-code -web-server
curl -sI https://<TARGET>
nuclei -u https://<TARGET> -tags tech -silent
EOF
}
