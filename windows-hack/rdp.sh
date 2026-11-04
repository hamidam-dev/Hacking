DESC="اتصال به دسکتاپ راه دور هدف"
REQ="پورت ۳۳۸۹ باز + اعتبارنامه"
RISK="LOW"

termux(){
cat <<'EOF'
pkg install x11-repo && pkg install tigervnc
vncviewer <IP>:3389
EOF
}

kali(){
cat <<'EOF'
nmap -p 3389 --script rdp-ntlm-info <IP>
xfreerdp /v:<IP> /u:<user> /p:<pass> /dynamic-resolution /sec:tls
rdesktop -u <user> -p <pass> <IP>
EOF
}
