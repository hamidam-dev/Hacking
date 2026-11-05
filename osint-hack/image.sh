DESC="جستجوی معکوس تصویر"
RISK="LOW"

termux(){ echo "# تصویر را در مرورگر آپلود کن: lens.google.com / yandex.com/images / tineye.com"; }

kali(){
cat <<'EOF'
# آپلود خودکار با yandex:
curl -s -F "upfile=@image.jpg" "https://yandex.com/images/search" -o /dev/null
# یا ابزار:
pipx install picimagesearch
picimagesearch image.jpg
EOF
}
