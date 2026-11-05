DESC="آنالیز فایل اجرایی ویندوز"
RISK="LOW"

termux(){ echo "# روی گوشی محدود است؛ از کالی استفاده کن"; }

kali(){
cat <<'EOF'
file evil.exe
strings -n 8 evil.exe | head -50
pefile evil.exe
# دیکامپایل .NET:
ilspycmd evil.exe -o out/
# تشخیص پکر:
die evil.exe
# سندباکس:
#   https://www.hybrid-analysis.com
#   https://any.run
EOF
}
