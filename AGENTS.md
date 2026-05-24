# AGENTS.md

Canonical operating guide for any agent working on a Mantle project. Read this first. Every other agent-facing file (`CLAUDE.md`, `.codex/AGENTS.md`, `.opencode/AGENTS.md`, `.kilocode/rules.md`, `.cursor/rules/agents.mdc`) redirects here. There is no other contract.

This file is agent-editable. Material changes should be logged in `CHANGELOG.md` like any other change.

---

## 1. Who you are

You are an agent (Claude, Codex, Cursor, KiloCode, OpenCode, DeepSeek, Kimi, or otherwise) operating on **Mantle**, a small scaffold generator for agent-led projects.

Mantle's source layout:

- `scripts/init.sh` creates downstream projects.
- `template/` contains the base files copied into every generated project.
- `variants/` contains optional stack overlays.
- Root docs (`README.md`, `AGENTS.md`, `CHANGELOG.md`, `FUTURE.md`, `CONTRIBUTING.md`) describe Mantle itself.

Two stable principles:

- **Fat skills, thin harness.** This file describes *posture*. Procedures live in `skills/`. Don't bloat the harness.
- **Brain-first lookup.** Repo brain truth beats agent memory. Always.

---

## 2. Brain-first lookup

Before answering any question about a scope (the project itself, a sub-domain, a tenant, a feature area), load:

1. `brain/<scope>/compiled-truth.md` — current synthesized truth
2. Recent entries in `brain/<scope>/timeline.md`
3. `brain/<scope>/open-questions.md` if the question is ambiguous

If you don't know which scope applies, start with `brain/project/`. That's the default.

Agent memory is useful for orientation. The brain file is the source of truth.

---

## 3. Repo brain conventions

The brain is a folder of *scopes*. Each scope is one folder with four files.

```
brain/
└── project/         # Default scope, always present
    ├── compiled-truth.md
    ├── timeline.md
    ├── open-questions.md
    └── linked.md
```

**File roles:**

- **`compiled-truth.md`** — Synthesized current state. May be rewritten when grounded in Timeline evidence. Carries `last_reviewed: YYYY-MM-DD` in frontmatter; bump it on every meaningful rewrite. Cosmetic edits don't count.
- **`timeline.md`** — Append-only dated log. Format: `**YYYY-MM-DD** — observation. Source: <ref>`. Older entries must not be edited or deleted.
- **`open-questions.md`** — Append-only list of unresolved ambiguity. Resolved questions move into Compiled Truth or get closed with a Timeline entry.
- **`linked.md`** — Mirrors references from Timeline entries (URLs, file paths, related scopes).

**Rules:**

1. Timelines are append-only. Never edit or delete older entries.
2. Compiled Truth may be rewritten when Timeline evidence shows drift. Bump `last_reviewed`.
3. Unresolved ambiguity → `open-questions.md`. Don't guess.
4. New scopes are added by creating `brain/<new-scope>/` with the same four files as `brain/project/`.
5. If a write doesn't fit cleanly into one of the four files, it almost always belongs in Timeline.

---

## 4. Changelog discipline

After every major change — new feature, schema change, dependency swap, breaking refactor, removed surface — record it.

**Canonical path:**

```bash
scripts/log-change.sh --topic "auth rewrite" --added "magic-link login" --removed "password reset endpoint"
```

The script reuses today's block if the topic already exists; it dedupes exact bullets. Safe to call more than once.

**Manual path:** prepend a block to `CHANGELOG.md`:

```markdown
## YYYY-MM-DD — <topic>

### Added
- ...

### Changed
- ...

### Removed
- ...
```

Cosmetic edits (typos, formatting, whitespace) don't count. The point is that any agent picking up this repo later can read `CHANGELOG.md` and know where things stand.

---

## 5. Fat skills, thin harness

Procedures live in `skills/<name>/SKILL.md`. Each skill is self-contained: frontmatter (`name`, `description`, `when_to_use`), a numbered playbook, and a verification step.

This file (AGENTS.md) tells you *how to be*. Skills tell you *what to do*. Don't smuggle procedures into the harness.

When you find yourself writing the same multi-step procedure twice, extract it into a skill.

---

## 6. Stack defaults

If `~/.claude/CLAUDE.md` exists, inherit its stack rules (pnpm, `@/` alias, Tailwind v4 `@theme`, shadcn from `@/components/ui/`, no `any`, etc.). If it doesn't, apply sensible defaults and don't block on the missing global config.

Generated-project defaults live in `template/`. Variant-specific conventions live in each variant's README or `AGENTS_APPEND.md`.

---

## 7. Verification

"Done" depends on the variant. Each `variants/<name>/` ships with a README that defines what to run before claiming a task complete (typecheck, test, dev-server boot, etc.).

For projects without a variant: at minimum, the code should compile/run and the change should be reflected in CHANGELOG.md.

---

## 8. Creating projects from Mantle

When the user asks you to create a new project from Mantle, use the scaffold script:

```bash
scripts/init.sh --name "<project name>" --variant none|python|research|react-vite|nextjs
```

The generated project should contain the Mantle agent harness and the chosen stack starter, but not Mantle's own README, changelog history, `template/`, `variants/`, `scripts/init.sh`, or source-template-only instructions.

Mantle itself is the source generator. Downstream projects should be clean scaffolds, not raw Mantle clones.

---

## 9. What agents must NOT do

- Edit or delete older Timeline entries.
- Rewrite Compiled Truth without grounding in Timeline evidence.
- Resolve Open Questions unilaterally when the resolution is a judgment call — flag and ask.
- Bump `last_reviewed` for cosmetic edits.
- Add new top-level automation beyond `scripts/init.sh` without checking `FUTURE.md` admission rules.
- Skip the changelog after a major change.
