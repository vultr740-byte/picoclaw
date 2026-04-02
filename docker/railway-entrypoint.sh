#!/bin/sh
set -eu

: "${PICOCLAW_HOME:=/data}"
: "${PICOCLAW_GATEWAY_HOST:=0.0.0.0}"
: "${PICOCLAW_GATEWAY_PORT:=8080}"
: "${PICOCLAW_GATEWAY_ALLOW_EMPTY:=true}"

config_path="${PICOCLAW_CONFIG:-$PICOCLAW_HOME/config.json}"
workspace_path="$PICOCLAW_HOME/workspace"

mkdir -p "$PICOCLAW_HOME"

# Only initialize an empty home directory. If a config file already exists on
# the mounted volume, skip onboarding to avoid an interactive overwrite prompt.
if [ ! -d "$workspace_path" ] && [ ! -f "$config_path" ]; then
    picoclaw onboard
    echo ""
    echo "First-run setup complete."
    echo "Add your provider and channel config under $PICOCLAW_HOME, then redeploy or restart the service."
fi

set -- gateway
if [ "$PICOCLAW_GATEWAY_ALLOW_EMPTY" = "true" ]; then
    set -- "$@" --allow-empty
fi

exec picoclaw "$@"
