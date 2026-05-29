#!/usr/bin/env bash
# init.sh — create a clean project scaffold from the Mantle source repo.

set -euo pipefail

usage() {
  cat <<'EOF' >&2
Usage:
  scripts/init.sh --name "<project name>" [--slug "<slug>"] [--variant none|python|research|react-vite|nextjs] [--target "<path>"] [--no-git]

Examples:
  scripts/init.sh --name "monkeOS" --variant python
  scripts/init.sh --name "My App" --slug my-app --variant react-vite --target "../my-app"

Creates a clean downstream project from template/ plus an optional variants/<name>/ overlay.
EOF
  exit 2
}

NAME=""
SLUG=""
VARIANT="none"
TARGET=""
GIT_INIT=1

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)
      NAME="${2:-}"
      shift 2
      ;;
    --slug)
      SLUG="${2:-}"
      shift 2
      ;;
    --variant)
      VARIANT="${2:-}"
      shift 2
      ;;
    --target)
      TARGET="${2:-}"
      shift 2
      ;;
    --no-git)
      GIT_INIT=0
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "Unknown flag: $1" >&2
      usage
      ;;
  esac
done

prompt_if_empty() {
  local var_name="$1"
  local prompt="$2"
  local current="${!var_name}"
  if [[ -z "$current" ]]; then
    if [[ ! -t 0 ]]; then
      echo "Error: $var_name is required in non-interactive mode." >&2
      usage
    fi
    read -r -p "$prompt" current
    printf -v "$var_name" '%s' "$current"
  fi
}

slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'
}

package_slug() {
  local base
  base="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g; s/^_+//; s/_+$//')"
  if [[ -z "$base" ]]; then
    base="app"
  fi
  if [[ "$base" =~ ^[0-9] ]]; then
    base="app_${base}"
  fi
  printf '%s' "$base"
}

copy_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

copy_dir() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
}

replace_tokens() {
  python3 - "$TARGET" "$NAME" "$SLUG" "$PACKAGE" "$(date +%Y-%m-%d)" <<'PY'
from pathlib import Path
import sys

root = Path(sys.argv[1])
tokens = {
    "__PROJECT_NAME__": sys.argv[2],
    "__SLUG__": sys.argv[3],
    "__PACKAGE_NAME__": sys.argv[4],
    "__DATE__": sys.argv[5],
}

skip_dirs = {".git", ".venv", "node_modules", "__pycache__", ".pytest_cache", ".ruff_cache"}

for path in root.rglob("*"):
    if path.is_dir():
        continue
    if any(part in skip_dirs for part in path.parts):
        continue
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue
    new = text
    for old, value in tokens.items():
        new = new.replace(old, value)
    if new != text:
        path.write_text(new, encoding="utf-8")
PY
}

append_variant_guidance() {
  local append_file="$1"
  if [[ -f "$append_file" ]]; then
    {
      printf '\n---\n\n'
      sed '/^<!--/d' "$append_file"
    } >> "$TARGET/AGENTS.md"
  fi
}

apply_variant() {
  local variant_dir="$ROOT/variants/$VARIANT"
  if [[ "$VARIANT" == "none" ]]; then
    return
  fi
  if [[ ! -d "$variant_dir" ]]; then
    echo "Error: unknown variant '$VARIANT'." >&2
    usage
  fi

  case "$VARIANT" in
    python)
      copy_file "$variant_dir/pyproject.toml" "$TARGET/pyproject.toml"
      copy_dir "$variant_dir/src" "$TARGET/src"
      copy_dir "$variant_dir/tests" "$TARGET/tests"
      if [[ "$PACKAGE" != "app" ]]; then
        mv "$TARGET/src/app" "$TARGET/src/$PACKAGE"
      fi
      ;;
    research)
      copy_file "$variant_dir/SESSION-LOG.md" "$TARGET/SESSION-LOG.md"
      copy_file "$variant_dir/config.yaml" "$TARGET/config.yaml"
      mkdir -p "$TARGET/runs"
      ;;
    react-vite)
      copy_file "$variant_dir/package.json" "$TARGET/package.json"
      copy_file "$variant_dir/index.html" "$TARGET/index.html"
      copy_file "$variant_dir/vite.config.ts" "$TARGET/vite.config.ts"
      copy_file "$variant_dir/tsconfig.json" "$TARGET/tsconfig.json"
      copy_file "$variant_dir/tsconfig.app.json" "$TARGET/tsconfig.app.json"
      copy_file "$variant_dir/tsconfig.node.json" "$TARGET/tsconfig.node.json"
      copy_dir "$variant_dir/src" "$TARGET/src"
      ;;
    nextjs)
      copy_file "$variant_dir/package.json" "$TARGET/package.json"
      copy_file "$variant_dir/next.config.mjs" "$TARGET/next.config.mjs"
      copy_file "$variant_dir/postcss.config.mjs" "$TARGET/postcss.config.mjs"
      copy_file "$variant_dir/tsconfig.json" "$TARGET/tsconfig.json"
      copy_dir "$variant_dir/src" "$TARGET/src"
      ;;
  esac

  append_variant_guidance "$variant_dir/AGENTS_APPEND.md"
}

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$ROOT/template"

prompt_if_empty NAME "Project name: "

if [[ -z "$SLUG" ]]; then
  SLUG="$(slugify "$NAME")"
fi
if [[ -z "$SLUG" ]]; then
  echo "Error: project slug could not be derived." >&2
  exit 2
fi
PACKAGE="$(package_slug "$SLUG")"

if [[ -z "$TARGET" ]]; then
  TARGET="$(cd "$ROOT/.." && pwd)/$SLUG"
elif [[ "$TARGET" != /* ]]; then
  TARGET="$(cd "$PWD" && pwd)/$TARGET"
fi

case "$VARIANT" in
  none|python|research|react-vite|nextjs) ;;
  *)
    echo "Error: unknown variant '$VARIANT'." >&2
    usage
    ;;
esac

if [[ ! -d "$TEMPLATE" ]]; then
  echo "Error: template directory not found at $TEMPLATE" >&2
  exit 1
fi

if [[ -e "$TARGET" ]]; then
  if [[ -d "$TARGET" && -z "$(find "$TARGET" -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
    :
  else
    echo "Error: target already exists and is not empty: $TARGET" >&2
    exit 1
  fi
fi

mkdir -p "$TARGET"
cp -R "$TEMPLATE/." "$TARGET/"
apply_variant
replace_tokens
find "$TARGET" -name .DS_Store -delete

"$TARGET/scripts/log-change.sh" --topic "scaffold" --added "$NAME scaffolded from Mantle" >/dev/null

if [[ "$GIT_INIT" -eq 1 ]] && command -v git >/dev/null 2>&1; then
  git -C "$TARGET" init >/dev/null
  git -C "$TARGET" add .
  git -C "$TARGET" commit -m "scaffold from mantle" >/dev/null || true
fi

echo "Created $TARGET"
