DESC="آرشیو کانال تلگرام"
RISK="ToS"

termux(){ echo "pip install telethon"; }

kali(){
cat <<'EOF'
pip install telethon
# آرشیو کامل با telethon:
python3 - <<'PY'
from telethon.sync import TelegramClient
with TelegramClient("s", 12345, "hash") as c:
    for m in c.iter_messages("@channel", limit=500):
        print(m.date, m.sender_id, (m.text or "")[:200])
PY
EOF
}
