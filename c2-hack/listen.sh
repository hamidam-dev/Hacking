DESC="شنونده خام با netcat"
RISK="LOW"

termux(){ echo "nc -lvnp 4444"; }

kali(){
cat <<'EOF'
nc -lvnp 4444
# ارتقای شل:
python3 -c 'import pty;pty.spawn("/bin/bash")'
export TERM=xterm
# یا:
rlwrap nc -lvnp 4444
EOF
}