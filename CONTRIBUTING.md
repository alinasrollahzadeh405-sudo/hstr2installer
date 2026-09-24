# Contributing

## Welcome

Thanks for your interest in contributing to this project. The goal is to provide a reliable, production-oriented way to install and manage Hysteria 2 on Linux servers.

## How to contribute

1. Fork the repository.
2. Create a descriptive feature branch.
3. Make your changes and keep the code readable.
4. Validate Bash syntax with `bash -n`.
5. If available, run `shellcheck` as well.
6. Open a Pull Request with a clear explanation of the changes.

## Development standards

- Bash scripts should begin with `set -Eeuo pipefail`.
- Use clear logging helpers (`log`, `warn`, `die`) for user-facing output.
- Handle root requirements and filesystem paths safely.
- Backup important configuration before making destructive changes.
- Keep the project simple and maintainable.

## Validation

Before sending a PR, at minimum run:

```bash
bash -n hstr2installer
bash -n install.sh
bash -n scripts/package-release.sh
```

If `shellcheck` is installed:

```bash
shellcheck .
```

## PR expectations

- Describe the purpose and scope of the change clearly.
- Keep changes aligned with the project’s release and deployment model.
- Highlight any security, configuration, or operational impact in the PR description.
- Keep the code readable and deterministic.

## Acknowledgement

Contributions help improve this project and make it more reliable for real-world VPS deployments.
