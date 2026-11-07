# hackit

جعبه‌ابزار تهاجمی خط فرمان — ترموکس و کالی

نسخه ۱.۰.۰

## فهرست

- این چیست
- هشدار حقوقی
- دستورهای غیرقانونی
- مخفی‌شدن
- نصب
- به‌روزرسانی
- ساختار
- استفاده
- جای‌گذاری مقادیر
- دستورها
- بعد از نفوذ
- اثر باقی‌مانده
- ممکن و ناممکن
- عیب‌یابی
- مجوز

## این چیست

hackit یک dispatcher خط فرمان است.

هر دسته یک پوشه است. هر ابزار یک ماژول.

هر ماژول دو بدنه دارد:

- termux — روی اندروید
- kali — روی کالی و دبیان

برنامه خودش محیط را تشخیص می‌دهد.

پیش‌فرض فقط نمایش دستور است. با --run اجرا می‌شود.

## هشدار حقوقی

ابزار مجرم نیست. نبود اجازه جرم است.

برچسب‌ها:

- LOW — فقط API عمومی یا آرشیو. تقریباً صفر.
- MED — درخواست فعال به هدف. خاکستری.
- HIGH — تزریق، کرک، اکسپلویت، MITM. مصداق ماده ۱.
- ToS — نقض شرایط سرویس. بن، نه پرونده.
- بدون برچسب — محلی، آزاد.

قبل از هر تست:

    curl -s https://TARGET/security.txt
    curl -s https://TARGET/.well-known/security.txt
    curl -s https://TARGET/robots.txt

## دستورهای غیرقانونی

بدون اجازه‌ی کتبی ریسک واقعی دارند:

- website-hack sqli — تزریق روی دیتابیس
- website-hack nuclei — اسکن CVE
- website-hack dirs — مسیرهای پنهان
- website-hack login — تلاش رمز
- website-hack upload — نوشتن فایل روی سرور
- website-hack ddos — تولید بار
- android-hack adb-connect — ورود به گوشی
- android-hack payload — نصب بکدور
- windows-hack payload — نصب بکدور
- windows-hack wmi و uac و persist — کنترل و ماندگاری
- wifi-hack handshake و pmkid و wps — کرک شبکه
- wifi-hack evil — ایول‌توین
- wifi-hack deauth — قطع کاربران
- camera-hack default — رمز دوربین
- messenger-hack session — تصاحب اکانت
- email-hack spray — تلاش رمز آفیس۳۶۵
- mitm-hack arp و dns و captive — شنود ترافیک
- password-hack hydra — بروت‌فورس

بی‌خطر: osint-hack، email-hack enumerate، social-hack ig-enum، ip-hack dns، website-hack headers، همه‌ی reverse-hack.

## مخفی‌شدن

- Tor — برای OSINT. برای اسکن کند است و بلاک می‌شود.
- VPN — برای اسکن. برای کار حساس لاگ دارد.
- VPS — برای اسکن سنگین و شنونده. آی‌پی ثابت و قابل انتساب.

بهترین ترکیب: VPS + VPN.

    pkg install tor proxychains4
    sudo apt install tor proxychains4
    tor &
    proxychains4 curl -s ifconfig.me

اگر آی‌پی عوض شد، Tor کار می‌کند.

    proxychains4 nmap -sT -Pn example.com -p 80,443

-sT چون SYN خام از SOCKS رد نمی‌شود.

-Pn چون ICMP از Tor رد نمی‌شود.

در /etc/proxychains4.conf:

    socks5 127.0.0.1 9050

قواعد:

- وسط اسکن آی‌پی عوض نکن
- با اکانت شخصی لاگین نکن
- masscan و hping3 با Tor کار نمی‌کنند
- برای آنها VPN یا VPS

## نصب

پیش‌نیاز ترموکس: Termux از F-Droid، Termux:API، golang.

