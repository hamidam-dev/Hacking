DESC="شنود و تحلیل ترافیک TLS"
RISK="MED"

termux(){ echo "pip install mitmproxy"; }

kali(){
cat <<'EOF'
sudo tcpdump -i eth0 -w cap.pcap 'tcp port 443'
tshark -r cap.pcap -Y 'tls.handshake' -T fields -e tls.handshake.extensions_server_name
# تحلیل:
tshark -r cap.pcap -q -z conv,tcp
EOF
}