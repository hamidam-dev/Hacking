DESC="بررسی و سوءاستفاده از SMTP"
RISK="MED"

termux(){ echo "nc -nv <IP> 25"; }

kali(){
cat <<'EOF'
nmap -p 25,465,587 --script smtp-enum-users,smtp-open-relay <IP>
smtp-user-enum -M VRFY -U users.txt -t <IP>
# تست open relay:
swaks --to a@b.c --server <IP>
EOF
}
