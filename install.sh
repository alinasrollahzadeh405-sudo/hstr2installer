#!/usr/bin/env bash
# hstr2installer bootstrap installer.
# Usage: curl -fsSL https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/hstr2installer/main/install.sh | sudo bash

set -Eeuo pipefail
IFS=$'\n\t'

readonly OWNER="alinasrollahzadeh405-sudo"
readonly REPO="hstr2installer"
readonly INSTALL_PATH="${HSTR2_INSTALL_PATH:-/usr/local/sbin/hstr2installer}"
readonly VERSION="${HSTR2_VERSION:-latest}"
readonly RAW_BASE="https://raw.githubusercontent.com/${OWNER}/${REPO}"

fail() { printf '[install] ERROR: %s\n' "$*" >&2; exit 1; }
log() { printf '[install] %s\n' "$*"; }

[[ "${EUID}" -eq 0 ]] || fail "Run this installer as root (for example: curl ... | sudo bash)."
command -v curl >/dev/null 2>&1 || fail "curl is required."
command -v install >/dev/null 2>&1 || fail "install is required."

if [[ "${VERSION}" == "latest" ]]; then
  SCRIPT_URL="${RAW_BASE}/main/hstr2installer"
else
  SCRIPT_URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${VERSION}/hstr2installer"
fi

tmp_file="$(mktemp)"
cleanup() { rm -f "${tmp_file}"; }
trap cleanup EXIT

log "Downloading hstr2installer (${VERSION})..."
curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 \
  --output "${tmp_file}" "${SCRIPT_URL}"

head -n 1 "${tmp_file}" | grep -qx '#!/usr/bin/env bash' || fail "Downloaded file is not the expected Bash installer."
install -o root -g root -m 0755 "${tmp_file}" "${INSTALL_PATH}"
log "Installed ${INSTALL_PATH}"

if [[ "${HSTR2_NO_EXEC:-0}" != "1" ]]; then
  exec "${INSTALL_PATH}" "$@"
fi
