#!/usr/bin/env bash
# log-change.sh — canonical changelog writer for Mantle projects.
#
# Behavior:
#   - Prepends a "## YYYY-MM-DD — <topic>" block to CHANGELOG.md.
#   - If a block with the same date AND same topic already exists, reuses it:
#     new bullets are appended under the appropriate ### Added / Changed / Removed
#     subsection (subsections are created on demand).
#   - Exact duplicate bullets (same text under the same subsection) are silently dropped.
#   - Exits non-zero on bad input.
#
# Usage:
#   scripts/log-change.sh --topic "auth rewrite" \
#       --added "magic-link login" \
#       --changed "session cookie now httpOnly" \
#       --removed "password reset endpoint"
#
# Flags may be repeated. At least one of --added/--changed/--removed is required.

set -euo pipefail

usage() {
  cat <<'EOF' >&2
Usage:
  scripts/log-change.sh --topic "<topic>" [--added "<bullet>"] [--changed "<bullet>"] [--removed "<bullet>"]

  --topic     Required. The block heading after the date.
  --added     Append a bullet under "### Added". Repeatable.
  --changed   Append a bullet under "### Changed". Repeatable.
  --removed   Append a bullet under "### Removed". Repeatable.

At least one of --added/--changed/--removed is required.
EOF
  exit 2
}

TOPIC=""
ADDED=()
CHANGED=()
REMOVED=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --topic)   TOPIC="${2:-}"; shift 2 ;;
    --added)   ADDED+=("${2:-}"); shift 2 ;;
    --changed) CHANGED+=("${2:-}"); shift 2 ;;
    --removed) REMOVED+=("${2:-}"); shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown flag: $1" >&2; usage ;;
  esac
done

if [[ -z "$TOPIC" ]]; then
  echo "Error: --topic is required." >&2
  usage
fi

