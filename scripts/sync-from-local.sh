#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$REPO_ROOT/nvim"
SRC_BASE="${XDG_CONFIG_HOME:-$HOME/.config}"
SRC="$SRC_BASE/nvim"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: $SRC does not exist" >&2
  exit 1
fi

# If your live config is already the repo (symlink install), there is nothing to do.
if [[ "$(realpath "$SRC")" == "$(realpath "$DEST")" ]]; then
  echo "Live config already points at repo. Nothing to sync."
  exit 0
fi

mkdir -p "$DEST"

echo "Syncing $SRC -> $DEST"
rsync -a --delete \
  --exclude '.git/' \
  --exclude 'plugged/' \
  --exclude 'lazy/' \
  --exclude '.netrwhist' \
  --exclude 'shada/' \
  --exclude 'swap/' \
  --exclude 'undo/' \
  "$SRC/" "$DEST/"

echo "Done. Review changes and commit/push."
