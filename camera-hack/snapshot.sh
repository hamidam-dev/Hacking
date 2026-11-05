DESC="گرفتن اسنپ‌شات از دوربین IP"
RISK="LOW"

termux(){ echo "curl -s -o s.jpg 'http://<IP>/snapshot.jpg'"; }

kali(){
cat <<'EOF'
curl -s -o s.jpg "http://<IP>/snapshot.cgi"
curl -s -o s.jpg "http://<IP>/ISAPI/Streaming/channels/101/picture"
curl -s -u admin:admin -o s.jpg "http://<IP>/snapshot.jpg"
file s.jpg
EOF
}
