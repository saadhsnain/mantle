#!/usr/bin/env bash
# check.sh — repository hygiene checks for Mantle.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "== shell syntax =="
bash -n scripts/log-change.sh
bash -n scripts/init.sh
bash -n scripts/check.sh

echo "== config =="
jq . .mcp.json >/dev/null

echo "== template parity =="
cmp scripts/log-change.sh template/scripts/log-change.sh

echo "== source hygiene =="
if find . -path ./.git -prune -o -name .DS_Store -print | grep -q .; then
  find . -path ./.git -prune -o -name .DS_Store -print
  echo "Error: .DS_Store files must not be committed." >&2
  exit 1
fi

echo "== generated project smoke test =="
tmpdir="$(mktemp -d /tmp/mantle-check.XXXXXX)"
trap 'rm -rf "$tmpdir"' EXIT
scripts/init.sh --name "Smoke Test" --slug smoke-test --variant python --target "$tmpdir/smoke-test" --no-git >/dev/null
test ! -e "$tmpdir/smoke-test/scripts/init.sh"
test ! -e "$tmpdir/smoke-test/template"
test ! -e "$tmpdir/smoke-test/variants"
test -f "$tmpdir/smoke-test/scripts/log-change.sh"
test -f "$tmpdir/smoke-test/scripts/check.sh"
test -z "$(find "$tmpdir/smoke-test" -name .DS_Store -print)"

echo "== redirect files =="
test -f .codex/AGENTS.md && test ! -L .codex/AGENTS.md
test -f .opencode/AGENTS.md && test ! -L .opencode/AGENTS.md
test -f .kilocode/rules.md && test ! -L .kilocode/rules.md
test -f .cursor/rules/agents.mdc && test ! -L .cursor/rules/agents.mdc

echo "Mantle checks passed."
