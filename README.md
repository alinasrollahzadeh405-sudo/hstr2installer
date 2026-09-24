# hstr2installer

[🇬🇧 English documentation](README_EN.MD) | [CHANGELOG](CHANGELOG.md) | [Security](SECURITY.md) | [Contributing](CONTRIBUTING.md) | [Code of Conduct](CODE_OF_CONDUCT.md)

یک ابزار نصب، پیکربندی و مدیریت حرفه‌ای Hysteria 2 بر پایه مستندات رسمی [v2.hysteria.network](https://v2.hysteria.network) است.

## امکانات

- اجرای اجباری با دسترسی `root`
- شناسایی معماری `amd64` و `arm64`
- دریافت جدیدترین باینری رسمی Hysteria 2 از مخزن رسمی GitHub
- نصب خودکار وابستگی‌ها: `curl`، `wget`، `jq`، `qrencode`، `certbot` و `openssl`
- تولید و اعتبارسنجی فایل رسمی `/etc/hysteria/config.yaml`
- ساخت، فعال‌سازی و مدیریت سرویس `systemd`
- رابط تعاملی انگلیسی با خروجی رنگی
- سه preset تخصصی:
  - **Preset A — High Speed / Gaming**
  - **Preset B — Stealth / Camouflage**
  - **Preset C — Custom / Advanced**
- صدور گواهی SSL با Certbot در حالت Standalone
- تولید لینک استاندارد `hy2://` و QR Code در ترمینال
- ذخیره امن لینک‌های کلاینت در `/etc/hysteria/clients`
- نسخه پشتیبان خودکار از پیکربندی پیشین
- اعتبارسنجی کانفیگ پیش از راه‌اندازی سرویس
- امکان حذف کامل Hysteria 2 و فایل‌های وابسته

## پیش‌نیازها

- سیستم‌عامل لینوکس دارای یکی از package managerهای `apt`، `dnf`، `yum`، `apk`، `pacman` یا `zypper`
- دسترسی root یا `sudo`
- دامنه‌ای که به IP سرور اشاره کند
- آزاد بودن پورت انتخابی، به‌ویژه پورت `443` برای حالت پیش‌فرض

## نصب و اجرا

```bash
chmod +x hstr2installer
sudo ./hstr2installer
```

یا فایل نصب جداگانه را اجرا کنید:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh | sudo bash
```

## منوی اصلی

1. `Install & Auto-Configure Hysteria 2`
2. `Issue SSL Certificate (Certbot Standalone)`
3. `Add User / Generate Client Config & QR Code`
4. `Manage Service (Start/Stop/Restart/Status)`
5. `Uninstall Hysteria 2`
6. `Exit`

## راهنمای presetها

### Preset A — High Speed / Gaming

این preset، Hysteria 2 را با پورت 443 و تنظیمات با تأخیر پایین و پهنای‌باند نامحدود آماده می‌کند. مناسب سناریوهای سرعت و بازی است.

### Preset B — Stealth / Camouflage

این preset از masquerade proxy روی `https://www.bing.com/` استفاده می‌کند تا رفتار سرویس شبیه ترافیک HTTPS عادی شود.

### Preset C — Custom / Advanced

در این حالت، کاربر می‌تواند پورت، bandwidth، masquerade نوع proxy/string و پارامترهای احراز هویت را به‌صورت دستی وارد کند.

## صدور گواهی SSL

```bash
certbot certonly --standalone -d "${dmn}" --non-interactive --agree-tos -m admin@"${dmn}"
```

## تولید کلاینت و QR Code

```text
hy2://${client_pass}@${dmn}:443/?insecure=0&sni=${dmn}#${client_name}
```

## مدیریت سرویس

```bash
systemctl status hysteria.service
systemctl restart hysteria.service
journalctl -u hysteria.service -f
```

## مسیرهای مهم

- باینری: `/usr/local/bin/hysteria`
- فایل پیکربندی: `/etc/hysteria/config.yaml`
- دامنه ذخیره‌شده: `/etc/hysteria/domain`
- رمز احراز هویت: `/etc/hysteria/auth.secret`
- کلاینت‌ها: `/etc/hysteria/clients/`
- سرویس systemd: `/etc/systemd/system/hysteria.service`
- بکاپ کانفیگ: `/etc/hysteria/config.yaml.bak.*`

## امنیت و نگهداری

- فایل کانفیگ و اطلاعات حساس با permission محدود ذخیره می‌شوند.
- رمز عبور را در اختیار افراد غیرمجاز قرار ندهید.
- پیش از تغییر کانفیگ، نسخه پشتیبان خودکار ایجاد می‌شود.
- برای تمدید گواهی، اجرای دوره‌ای `certbot renew` را در سیستم فعال نگه دارید.
- قبل از اجرای Certbot Standalone، مطمئن شوید پورت 80 آزاد است.

## حذف

از منوی برنامه گزینه `Uninstall Hysteria 2` را انتخاب کنید. این گزینه باینری، سرویس، کانفیگ و فایل‌های کلاینت را حذف می‌کند و درباره حذف گواهی‌های Let's Encrypt نیز سؤال خواهد کرد.

## منابع رسمی

- [مستندات Hysteria 2](https://v2.hysteria.network)
- [تنظیمات سرور](https://v2.hysteria.network/docs/config/server/)
- [تنظیمات کامل سرور](https://v2.hysteria.network/docs/advanced/Full-Server-Config/)
- [نسخه‌های رسمی GitHub](https://github.com/apernet/hysteria/releases)

## مجوز

این پروژه تحت مجوز موجود در فایل `LICENSE` منتشر شده است.
