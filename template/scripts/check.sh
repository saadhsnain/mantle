#!/usr/bin/env bash
# check.sh — baseline hygiene checks for a Mantle-generated project.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== shell syntax =="
bash -n scripts/log-change.sh
bash -n scripts/check.sh

echo "== config =="
if command -v jq >/dev/null 2>&1; then
  jq . .mcp.json >/dev/null
else
  echo "jq not found; skipping .mcp.json validation."
fi

echo "== source hygiene =="
if find . -path ./.git -prune -o -name .DS_Store -print | grep -q .; then
  find . -path ./.git -prune -o -name .DS_Store -print
  echo "Error: .DS_Store files must not be committed." >&2
  exit 1
fi

echo "Base Mantle checks passed. Run stack-specific checks from README.md or AGENTS.md next."
