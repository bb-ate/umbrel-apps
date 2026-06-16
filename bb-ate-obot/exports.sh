#!/usr/bin/env bash

# exports.sh — run by Umbrel before each start to export app-specific
# environment variables.  The bootstrap token is generated once on first
# install and persisted so it survives container restarts and updates.

OBOT_ENV_FILE="${EXPORTS_APP_DIR}/token.env"

# Generate the token once if it doesn't already exist.
if [[ ! -f "${OBOT_ENV_FILE}" ]]; then
    OBOT_BOOTSTRAP_TOKEN="$(openssl rand -hex 16)"
    echo "export APP_OBOT_MCP_GATEWAY_BOOTSTRAP_TOKEN='${OBOT_BOOTSTRAP_TOKEN}'" \
        > "${OBOT_ENV_FILE}"
fi

# Source the file to export the variable into the current shell so that
# Umbrel's docker-compose interpolation and the app-store UI can read it.
# shellcheck source=/dev/null
. "${OBOT_ENV_FILE}"
