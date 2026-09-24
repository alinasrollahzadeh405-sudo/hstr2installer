# انتشار نسخه و نصب روی VPS

## ساخت نسخه رسمی

نسخه‌ها با Semantic Versioning و تگ‌هایی مانند `v1.0.0` منتشر می‌شوند:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

Workflow مربوط به release پس از push تگ، اسکریپت‌ها را بررسی می‌کند، آرشیو قابل انتقال می‌سازد، فایل checksum تولید می‌کند و GitHub Release ایجاد می‌کند.

## اعتبارسنجی خودکار

Workflow مربوط به CI در push به `main` و Pull Requestها اجرا می‌شود و موارد زیر را بررسی می‌کند:

- صحت syntax تمام اسکریپت‌های Bash با `bash -n`
- اجرای ShellCheck

## نصب سریع روی VPS

برای دریافت نسخه جاری از branch اصلی:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh | sudo bash
```

برای نصب یک نسخه مشخص:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh \
  | sudo HSTR2_VERSION=v1.0.0 bash
```

برای فقط نصب فایل بدون اجرای فوری:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh \
  | sudo HSTR2_NO_EXEC=1 bash
```

مسیر پیش‌فرض نصب:

```text
/usr/local/sbin/hstr2installer
```

## بررسی checksum

آرشیو release و فایل `.sha256` را از صفحه Release دریافت کنید و سپس اجرا کنید:

```bash
sha256sum -c hstr2installer-v1.0.0.tar.gz.sha256
```

## نکات انتشار تولیدی

- قبل از ساخت تگ، تغییرات را روی VPS آزمایشی بررسی کنید.
- از انتشار تگ‌های قابل تغییر خودداری کنید.
- برای نسخه‌های مهم، checksum را در release نگه دارید.
- secrets غیرضروری در GitHub Actions استفاده نشده‌اند؛ انتشار با `GITHUB_TOKEN` انجام می‌شود.