if [[ ${#ADDED[@]} -eq 0 && ${#CHANGED[@]} -eq 0 && ${#REMOVED[@]} -eq 0 ]]; then
  echo "Error: provide at least one of --added/--changed/--removed." >&2
  usage
fi

# Locate repo root (works whether invoked from root or scripts/)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHANGELOG="$ROOT/CHANGELOG.md"

if [[ ! -f "$CHANGELOG" ]]; then
  echo "Error: CHANGELOG.md not found at $CHANGELOG" >&2
  exit 1
fi

DATE="$(date +%Y-%m-%d)"
HEADING="## ${DATE} — ${TOPIC}"

python3 - "$CHANGELOG" "$HEADING" \
  "$(printf '%s\n' "${ADDED[@]+"${ADDED[@]}"}")" \
  "$(printf '%s\n' "${CHANGED[@]+"${CHANGED[@]}"}")" \
  "$(printf '%s\n' "${REMOVED[@]+"${REMOVED[@]}"}")" <<'PY'
import sys, re, os

path, heading, added_raw, changed_raw, removed_raw = sys.argv[1:6]

def split_bullets(raw):
    return [line for line in raw.split("\n") if line.strip()]

added = split_bullets(added_raw)
changed = split_bullets(changed_raw)
removed = split_bullets(removed_raw)

with open(path, "r", encoding="utf-8") as f:
    text = f.read()

lines = text.split("\n")

def in_code_block_flags(lines):
    """Return a list of booleans, True where the line is inside a ``` fence."""
    flags = []
    inside = False
    for ln in lines:
        stripped = ln.lstrip()
        if stripped.startswith("```"):
            # Toggle on the fence line itself (the fence line is not "content")
            flags.append(True)
            inside = not inside
        else:
            flags.append(inside)
    return flags

in_code = in_code_block_flags(lines)

# Find an existing block with the exact heading (ignore matches inside code fences).
block_start = None
for i, line in enumerate(lines):
    if in_code[i]:
        continue
    if line.strip() == heading.strip():
        block_start = i
        break

def find_block_end(lines, start, in_code):
    # Block ends at the next real (non-fenced) "## " heading or EOF.
    for j in range(start + 1, len(lines)):
        if in_code[j]:
            continue
        if lines[j].startswith("## "):
            return j
    return len(lines)

def merge_section(block_lines, section, new_bullets):
    """Insert/append bullets under ### section inside block_lines (list of lines).
    Returns new list. Dedupes exact bullet text."""
    if not new_bullets:
        return block_lines

    section_header = f"### {section}"
    # Locate section inside block
    sec_idx = None
    for i, ln in enumerate(block_lines):
        if ln.strip() == section_header:
            sec_idx = i
            break

    if sec_idx is None:
        # Append section at end of block (with blank line separator)
        out = list(block_lines)
        # Trim trailing blanks
        while out and out[-1].strip() == "":
            out.pop()
        out.append("")
        out.append(section_header)
        for b in new_bullets:
            out.append(f"- {b}")
        out.append("")
        return out

    # Section exists: find its end (next ### or end of block)
    sec_end = len(block_lines)
    for j in range(sec_idx + 1, len(block_lines)):
        if block_lines[j].startswith("### ") or block_lines[j].startswith("## "):
            sec_end = j
            break

    existing_bullets = set()
    bullet_re = re.compile(r"^\s*-\s+(.*)$")
    for j in range(sec_idx + 1, sec_end):
        m = bullet_re.match(block_lines[j])
        if m:
            existing_bullets.add(m.group(1).strip())

    # Find insertion point: last bullet line in section, or right after header.
    insert_at = sec_idx + 1
    for j in range(sec_idx + 1, sec_end):
        if bullet_re.match(block_lines[j]):
            insert_at = j + 1

    to_insert = []
    for b in new_bullets:
        if b.strip() not in existing_bullets:
            to_insert.append(f"- {b}")
            existing_bullets.add(b.strip())

    return block_lines[:insert_at] + to_insert + block_lines[insert_at:]


if block_start is not None:
    block_end = find_block_end(lines, block_start, in_code)
    block = lines[block_start:block_end]
    block = merge_section(block, "Added", added)
    block = merge_section(block, "Changed", changed)
    block = merge_section(block, "Removed", removed)
    new_lines = lines[:block_start] + block + lines[block_end:]
else:
    # Prepend a new block above the topmost "## " heading.
    new_block = [heading, ""]
    if added:
        new_block.append("### Added")
        new_block.extend(f"- {b}" for b in added)
        new_block.append("")
    if changed:
        new_block.append("### Changed")
        new_block.extend(f"- {b}" for b in changed)
        new_block.append("")
    if removed:
        new_block.append("### Removed")
        new_block.extend(f"- {b}" for b in removed)
        new_block.append("")

    # Find first real (non-fenced) "## " heading
    insert_at = None
    for i, ln in enumerate(lines):
        if in_code[i]:
            continue
        if ln.startswith("## "):
            insert_at = i
            break

    if insert_at is None:
        # Append at end with separator
        if lines and lines[-1].strip() != "":
            lines.append("")
        new_lines = lines + new_block
    else:
        # Insert just before, with one blank line before it
        before = lines[:insert_at]
        # Trim trailing blanks
        while before and before[-1].strip() == "":
            before.pop()
        before.append("")
        new_lines = before + new_block + lines[insert_at:]

# Normalize: collapse 3+ consecutive blank lines into one
final = []
blank_run = 0
for ln in new_lines:
    if ln.strip() == "":
        blank_run += 1
        if blank_run <= 1:
            final.append(ln)
    else:
        blank_run = 0
        final.append(ln)

# Ensure trailing newline
out_text = "\n".join(final)
if not out_text.endswith("\n"):
    out_text += "\n"

with open(path, "w", encoding="utf-8") as f:
    f.write(out_text)

print(f"Updated {os.path.relpath(path)}: {heading}")
PY
