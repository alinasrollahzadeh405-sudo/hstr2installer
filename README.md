# hstr2installer

[🇬🇧 English documentation](README_EN.MD)

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
  - **Preset A — High Speed / Gaming**: مناسب سرعت و تأخیر پایین
  - **Preset B — Stealth / Camouflage**: دارای TLS masquerade و proxy
  - **Preset C — Custom / Advanced**: تنظیم دستی پورت، پهنای‌باند، masquerade و رمز عبور
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
git clone https://github.com/alinasrollahzadeh405-sudo/hstr2installer.git
cd hstr2installer
chmod +x hstr2installer
sudo ./hstr2installer
```

یا می‌توانید فایل را مستقیماً دریافت و اجرا کنید:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/hstr2installer -o hstr2installer
chmod +x hstr2installer
sudo ./hstr2installer
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

این preset با پورت 443، پهنای‌باند نامحدود و masquerade پروکسی ایجاد می‌شود و برای سناریوهای سرعت و تأخیر پایین مناسب است. رمز عبور به‌صورت تصادفی و امن تولید می‌شود.

### Preset B — Stealth / Camouflage

این preset از proxy masquerade با مقصد زیر استفاده می‌کند:

```text
https://www.bing.com/
```

همچنین گزینه `rewriteHost` فعال می‌شود تا رفتار proxy مطابق ساختار رسمی Hysteria 2 باشد.

### Preset C — Custom / Advanced

در این حالت می‌توانید موارد زیر را تعیین کنید:

- پورت شنود
- محدودیت upload و download مانند `100 mbps`
- نوع masquerade: `proxy` یا `string`
- آدرس proxy یا متن پاسخ سفارشی
- رمز عبور احراز هویت

## صدور گواهی SSL

ابتدا مطمئن شوید پورت 80 در دسترس است و سرویس دیگری آن را اشغال نکرده است. سپس گزینه 2 را انتخاب کنید. اسکریپت دستور رسمی زیر را اجرا می‌کند:

```bash
certbot certonly --standalone -d "${dmn}" --non-interactive --agree-tos -m admin@"${dmn}"
```

مسیرهای گواهی در کانفیگ به‌صورت زیر ثبت می‌شوند:

```yaml
tls:
  cert: /etc/letsencrypt/live/${dmn}/fullchain.pem
  key: /etc/letsencrypt/live/${dmn}/privkey.pem
```

## تولید کلاینت و QR Code

از گزینه 3 استفاده کنید و شناسه و رمز عبور کلاینت را وارد کنید. لینک استاندارد تولیدشده به این شکل است:

```text
hy2://${client_pass}@${dmn}:443/?insecure=0&sni=${dmn}#${client_name}
```

فایل‌های خروجی در مسیر زیر ذخیره می‌شوند:

```text
/etc/hysteria/clients/${client_name}.uri
/etc/hysteria/clients/${client_name}.txt
```

## مدیریت سرویس

```bash
systemctl status hysteria.service
systemctl restart hysteria.service
journalctl -u hysteria.service -f
```

سرویس از فایل زیر استفاده می‌کند:

```text
/etc/systemd/system/hysteria.service
```

## مسیرهای مهم

| مورد | مسیر |
|---|---|
| باینری | `/usr/local/bin/hysteria` |
| کانفیگ | `/etc/hysteria/config.yaml` |
| دامنه ذخیره‌شده | `/etc/hysteria/domain` |
| رمز احراز هویت | `/etc/hysteria/auth.secret` |
| کلاینت‌ها | `/etc/hysteria/clients/` |
| سرویس systemd | `/etc/systemd/system/hysteria.service` |
| بکاپ کانفیگ | `/etc/hysteria/config.yaml.bak.*` |

## امنیت و نگهداری

- فایل کانفیگ و اطلاعات حساس با permission محدود ذخیره می‌شوند.
- رمز عبور را در اختیار افراد غیرمجاز قرار ندهید.
- پیش از تغییر کانفیگ، نسخه پشتیبان خودکار ایجاد می‌شود.
- پس از هر تغییر، کانفیگ با دستور بررسی رسمی باینری Hysteria اعتبارسنجی می‌شود.
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
