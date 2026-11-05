DESC="کشف سرویس‌هایی که با ایمیل ثبت‌نام شده"
REQ="holehe"
RISK="LOW"

termux(){ echo "pip install holehe && holehe target@gmail.com"; }

kali(){
cat <<'EOF'
pipx install holehe
holehe target@gmail.com
holehe -c 3 target@gmail.com
EOF
}
