DESC="شناسایی اکانت تیک‌تاک"
RISK="LOW"

termux(){ echo "curl -s 'https://www.tiktok.com/@username'"; }

kali(){
cat <<'EOF'
curl -s "https://www.tiktok.com/@username" -A "Mozilla/5.0" | grep -oE '"uniqueId":"[^"]*"|"followerCount":[0-9]*'
# دانلود:
pipx install yt-dlp && yt-dlp "https://www.tiktok.com/@username"
EOF
}
