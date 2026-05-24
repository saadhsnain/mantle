#!/usr/bin/env bash
# Mantle Claude convenience hook.
#
# This is a reminder, not enforcement. The canonical changelog guarantee
# lives in AGENTS.md + scripts/log-change.sh. Any agent (Claude or otherwise)
# is responsible for bumping CHANGELOG.md after major changes.
#
# This hook fires on Claude Code's Stop event and just prints a nudge if
# significant files appear to have changed since the last commit.

set -euo pipefail

# Only run inside a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  exit 0
fi

# Check whether anything outside ignored / brain-runtime paths changed
changed=$(git status --porcelain 2>/dev/null \
  | awk '{print $2}' \
  | grep -vE '^(brain/raw/|brain/out/|runs/|out/|raw/|\.env|node_modules/)' \
  || true)

if [ -z "$changed" ]; then
  exit 0
fi

# Skip if CHANGELOG.md was already touched
if echo "$changed" | grep -q '^CHANGELOG\.md$'; then
  exit 0
fi

cat <<'EOF' >&2

──────────────────────────────────────────────
 Mantle reminder: log this change.
   scripts/log-change.sh --topic "<topic>" --added "<bullet>"
 Or append manually to CHANGELOG.md.
 (See AGENTS.md §4 for what counts as "major".)
──────────────────────────────────────────────
EOF

exit 0
