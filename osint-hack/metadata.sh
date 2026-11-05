DESC="استخراج متادیتا از فایل"
REQ="exiftool"
RISK="LOW"

termux(){ echo "pkg install exiftool; exiftool image.jpg"; }

kali(){
cat <<'EOF'
exiftool image.jpg
exiftool -a -u -g1 image.jpg
exiftool -r -ext jpg -ext png ./folder
# GPS:
exiftool -GPS* image.jpg
EOF
}
