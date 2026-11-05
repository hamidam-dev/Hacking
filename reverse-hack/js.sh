DESC="دی‌ابفاسکیت و خواندن جاوااسکریپت"
RISK="LOW"

termux(){ echo "pip install jsbeautifier; js-beautify in.js > out.js"; }

kali(){
cat <<'EOF'
pipx install jsbeautifier
js-beautify in.js > out.js
# یا:
npx prettier --write in.js
# دی‌ابفاسکیت:
npx deobfuscator in.js out.js
# سورس‌مپ:
grep -o 'sourceMappingURL=[^ ]*' in.js
EOF
}
