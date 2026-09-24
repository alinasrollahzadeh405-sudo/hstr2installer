# hstr2installer

یک اسکریپت نصب و مدیریت حرفه‌ای و تولیدی برای Hysteria 2، بر پایه مستندات رسمی سایت v2.hysteria.network.

## ویژگی‌ها

- بررسی سطح دسترسی root
- نصب خودکار خودکار وابستگی‌ها: curl, wget, jq, qrencode, certbot, openssl
- نصب نسخه رسمی باینری Hysteria 2 از GitHub
- تولید فایل تنظیمات رسمی `/etc/hysteria/config.yaml`
- ساخت و فعال‌سازی سرویس systemd برای Hysteria
- منو تعاملی انگلیسی برای نصب و مدیریت
- پشتیبانی از 3 preset:
  - Preset A: High Speed / Gaming
  - Preset B: Stealth / Camouflage
  - Preset C: Custom / Advanced
- صدور گواهی SSL با Certbot Standalone
- تولید لینک Hy2 URI و نمایش QR Code
- ذخیره‌سازی اطلاعات کلاینت‌ها در مسیر `/etc/hysteria/clients`
- پشتیبانی از حالت‌های custom masquerade
- نسخه‌پشتی و بکاپ‌گیری از فایل پیکربندی قبلی
- حذف کامل و امن Hysteria 2 با گزینه uninstall

## پیش‌نیازها

- یک سرور یا VPS با سیستم‌عامل لینوکس
- دسترسی root
- دامنه معتبر برای استفاده با Certbot

## نصب

```bash
chmod +x hstr2installer
./hstr2installer
```

## گزینه‌های منو

1) Install & Auto-Configure Hysteria 2 (with Presets)
2) Issue SSL Certificate (Certbot Standalone)
3) Add User / Generate Client Config & QR Code
4) Manage Service (Start/Stop/Restart/Status)
5) Uninstall Hysteria 2
6) Exit

## Presets

### Preset A - High Speed / Gaming
- UDP-friendly configuration
- optimized latency
- aggressive performance tuning
- high bandwidth allowance

### Preset B - Stealth / Camouflage
- masquerade through HTTPS endpoint
- camouflage style behavior for better concealment
- suitable for stealth scenarios

### Preset C - Custom / Advanced
- custom port
- custom upload/download bandwidth
- custom masquerade URL or string response
- custom auth password

## نحوه صدور گواهی SSL

از گزینه 2 استفاده کنید و دامنه خود را وارد کنید. اسکریپت به‌صورت خودکار دستور Certbot را اجرا می‌کند:

```bash
certbot certonly --standalone -d "${dmn}" --non-interactive --agree-tos -m admin@"${dmn}"
```

سپس مسیرهای گواهی به‌صورت خودکار در فایل پیکربندی اعمال می‌شوند:

```yaml
cert: /etc/letsencrypt/live/${dmn}/fullchain.pem
key: /etc/letsencrypt/live/${dmn}/privkey.pem
```

## ساخت لینک کلاینت

اسکریپت لینک استاندارد Hysteria 2 را طبق فرمت زیر می‌سازد:

```text
hy2://${client_pass}@${dmn}:443/?insecure=0&sni=${dmn}#${client_name}
```

سپس لینک را نمایش می‌دهد و QR Code آن را در ترمینال تولید می‌کند.

## مسیرهای مهم

- باینری: `/usr/local/bin/hysteria`
- فایل پیکربندی: `/etc/hysteria/config.yaml`
- سرویس systemd: `/etc/systemd/system/hysteria.service`
- ذخیره کلاینت‌ها: `/etc/hysteria/clients`

## نکات مهم

- اسکریپت باید با دسترسی root اجرا شود.
- قبل از استفاده از TLS، حتماً گواهی SSL را صادر کنید.
- اگر از حالت masquerade proxy استفاده می‌کنید، URL را با دقت تنظیم کنید.
- فایل‌های کلاینت با نام `${client_name}.uri` و `${client_name}.txt` ذخیره می‌شوند.

## مثال اجرا

```bash
sudo ./hstr2installer
```

## توسعه و مشارکت

این پروژه به‌صورت ساده و تولیدی برای نصب و مدیریت Hysteria 2 طراحی شده است. اگر می‌خواهید، در آینده می‌توان افزونه‌هایی مثل:

- نمایش وضعیت شبکه
- ثبت لاگ
- کنترل مجازی برای کاربران
- پشتیبانی از OpenRC
- نوتیفیکیشن وضعیت سرویس

را هم به آن اضافه کرد.
