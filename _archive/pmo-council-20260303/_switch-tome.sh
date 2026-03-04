#!/usr/bin/env bash
# switch-tome.sh — Council Switcher
# Swaps the active persona tome by updating top-level symlinks + mandala.md
set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
TOMES_DIR="$SKILLS_DIR/_tomes"

PERSONAS=(oracle forge reaper scribe worf sushi jin anubis boots)

usage() {
  cat <<'EOF'
Usage: ./switch-tome.sh <tome-name> [--force]
       ./switch-tome.sh --list

Commands:
  <tome-name>          Switch to the specified tome
  --list               List available tomes

Options:
  --force              Skip confirmation prompt

Examples:
  ./switch-tome.sh tng          # Preview swap to TNG, ask for confirmation
  ./switch-tome.sh pmo --force  # Swap back to PMO without confirmation
  ./switch-tome.sh --list       # List available tomes
EOF
  exit 1
}

list_tomes() {
  echo "Available tomes:"
  for dir in "$TOMES_DIR"/*/; do
    [ -d "$dir" ] || continue
    local name
    name="$(basename "$dir")"
    local yml="$dir/tome.yml"
    if [ -f "$yml" ]; then
      local display
      display="$(grep '^name:' "$yml" | sed 's/^name: *"*//;s/"*$//')"
      # Check if currently active
      local active=""
      if [ -L "$SKILLS_DIR/oracle" ]; then
        local target
        target="$(readlink "$SKILLS_DIR/oracle")"
        if [ "$target" = "_tomes/$name/oracle" ]; then
          active=" (active)"
        fi
      fi
      echo "  $name — $display$active"
    else
      echo "  $name — (missing tome.yml)"
    fi
  done
}

# --- Arg parsing ---
[ $# -lt 1 ] && usage

if [ "$1" = "--list" ]; then
  list_tomes
  exit 0
fi

TOME_NAME="$1"
FORCE=false
[ "${2:-}" = "--force" ] && FORCE=true

TOME_DIR="$TOMES_DIR/$TOME_NAME"

# --- Validation ---
if [ ! -d "$TOME_DIR" ]; then
  echo "Error: Tome '$TOME_NAME' not found in _tomes/" >&2
  echo "Run ./switch-tome.sh --list to see available tomes." >&2
  exit 1
fi

TOME_YML="$TOME_DIR/tome.yml"
if [ ! -f "$TOME_YML" ]; then
  echo "Error: $TOME_YML not found." >&2
  exit 1
fi

TOME_MANDALA="$TOME_DIR/mandala.md"
if [ ! -f "$TOME_MANDALA" ]; then
  echo "Error: $TOME_MANDALA not found. Each tome must include a mandala.md." >&2
  exit 1
fi

# Read persona dirs from tome.yml (grep for "dir:" lines)
TOME_PERSONAS=()
while IFS= read -r line; do
  dir="$(echo "$line" | sed 's/.*dir: *//')"
  TOME_PERSONAS+=("$dir")
done < <(grep '  - dir:' "$TOME_YML")

if [ ${#TOME_PERSONAS[@]} -eq 0 ]; then
  echo "Error: No personas found in $TOME_YML" >&2
  exit 1
fi

# Safety: check that all top-level persona paths are symlinks (not real dirs)
for p in "${PERSONAS[@]}"; do
  if [ -d "$SKILLS_DIR/$p" ] && [ ! -L "$SKILLS_DIR/$p" ]; then
    echo "Error: '$p' is a real directory, not a symlink." >&2
    echo "The tome migration must be completed before using the switcher." >&2
    echo "Expected symlinks at top level, found real directories." >&2
    exit 1
  fi
done

# Check if already on this tome
ALREADY_ACTIVE=false
if [ -L "$SKILLS_DIR/oracle" ]; then
  current_target="$(readlink "$SKILLS_DIR/oracle")"
  if [ "$current_target" = "_tomes/$TOME_NAME/oracle" ]; then
    ALREADY_ACTIVE=true
  fi
fi

# Read display name
DISPLAY_NAME="$(grep '^name:' "$TOME_YML" | sed 's/^name: *"*//;s/"*$//')"

# --- Preview ---
echo "=== Council Switcher ==="
echo ""
if $ALREADY_ACTIVE; then
  echo "Tome '$TOME_NAME' ($DISPLAY_NAME) is already active."
  echo ""
fi
echo "Target tome: $TOME_NAME ($DISPLAY_NAME)"
echo "Personas to activate:"
for p in "${TOME_PERSONAS[@]}"; do
  local_slash="$(grep -A4 "dir: $p" "$TOME_YML" | grep 'slash:' | sed 's/.*slash: *//')"
  local_totem="$(grep -A4 "dir: $p" "$TOME_YML" | grep 'totem:' | sed 's/.*totem: *"*//;s/"*$//')"
  echo "  $local_totem $p → /$p (slash: $local_slash)"
done
echo ""
echo "Actions:"
echo "  1. Remove existing persona symlinks"
echo "  2. Create new symlinks → _tomes/$TOME_NAME/"
echo "  3. Copy $TOME_NAME mandala.md → top-level mandala.md"

if ! $FORCE; then
  echo ""
  read -rp "Proceed? [y/N] " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# --- Execute ---
echo ""
echo "Switching..."

# Remove existing symlinks
for p in "${PERSONAS[@]}"; do
  if [ -L "$SKILLS_DIR/$p" ]; then
    rm "$SKILLS_DIR/$p"
  fi
done

# Create new symlinks
for p in "${TOME_PERSONAS[@]}"; do
  ln -s "_tomes/$TOME_NAME/$p" "$SKILLS_DIR/$p"
done

# Copy mandala
cp "$TOME_MANDALA" "$SKILLS_DIR/mandala.md"

echo ""
echo "=== Swap Complete ==="
echo "Active tome: $TOME_NAME ($DISPLAY_NAME)"
echo "Personas: ${TOME_PERSONAS[*]}"
echo ""
echo "Slash commands available:"
for p in "${TOME_PERSONAS[@]}"; do
  local_slash="$(grep -A4 "dir: $p" "$TOME_YML" | grep 'slash:' | sed 's/.*slash: *//')"
  local_totem="$(grep -A4 "dir: $p" "$TOME_YML" | grep 'totem:' | sed 's/.*totem: *"*//;s/"*$//')"
  echo "  $local_totem $local_slash"
done