پیش‌نیاز کالی: root، golang.

    git clone https://github.com/hamidam-dev/Hacking.git ~/hack2
    cd ~/hack2
    chmod +x hack install.sh update.sh
    hack install

بررسی:

    hack doctor

اگر نصب شکست خورد:

    cat /tmp/hackit-install.log | tail -30

اگر apt خراب بود:

    apt-get install -y --allow-downgrades postgresql-client-common postgresql-common
    apt-get -f install -y
    apt-get check

### ترموکس

سه بسته از مخزن حذف شده‌اند:

- aircrack-ng — از مخزن جانشین
- hydra — دبیان با proot-distro
- metasploit — دبیان با proot-distro

    pkg install -y wget
    cd ~
    curl -LO https://raw.githubusercontent.com/pitube08642/aircrack-ng-for-termux/main/dists/termux/aircrack-ng/binary-i686/aircrack-ng_3_1.7_i686.deb
    dpkg -i aircrack-ng_3_1.7_i686.deb

pkg install را چندتایی در یک خط نزن.

proot-distro install kali کار نمی‌کند. از debian استفاده کن:

    pkg install -y proot-distro
    proot-distro install debian
    proot-distro login debian
    apt update
    apt install -y hydra metasploit-framework aircrack-ng mitmproxy

اگر mitmproxy روی i686 شکست خورد:

    pkg install -y rust binutils
    pip install mitmproxy

اگر uname -m مقدار i686 داد، شبیه‌ساز x86_64 یا ماشین مجازی بهتر است.

خطای py3compile هنگام نصب بسته‌های پایتون بی‌خطر است.

### نصب دستی

- android-hack — adb، scrcpy، Termux:API
- windows-hack — msfvenom، msfconsole، impacket، xfreerdp
- website-hack — subfinder، httpx، nuclei، ffuf، sqlmap، dalfox، wafw00f
- ip-hack — nmap، masscan، dig، whois
- wifi-hack — aircrack-ng، hcxdumptool، hcxtools، reaver
- messenger-hack — frida، mitmproxy، nodejs
- social-hack — instaloader، toutatis، sherlock، maigret
- email-hack — holehe، ghunt، o365spray
- osint-hack — exiftool، phoneinfoga، tesseract
- reverse-hack — jadx، apktool، apkleaks، objection
- mitm-hack — mitmproxy، bettercap، ngrok
- password-hack — hydra، hashcat، john، cupp

## به‌روزرسانی

    hack update

دستی:

    cd ~/hack2
    git stash
    git pull
    git stash pop
    chmod +x hack install.sh update.sh

اگر git pull تداخل داد:

    git checkout -- hack
    git pull
    chmod +x hack

git pull بیت اجرا را پاک می‌کند. همیشه بعدش chmod بزن.

### دستورهای خود مخزن

- hack list — فهرست دسته‌ها
- hack install — نصب خودکار
- hack update — به‌روزرسانی
- hack doctor — بررسی محیط
- hack version — نسخه

## ساختار

    hackit/
    ├── hack
    ├── install.sh
    ├── update.sh
    ├── lib/common.sh
    ├── lib/detect.sh
    ├── conf/deps.txt
    ├── docs/REALITY.md
    ├── docs/WORKFLOW.md
    └── <دسته>-hack/
        ├── category.conf
        └── <ماژول>.sh

## استفاده

    hack list
    hack website-hack
    hack website-hack nuclei
    hack website-hack nuclei --run
    hack wifi-hack handshake --both
    hack android-hack camera --kali

پرچم‌ها:

- --run — اجرای واقعی
- --termux — اجبار ترموکس
- --kali — اجبار کالی
- --both — هر دو روش

## جای‌گذاری مقادیر

این کلمه‌ها را با مقدار واقعی عوض کن:

