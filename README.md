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
- [دستورهای غیرقانونی](#دستورهای-غیرقانونی)
- [نصب](#نصب)
- [ساختار](#ساختار)
- [نحوه‌ی استفاده](#نحوه‌ی-استفاده)
- [دستورها](#دستورها)
- [چه چیزی واقعاً ممکن است](#چه-چیزهایی-واقعاً-ممکن-است)
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
