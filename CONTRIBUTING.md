# Contributing

This is a starter template, not an application. The "contribution" surface is small.

## Local checks

Before committing changes to Mantle itself:

```bash
# Shell script syntax
bash -n scripts/log-change.sh
bash -n scripts/init.sh

# MCP config validity
jq . .mcp.json > /dev/null

# Source/template hygiene
cmp scripts/log-change.sh template/scripts/log-change.sh
test -z "$(find . -name .DS_Store -print)"

# Generated project smoke test
tmpdir=$(mktemp -d /tmp/mantle-check.XXXXXX)
scripts/init.sh --name "Smoke Test" --slug smoke-test --variant python --target "$tmpdir/smoke-test" --no-git
test ! -e "$tmpdir/smoke-test/scripts/init.sh"
test ! -e "$tmpdir/smoke-test/template"
test ! -e "$tmpdir/smoke-test/variants"
test -z "$(find "$tmpdir/smoke-test" -name .DS_Store -print)"

# Redirect files are real text, not symlinks
test -f .codex/AGENTS.md && test ! -L .codex/AGENTS.md
test -f .opencode/AGENTS.md && test ! -L .opencode/AGENTS.md
test -f .kilocode/rules.md && test ! -L .kilocode/rules.md
test -f .cursor/rules/agents.mdc && test ! -L .cursor/rules/agents.mdc
```

## Standards

- **Markdown-first.** New convention? Document it in `AGENTS.md`. Don't add a config file unless it earns its place.
- **No new top-level files** without checking `FUTURE.md`'s admission rules. If it passes all seven, it belongs.
- **No daemons, no placeholders.** Mantle uses a small scaffold script; generated projects must be clean.
- **Variants stay shallow.** A variant is a bootable skeleton, not an app.
- **Bump `CHANGELOG.md`** for every material change via `scripts/log-change.sh`.

## Adding a skill

1. Create `skills/<your-skill>/SKILL.md`.
2. Add frontmatter (`name`, `description`, `when_to_use`).
3. Write a numbered playbook + a verification step.
4. Register it in `skills/README.md`.

## Adding a variant

1. New folder under `variants/<name>/`.
2. Include `README.md` listing exactly what to copy into the repo root.
3. Include `AGENTS_APPEND.md` if there's variant-specific agent guidance.
4. Minimal bootable skeleton only — no app logic, no opinions beyond stack defaults.
