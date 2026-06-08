# Contributing

This is a starter template, not an application. The "contribution" surface is small.

## Local checks

Before committing changes to Mantle itself:

```bash
scripts/check.sh
```

## Standards

- **Markdown-first.** New convention? Document it in `AGENTS.md`. Don't add a config file unless it earns its place.
- **No new top-level files** without checking `FUTURE.md`'s admission rules. If it passes all seven, it belongs.
- **No daemons, no placeholders.** Mantle uses a small scaffold script; generated projects must be clean.
- **Variants stay shallow.** A variant is a bootable skeleton, not an app.
- **Update `MANIFEST.md`** when source layout or generated project shape changes.
- **Update `variants/README.md`** when adding, removing, or renaming variants.
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
4. Register it in `variants/README.md`, root `README.md`, and `MANIFEST.md`.
5. Minimal bootable skeleton only — no app logic, no opinions beyond stack defaults.