- TARGET — دامنه، بدون https. نمونه: example.com
- URL — آدرس کامل. نمونه: https://example.com/p.php?id=1
- IP — آی‌پی هدف. نمونه: 192.168.1.50
- PORT — پورت. نمونه: 443
- USER — نام کاربری. نمونه: admin
- PASS — رمز. نمونه: admin
- BSSID — مک روتر. نمونه: AA:BB:CC:DD:EE:FF
- CHANNEL — کانال. نمونه: 6
- IFACE — کارت شبکه. نمونه: wlan0
- SERVER — سرور شنونده. نمونه: 1.2.3.4
- WORDLIST — وردلیست. نمونه: /usr/share/wordlists/rockyou.txt
- TOKEN — توکن API. نمونه: abc123

غلط و درست:

- nmap -sV TARGET ← nmap -sV example.com
- sqlmap -u "URL" ← sqlmap -u "https://example.com/p.php?id=1"
- hydra ssh://IP ← hydra ssh://192.168.1.50

## دستورها

### android-hack

- adb-connect — اتصال ADB بی‌سیم. پیش‌نیاز: دیباگ بی‌سیم. HIGH
- camera — عکس از دوربین. پیش‌نیاز: ADB. LOW
- screen — اسکرین‌شات. ADB. LOW
- scrcpy — میرور زنده. scrcpy. LOW
- contacts — مخاطبین. ADB. LOW
- sms — پیامک. ADB. MED
- mic — ضبط صدا. ADB. LOW
- files — کشیدن فایل. ADB. MED
- loc — موقعیت. ADB. LOW
- apps — لیست اپ. ADB. MED
- payload — APK بکدور. msfvenom. HIGH
- nearby — گوشی‌های هم‌شبکه. nmap. LOW
- clipboard — کلیپ‌بورد. ADB. LOW
- keylog — ثبت کلید. ADB. MED

### windows-hack

- payload — EXE بکدور. msfvenom. HIGH
- webcam — وبکم. session. LOW
- screen — صفحه. session. LOW
- keys — کی‌لاگر. session. MED
- files — فایل. session. MED
- creds — رمز ذخیره‌شده. SYSTEM. HIGH
- sam — هش SAM. ادمین. HIGH
- rdp — RDP. پورت ۳۳۸۹. LOW
- smb — SMB. پورت ۴۴۵. HIGH
- wmi — دستور از راه دور. ادمین. HIGH
- uac — دور زدن UAC. session. HIGH
- persist — ماندگاری. SYSTEM. HIGH

### linux-hack

- enum — enumeration. shell. LOW
- privesc — ارتقای دسترسی. shell. HIGH
- ssh — بروت‌فورس SSH. پورت ۲۲. HIGH
- suid — سوءاستفاده SUID. shell. HIGH
- cron — سوءاستفاده کران. shell. HIGH
- creds — جستجوی رمز. shell. MED
- docker — فرار از کانتینر. shell. HIGH
- payload — ELF بکدور. msfvenom. HIGH

### website-hack

- recon — سطح حمله. subfinder و httpx. MED
- subdomain — زیردامنه. subfinder. LOW
- fingerprint — تکنولوژی. whatweb. LOW
- waf — فایروال. wafw00f. LOW
- dork — گوگل‌دورک. بدون پیش‌نیاز. LOW
- dirs — مسیر پنهان. ffuf. HIGH
- params — پارامتر. arjun. MED
- nuclei — CVE. nuclei. HIGH
- sqli — SQLi. sqlmap. HIGH
- xss — XSS. dalfox. HIGH
- lfi — path traversal. curl. HIGH
- ssrf — SSRF. interactsh. HIGH
- upload — دور زدن آپلود. curl. HIGH
- login — فرم لاگین. hydra. HIGH
- jwt — JWT. jwt_tool. HIGH
- cms — CMS. wpscan. HIGH
- ddos — تست بار. ab. MED
- headers — هدر امنیتی. curl. LOW

### ip-hack

