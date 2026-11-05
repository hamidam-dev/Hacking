DESC="شناسایی پروفایل اینستاگرام"
REQ="toutatis"
RISK="LOW"

termux(){ echo "pip install toutatis && toutatis -u username -s sessionid"; }

kali(){
cat <<'EOF'
pipx install toutatis
toutatis -u target_user -s <SESSIONID>
# بدون لاگین، فقط عمومی:
curl -s "https://www.instagram.com/api/v1/users/web_profile_info/?username=target" \
  -H "x-ig-app-id: 936619743392459" | jq '.data.user | {id,full_name,biography,follower_count,is_private}'
EOF
}
