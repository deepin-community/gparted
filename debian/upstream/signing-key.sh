#!/usr/bin/env bash
set -euo pipefail

KEYS=(
    0xBB09FFB87563FA2E1A22146817A6D3FF338C9570 # Curtis Gedak <gedakc@gmail.com>
)

if [ $# -gt 0 ]; then
	exec gpg "$@" "${KEYS[@]}"
else
	exec gpg --export --export-options export-minimal -a --yes \
		-o "$(dirname "$0")/signing-key.asc" "${KEYS[@]}"
fi
