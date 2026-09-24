# hstr2installer

[![GitHub Repo](https://img.shields.io/badge/GitHub-hstr2installer-181717?logo=github)](https://github.com/alinasrollahzadeh405-sudo/hstr2installer)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnubash)](https://www.gnu.org/software/bash/)
[![Hysteria2](https://img.shields.io/badge/Hysteria-2-FF6B6B)](https://v2.hysteria.network)

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
  - Preset A — High Speed / Gaming
  - Preset B — Stealth / Camouflage
  - Preset C — Custom / Advanced
- Generates standard `hy2://` client links and QR codes
- Stores client output under `/etc/hysteria/clients`
- Creates configuration backups before changes
- Includes service management and uninstall flow

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh | sudo bash
```

## Manual usage

```bash
chmod +x hstr2installer
sudo ./hstr2installer
```

## Documentation

- [README_EN.MD](README_EN.MD)
- [CHANGELOG](CHANGELOG.md)
- [SECURITY](SECURITY.md)
- [CONTRIBUTING](CONTRIBUTING.md)
- [CODE_OF_CONDUCT](CODE_OF_CONDUCT.md)

## Official references

- [Hysteria 2 Documentation](https://v2.hysteria.network)
- [Server Configuration](https://v2.hysteria.network/docs/config/server/)
- [Full Server Config](https://v2.hysteria.network/docs/advanced/Full-Server-Config/)
- [Official Hysteria releases](https://github.com/apernet/hysteria/releases)

## License

This project is distributed under the GNU GPL v3 license. See [LICENSE](LICENSE).
