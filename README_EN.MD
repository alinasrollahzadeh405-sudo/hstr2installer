# hstr2installer

A production-oriented Hysteria 2 installer and management utility based on the official Hysteria 2 docs.

## Overview

This project automates the setup of a Hysteria 2 server on Linux hosts, including:

- dependency installation
- architecture detection
- official binary install
- config generation
- user/client generation
- Certbot TLS handling
- systemd service lifecycle control

## Requirements

- Linux with `apt`, `dnf`, `yum`, `apk`, `pacman`, or `zypper`
- root access
- valid domain name pointing to the server

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh | sudo bash
```

## Usage

```bash
sudo ./hstr2installer
```

## Support

See the documentation files in this repository for installation, security, contribution, and release notes.
