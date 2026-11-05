DESC="تحلیل DNS و انتقال ناحیه"
RISK="LOW"

termux(){ echo "dig +short <TARGET> ANY; dig +short <TARGET> MX"; }

kali(){
cat <<'EOF'
dig +short <TARGET> ANY
dig +short <TARGET> MX TXT NS
dig axfr <TARGET> @ns1.<TARGET>
dnsrecon -d <TARGET>
dnsenum <TARGET>
EOF
}
