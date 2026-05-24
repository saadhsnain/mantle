# FUTURE.md

Ideas worth keeping in mind, with a guard. Mantle stays small on purpose. Anything proposed for inclusion must pass the admission rules below.

## Admission rules

A proposal enters the template only if it satisfies **all** of these:

1. **Preserves agent-agnosticism.** Works whether the agent is Claude, Codex, Cursor, KiloCode, OpenCode, DeepSeek, Kimi, or unknown. No tool-specific lock-in.
2. **No orchestration creep.** Procedures belong in `skills/`. The harness (`AGENTS.md`) describes posture, not workflow.
3. **Boring beats clever.** Prefer Markdown and small shell scripts over daemons or build pipelines.
4. **Clean scaffold output.** Generated projects must not carry Mantle source-only files, stale variants, `template/`, `scripts/init.sh`, or placeholder tokens.
5. **Zero-secret default.** Anything that needs a key goes in `.env.example` as an optional snippet, not enabled by default.
6. **One responsibility per file.** No new file that exists "in case." If the file doesn't earn its place on first commit, it doesn't enter.
7. **Reversible.** Easy to delete from a downstream project without breaking anything.

If a proposal fails any rule, it lives here as an idea, not in the template.

---

## Candidates

- **Symlink-based redirects.** Fails rule 4 — symlinks break on copy across filesystems and on Windows.
- **Placeholder substitution (`{{PROJECT_NAME}}`).** Fails rule 4 — generated projects should receive concrete names at creation time.
- **Notion sync** (mirror brain Timeline to Notion). Tool-specific, fails rule 1 unless implemented as an optional skill.
- **CI workflows** (lint, typecheck on PR). Project-specific, not template-shaped — would live in variants if anywhere.
- **Telemetry / changelog summarizer agent.** Fails rule 2 — that's a skill, not harness.
- **Supabase / Apify MCP wired by default.** Fails rule 5 — needs project-specific config. Stays in `.env.example` as snippets.
- **More variants** (Astro, SvelteKit, Python CLI, Rust). Add only when you've used the pattern on three real projects.

---

Anyone — agent or human — may append to this file. Don't reorganize old entries; add new ones.
