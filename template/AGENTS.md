# AGENTS.md

Canonical operating guide for any agent working on this project. Read this first. Every other agent-facing file (`CLAUDE.md`, `.codex/AGENTS.md`, `.opencode/AGENTS.md`, `.kilocode/rules.md`, `.cursor/rules/agents.mdc`) redirects here. There is no other contract.

This file is agent-editable. Material changes should be logged in `CHANGELOG.md` like any other change.

---

## 1. Who you are

You are an agent (Claude, Codex, Cursor, KiloCode, OpenCode, DeepSeek, Kimi, or otherwise) operating on **__PROJECT_NAME__**, a project scaffolded from Mantle. Mantle gives the project a thin harness; the actual work lives in code, in the repo docs, and in `skills/`.

Two stable principles:

- **Fat skills, thin harness.** This file describes *posture*. Procedures live in `skills/`. Don't bloat the harness.
- **Repo-first lookup.** Repo docs beat agent memory. Always.

---

## 2. Repo-first lookup

Before answering any question about the project, load, in order:

1. `README.md` — current synthesized state (architecture, overview).
2. Recent entries in `CHANGELOG.md` — what changed lately.
3. `DECISIONS.md` — *why* things are the way they are; check here before reversing a decision.

Agent memory is useful for orientation. The repo docs are the source of truth.

---

## 3. Repo docs

Four flat files carry project knowledge.

- **`README.md`** — Synthesized current state: overview, architecture, glossary. Rewritten freely as the project evolves.
- **`CHANGELOG.md`** — Append-only dated log of what changed. Newest at top. Older entries are never edited or deleted. (See §4.)
- **`DECISIONS.md`** — Append-only, ADR-style record of *why*. Each decision is numbered (`ADR-NNNN`) and immutable once **Accepted**: to change a decision, append a new entry and flip the old one's status to `Superseded by ADR-NNNN`. Open questions live here as `Status: Proposed` entries — a pending decision, resolved by flipping status, not by deletion.
- **`FUTURE.md`** — Forward-looking ideas, guarded by admission rules. Not a commitment list.

**Rules:**

1. `CHANGELOG.md` and `DECISIONS.md` are append-only. Never edit or delete older entries.
2. `README.md` may be rewritten freely when the architecture or product truth changes.
3. Unresolved ambiguity -> a `Proposed` entry in `DECISIONS.md`. Don't guess.
4. Multi-scope projects use `##`-level scope headings inside `CHANGELOG.md` / `DECISIONS.md`, not separate folders.

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

Stack-specific conventions may be appended below by the selected Mantle variant.

---

## 7. Verification

For this generated project, "done" means:

- Run the checks that match the project stack before claiming behavioral changes done.
- Material changes are reflected in `CHANGELOG.md`.
- If a stack-specific convention block is appended below, follow its verification rule.

---

## 8. What agents must NOT do

- Edit or delete older `CHANGELOG.md` entries.
- Edit or delete an **Accepted** `DECISIONS.md` entry — supersede it with a new ADR instead.
- Resolve a `Proposed` decision unilaterally when the resolution is a judgment call — flag and ask.
- Skip the changelog after a major change.
