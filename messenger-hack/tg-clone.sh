DESC="ساخت کاربربات تلگرام (کنترل با شماره)"
RISK="ToS"

termux(){ echo "pip install telethon; python3 -c \"from telethon.sync import TelegramClient\""; }

kali(){
cat <<'EOF'
pip install telethon
python3 - <<'PY'
from telethon.sync import TelegramClient
api_id, api_hash = 12345, "hash"
with TelegramClient("s", api_id, api_hash) as c:
    for d in c.iter_dialogs(limit=10):
        print(d.name, d.id)
PY
EOF
}
