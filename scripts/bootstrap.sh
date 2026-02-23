#!/usr/bin/env bash
set -euo pipefail

# OpenClaw KB Skills bootstrap
# Creates the required folder structure INSIDE your Obsidian Vault and (optionally)
# copies rules/templates there for long-term reference.
#
# Usage:
#   ./scripts/bootstrap.sh \
#     --vault "/path/to/Your Obsidian Vault" \
#     [--force]
#
# Notes:
# - We ONLY ask for the Vault root path. All internal paths are relative to it.
# - Default target inside vault: "KB/" (folders: inputs notes queue rules reviews)

VAULT=""
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --vault)
      VAULT="${2:-}"; shift 2 ;;
    --force)
      FORCE=1; shift ;;
    -h|--help)
      sed -n '1,120p' "$0"; exit 0 ;;
    *)
      echo "Unknown arg: $1" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$VAULT" ]]; then
  echo "ERROR: --vault is required (Obsidian Vault root path)" >&2
  exit 1
fi

if [[ ! -d "$VAULT" ]]; then
  echo "ERROR: vault path does not exist: $VAULT" >&2
  exit 1
fi

TARGET="$VAULT/KB"

mkdir -p "$TARGET/inputs" "$TARGET/notes" "$TARGET/queue" "$TARGET/rules" "$TARGET/reviews"

echo "[bootstrap] Created/verified folders under: $TARGET"

# Copy rules/templates into the vault for reference (safe overwrite only with --force)
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

copy_dir() {
  local src="$1" dst="$2"
  mkdir -p "$dst"
  if [[ $FORCE -eq 1 ]]; then
    rsync -a "$src/" "$dst/"
  else
    # don't overwrite existing files by default
    rsync -a --ignore-existing "$src/" "$dst/"
  fi
}

copy_dir "$SRC_DIR/KB/rules" "$TARGET/rules"
copy_dir "$SRC_DIR/KB/templates" "$TARGET/_templates_openclaw"  # keep separate to avoid clobbering user templates

echo "[bootstrap] Copied rules to: $TARGET/rules"
echo "[bootstrap] Copied templates to: $TARGET/_templates_openclaw"

cat <<EOF

Next steps:
1) Copy skills into your OpenClaw workspace:
   - this repo's skills/*  -> ~/.openclaw/workspace/skills/
   - this repo's KB/*      -> ~/.openclaw/workspace/KB/
2) Configure your own Vault path in your local setup (each person differs).
3) Run a test: feed a URL to kb-orchestrator (or kb-inbox-digest).

EOF
