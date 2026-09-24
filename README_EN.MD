# hstr2installer

[🇮🇷 مستندات فارسی](README.md)

A production-oriented installer, configurator, and management utility for Hysteria 2, based on the official documentation at [v2.hysteria.network](https://v2.hysteria.network).

## Features

- Enforces execution as `root`
- Detects `amd64` and `arm64` CPU architectures
- Downloads the latest official Hysteria 2 binary from the upstream GitHub repository
- Installs required dependencies: `curl`, `wget`, `jq`, `qrencode`, `certbot`, and `openssl`
- Generates and validates `/etc/hysteria/config.yaml`
- Creates, enables, and manages a `systemd` service
- Interactive English CLI with colored output
- Three configuration presets:
  - **Preset A — High Speed / Gaming**
  - **Preset B — Stealth / Camouflage**
  - **Preset C — Custom / Advanced**
- Issues TLS certificates with Certbot Standalone
- Generates standard `hy2://` client links and terminal QR codes
- Stores generated client links under `/etc/hysteria/clients`
- Creates timestamped configuration backups before changes
- Validates configuration before restarting the service
- Includes a complete uninstall flow

## Requirements

- A Linux server with one of: `apt`, `dnf`, `yum`, `apk`, `pacman`, or `zypper`
- `root` or `sudo` access
- A domain pointing to the server IP
- The selected port available; the default setup uses port `443`

## Installation

```bash
git clone https://github.com/alinasrollahzadeh405-sudo/hstr2installer.git
cd hstr2installer
chmod +x hstr2installer
sudo ./hstr2installer
```

Alternatively, download the script directly:

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/hstr2installer -o hstr2installer
chmod +x hstr2installer
sudo ./hstr2installer
```

## Main Menu

1. `Install & Auto-Configure Hysteria 2`
2. `Issue SSL Certificate (Certbot Standalone)`
3. `Add User / Generate Client Config & QR Code`
4. `Manage Service (Start/Stop/Restart/Status)`
5. `Uninstall Hysteria 2`
6. `Exit`

## Presets

### Preset A — High Speed / Gaming

Creates a port 443 configuration with unlimited bandwidth and proxy masquerade. It is intended for high-throughput and low-latency scenarios. The authentication password is generated securely.

### Preset B — Stealth / Camouflage

Uses proxy masquerade with the following destination:

```text
https://www.bing.com/
```

`rewriteHost` is enabled to match the official Hysteria 2 proxy masquerade structure.

### Preset C — Custom / Advanced

Allows manual configuration of:

- Listening port
- Upload and download limits such as `100 mbps`
- Masquerade type: `proxy` or `string`
- Proxy URL or custom response content
- Authentication password

## TLS Certificate Flow

Ensure port 80 is reachable and not occupied by another service, then choose option 2. The script runs the required Certbot command:

```bash
certbot certonly --standalone -d "${dmn}" --non-interactive --agree-tos -m admin@"${dmn}"
```

The certificate paths are written to the server configuration:

```yaml
tls:
  cert: /etc/letsencrypt/live/${dmn}/fullchain.pem
  key: /etc/letsencrypt/live/${dmn}/privkey.pem
```

## Client and QR Generation

Choose option 3 and enter a client identifier and password. The generated URI follows the standard format:

```text
hy2://${client_pass}@${dmn}:443/?insecure=0&sni=${dmn}#${client_name}
```

Generated files are stored at:

```text
/etc/hysteria/clients/${client_name}.uri
/etc/hysteria/clients/${client_name}.txt
```

The URI is also printed in the terminal with a QR code using `qrencode -t ansiutf8`.

## Service Management

```bash
systemctl status hysteria.service
systemctl restart hysteria.service
journalctl -u hysteria.service -f
```

The service unit is located at:

```text
/etc/systemd/system/hysteria.service
```

## Important Paths

| Item | Path |
|---|---|
| Binary | `/usr/local/bin/hysteria` |
| Configuration | `/etc/hysteria/config.yaml` |
| Stored domain | `/etc/hysteria/domain` |
| Authentication secret | `/etc/hysteria/auth.secret` |
| Client files | `/etc/hysteria/clients/` |
| systemd unit | `/etc/systemd/system/hysteria.service` |
| Configuration backups | `/etc/hysteria/config.yaml.bak.*` |

## Security and Maintenance

- Configuration and sensitive files are stored with restricted permissions.
- Do not share authentication passwords or client URIs publicly.
- A timestamped backup is created before configuration changes.
- The generated configuration is checked with the official Hysteria binary before service restart.
- Keep certificate renewal available through `certbot renew`.
- Port 80 must be available while using Certbot Standalone.

## Uninstallation

Choose `Uninstall Hysteria 2` from the menu. The command removes the binary, service, configuration, and client files, and asks whether Let's Encrypt certificates should also be removed.

## Official References

- [Hysteria 2 Documentation](https://v2.hysteria.network)
- [Server Configuration](https://v2.hysteria.network/docs/config/server/)
- [Full Server Configuration](https://v2.hysteria.network/docs/advanced/Full-Server-Config/)
- [Official GitHub Releases](https://github.com/apernet/hysteria/releases)

## License

This project is distributed under the license provided in `LICENSE`.
