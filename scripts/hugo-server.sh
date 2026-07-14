#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PATH="/opt/homebrew/bin:$HOME/.nvm/versions/node/v22.12.0/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

cd "$ROOT_DIR"
exec hugo server --renderToMemory "$@"
