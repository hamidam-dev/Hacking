DESC="دانلود پست/استوری/متابعین"
REQ="instaloader"
RISK="ToS"
NOTE="با لاگین اکانت خودت هیت کمتر است"

termux(){ echo "pip install instaloader && instaloader --login=<you> profile"; }

kali(){
cat <<'EOF'
pipx install instaloader
instaloader --login=<YOUR_USER> --stories --highlights target_user
instaloader --login=<YOUR_USER> --comments --geotags --metadata-json target_user
instaloader --login=<YOUR_USER> --followers target_user
EOF
}