- scan — پورت. nmap. MED
- ping — میزبان زنده. nmap. LOW
- os — سیستم‌عامل. nmap. MED
- shodan — Shodan. API key. LOW
- masscan — اسکن انبوه. masscan. HIGH
- banner — بنر. nc. MED
- snmp — SNMP. snmpwalk. MED
- dns — DNS. dig. LOW
- traceroute — مسیر. traceroute. LOW
- arp — ARP. arp-scan. LOW

### wifi-hack

- scan — اسکن شبکه. monitor mode. LOW
- handshake — هندشیک. monitor و کلاینت. HIGH
- pmkid — PMKID. hcxdumptool. HIGH
- crack — کرک هش. hashcat. LOW
- wps — WPS. reaver. HIGH
- evil — ایول‌توین. wifiphisher. HIGH
- deauth — قطع کاربر. aireplay-ng. MED
- wep — WEP. aircrack-ng. MED
- monitor — مانیتور مود. root. LOW

### camera-hack

- discover — کشف دوربین. nmap. LOW
- default — رمز پیش‌فرض. hydra. HIGH
- rtsp — استریم. ffmpeg. MED
- snapshot — عکس. curl. LOW
- webcam-phone — دوربین گوشی. ADB. LOW
- webcam-pc — وبکم. session. LOW
- ddns — دوربین عمومی. Shodan. LOW

### messenger-hack

- wa-enum — شماره واتساپ. ignorant. LOW
- wa-clone — کلاینت غیررسمی. Node. ToS
- wa-analyze — آنالیز ترافیک. frida. MED
- tg-enum — اکانت تلگرام. curl. LOW
- tg-clone — کاربربات. telethon. ToS
- tg-archive — آرشیو کانال. telethon. ToS
- rubika — آنالیز روبیکا. apk-mitm. ToS
- bale — آنالیز بله. apk-mitm. ToS
- session — دزدیدن سشن. دامنه و VPS. HIGH

### social-hack

- ig-enum — پروفایل. toutatis. LOW
- ig-dump — دانلود محتوا. instaloader. ToS
- ig-analyze — آنالیز ترافیک. frida. MED
- ig-session — تصاحب اکانت. evilginx2. HIGH
- fb-enum — فیس‌بوک. curl. LOW
- x-enum — ایکس. curl. LOW
- tiktok — تیک‌تاک. curl. LOW
- username — ردیابی یوزرنیم. maigret. LOW

### email-hack

- enumerate — اکانت‌های ثبت‌شده. holehe. LOW
- ghunt — OSINT گوگل. ghunt. LOW
- spray — اسپری آفیس۳۶۵. o365spray. HIGH
- verify — اعتبارسنجی. dig. LOW
- breach — لو رفتن. API key. LOW
- header — تحلیل هدر. parsedmarc. LOW
- smtp — SMTP. swaks. MED

### osint-hack

- phone — شماره. phoneinfoga. LOW
- name — نام. maigret. LOW
- image — تصویر معکوس. بدون پیش‌نیاز. LOW
- geoloc — مکان‌یابی. tesseract. LOW
- metadata — متادیتا. exiftool. LOW
- domain — دامنه. whois. LOW
- paste — لیک. curl. LOW
- people — افراد. sherlock. LOW

### reverse-hack

- apk-static — آنالیز APK. MobSF. LOW
- apk-secrets — استخراج سکرت. apkleaks. LOW
- decompile — دیکامپایل. jadx. LOW
- frida — هوک. frida-tools. MED
- pinning — دور زدن pinning. objection. MED
- exe — فایل ویندوز. pefile. LOW
- js — دی‌ابفاسکیت. jsbeautifier. LOW

### mitm-hack

- proxy — پروکسی شنود. mitmproxy. MED
- arp — ARP spoof. bettercap. HIGH
- dns — مسموم‌سازی DNS. bettercap. HIGH
- tls — شنود TLS. tcpdump. MED
- captive — پورتال جعلی. wifiphisher. HIGH
- ngrok — سرویس محلی. ngrok. MED

