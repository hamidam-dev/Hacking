DESC="مکان‌یابی از روی تصویر"
RISK="LOW"

termux(){ echo "# از Google Lens و نقشه استفاده کن"; }

kali(){
cat <<'EOF'
# گام‌ها:
# 1. جستجوی معکوس تصویر
# 2. خواندن تابلوها و متن با OCR
tesseract image.jpg - -l eng+fas
# 3. تطبیق تیر چراغ، معماری، پوشش گیاهی با نقشه
# 4. تأیید با Street View
# ابزار:
pipx install geospy 2>/dev/null || true
EOF
}
