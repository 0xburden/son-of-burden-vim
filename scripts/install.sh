#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/nvim"
DEST_BASE="${XDG_CONFIG_HOME:-$HOME/.config}"
DEST="$DEST_BASE/nvim"

if [[ ! -d "$SRC" ]]; then
  echo "ERROR: expected $SRC to exist" >&2
  exit 1
fi

mkdir -p "$DEST_BASE"

# Backup any existing config that isn't already the desired symlink
if [[ -e "$DEST" ]]; then
  if [[ -L "$DEST" && "$(readlink "$DEST")" == "$SRC" ]]; then
    echo "Already installed: $DEST -> $SRC"
  else
    backup="$DEST.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing $DEST to $backup"
    mv "$DEST" "$backup"
  fi
fi

# Install by symlink (makes updating this repo update your live config)
if [[ ! -e "$DEST" ]]; then
  ln -s "$SRC" "$DEST"
  echo "Installed: $DEST -> $SRC"
fi

echo

echo "Next steps:"
echo "  - Start nvim and run :Lazy sync (or let it auto-install)"

if command -v nvim >/dev/null 2>&1; then
  echo
  echo "Running a headless plugin sync (Lazy)..."
  nvim --headless "+Lazy! sync" +qa || true
fi

cat <<'EOF'

Optional:
  - Install LSP servers: :Mason
  - Install treesitter parsers: :TSInstall <lang>

EOF
