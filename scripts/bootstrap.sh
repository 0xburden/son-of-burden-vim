#!/usr/bin/env bash
set -euo pipefail

# Clone this repo and install it into ~/.config/nvim
# Usage:
#   ./bootstrap.sh <git_url> [target_dir]

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <git_url> [target_dir]" >&2
  exit 1
fi

GIT_URL="$1"
TARGET_DIR="${2:-$HOME/code/son-of-burden-vim}"

mkdir -p "$(dirname "$TARGET_DIR")"

if [[ -d "$TARGET_DIR/.git" ]]; then
  echo "Repo already exists at $TARGET_DIR"
else
  git clone "$GIT_URL" "$TARGET_DIR"
fi

"$TARGET_DIR/scripts/install.sh"