### password-hack

- generate — وردلیست. cupp. LOW
- rule — قاعده mutation. hashcat. LOW
- hydra — بروت‌فورس. hydra. HIGH
- hashid — نوع هش. hashid. LOW
- hashcrack — کرک هش. hashcat. LOW
- cupp — وردلیست هدفمند. cupp. LOW

### c2-hack

- msf — شنونده. msfconsole. MED
- venom — پیلود. msfvenom. HIGH
- stager — استیجر. msfvenom. HIGH
- encode — بایپس AV. msfvenom. HIGH
- listen — شنونده خام. nc. LOW
- transfer — انتقال پیلود. python3. MED

## بعد از نفوذ

### وبسایت

- با SQLi می‌توانی دیتابیس را dump کنی. صفحه را نمی‌توانی عوض کنی.
- با پنل ادمین محتوا و کاربر را می‌توانی. فایل سرور را نه.
- با RCE هر فایل و دیفیس. دامنه را نه.
- با اکانت registrar می‌توانی NS را عوض کنی.

    sqlmap -u "URL" --batch --dump-all --output-dir=backup

    UPDATE users SET password = '<hash>' WHERE username = 'admin';
    DROP DATABASE dbname;

    cp index.php index.php.bak
    echo '<h1>pwned</h1>' > index.php

اول dump-all، بعد DROP.

مالکیت سه چیز جداست: محتوا، سرور، دامنه. دامنه از هک سایت به‌دست نمی‌آید.

### اکانت

با کوکی سشن:

    کوکی → تغییر ایمیل به ایمیل خودت
          → Forgot password → کد به ایمیل جدید
          → رمز جدید → 2FA → Revoke all sessions

اول ایمیل، بعد رمز. برعکس کنی، کد به ایمیل قدیمی می‌رود و گیر می‌کنی.

واتساپ رمز ندارد. با QR چت می‌خوانی. تا حذف دستگاه از طرف مالک، دسترسی داری.

### گوشی

- با ADB فایل و دوربین و پیامک. رمز گوگل و چت واتساپ نه.
- با ADB و پیامک می‌توانی جیمیل را ریست کنی. قفل صفحه را نه.

## اثر باقی‌مانده

- اسکن پورت — در لاگ فایروال
- SQLi — کوئری سنگین در لاگ
- فازینگ — هزاران ۴۰۴
- نصب RAT — فایل ناشناس، مصرف باتری
- تغییر رمز — ایمیل هشدار
- دیفیس — فوراً دیده می‌شود

پاک کردن اثر کامل ممکن نیست. لاگ سرور دست تو نیست.

## ممکن و ناممکن

ممکن:

- ADB بی‌سیم با دیباگ روشن
- Meterpreter با نصب کاربر
- RTSP روی دوربین در شبکه
- evilginx2 با کلیک کاربر
- هندشیک با کارت monitor mode

ناممکن:

- هک اینستا فقط با یوزرنیم
- پیامک اندروید ۱۳+ بدون روت
- صفحه‌ی گوشی بدون ADB یا RAT
- وای‌فای بدون مانیتور مود
- DDoS واقعی از یک لپ‌تاپ

## عیب‌یابی

- دسته نبود ← hack list
- نصب نیست ← hack install
- Permission denied ← chmod +x hack install.sh update.sh
- adb: no devices ← adb kill-server && adb start-server
- دوربین سیاه ← اپ دوربین را باز کن
- monitor mode ← sudo airmon-ng check kill
- nuclei کند ← -rl 10
- خطای ۵۰۳ ← نرخ را نصف کن، ۵ دقیقه صبر
- lib/common.sh نبود ← ln -sf ~/hack2/hack $PREFIX/bin/hack
- نصب بسته شکست خورد ← cat /tmp/hackit-install.log
- apt خراب ← apt-get -f install -y

## مجوز

MIT — برای کد مخزن. هر ابزار لایسنس خودش را دارد.
