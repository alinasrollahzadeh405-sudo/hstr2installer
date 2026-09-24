# Security Policy

## Reporting a vulnerability

If you discover a security issue or vulnerability in this project, please report it responsibly and privately.

Preferred channels:

- GitHub Security Advisories (if enabled for the repository)
- Private contact with the maintainers through official GitHub channels
- Initial disclosure without public details until a fix is available

## Important guidance

- Do not disclose sensitive issues publicly before a fix is prepared.
- If you are unsure whether something is a security issue, report it privately and let maintainers evaluate it.
- For production VPS deployments, always keep the latest version, validate authentication values, and confirm TLS and domain settings carefully.

## Supported versions

The project supports the latest maintained release published on GitHub Releases and the currently active branch. Older versions may not receive ongoing support.

## Best practices

- Never publish client passwords, URIs, or authentication secrets in public repositories.
- Validate domain names and certificate paths before enabling production traffic.
- Prefer official Hysteria 2 binaries from the upstream project.
- Keep the server updated and audit config changes before restart.
