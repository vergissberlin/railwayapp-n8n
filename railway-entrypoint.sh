#!/bin/sh
set -eu

readonly DATA_DIR="/home/node/.n8n"
port="${PORT:-5678}"

if ! [ "${port}" -ge 1 ] 2>/dev/null || ! [ "${port}" -le 65535 ] 2>/dev/null; then
	echo "railway-entrypoint: PORT='${port}' is not a valid port number (1-65535)" >&2
	exit 1
fi

# Fix ownership of the mounted volume before dropping to the unprivileged node user - Railway
# creates requiredMountPath owned by root on first boot, which node cannot write to.
mkdir -p "${DATA_DIR}"
chown -R node:node "${DATA_DIR}"

export N8N_PORT="${port}"

exec tini -- su-exec node /docker-entrypoint.sh "$@"
