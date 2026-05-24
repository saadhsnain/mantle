# Mantle

A small, durable scaffold generator for agent-led projects.

## Philosophy

- **Agent-agnostic.** `AGENTS.md` is the canonical spec. Claude, Codex, Cursor, KiloCode, OpenCode, DeepSeek, Kimi — all read the same file. Per-tool entry points (`CLAUDE.md`, `.codex/AGENTS.md`, etc.) are tiny redirects.
- **Fat skills, thin harness.** Posture in `AGENTS.md`; procedures in `skills/`. No orchestration creep.
- **Brain-first.** Project knowledge lives in `brain/` as `compiled-truth.md` + append-only `timeline.md`. Repo truth beats agent memory.
- **Boring beats clever.** Markdown and small shell scripts. No placeholders, no symlinks.

## How to use

```bash
cd mantle
scripts/init.sh --name "My Project" --slug my-project --variant python
```

This creates `../my-project` as a clean downstream project: no Mantle README, no Mantle changelog history, no `variants/` directory, no `scripts/init.sh`, and no source-template-only instructions.

Supported variants:

```bash
scripts/init.sh --name "Research Bot" --variant research
scripts/init.sh --name "Python Tool" --variant python
scripts/init.sh --name "Vite App" --variant react-vite
scripts/init.sh --name "Next App" --variant nextjs
scripts/init.sh --name "Plain Project" --variant none
```

## What's in the box

| Path | Purpose |
|---|---|
| `scripts/init.sh` | Creates clean downstream projects from `template/` plus a variant overlay. |
| `template/` | Base files copied into every generated project. |
| `variants/` | Optional shallow overlays: `research`, `python`, `react-vite`, `nextjs`. |
| `scripts/log-change.sh` | Changelog writer used by Mantle itself and copied into generated projects. |
| `AGENTS.md`, `CHANGELOG.md`, `FUTURE.md`, `CONTRIBUTING.md` | Mantle's own project docs. Generated projects receive their own versions from `template/`. |

## Variants

Each `variants/<name>/` is a shallow overlay consumed by `scripts/init.sh`. Pick one or none.

- **`research/`** — for scrapers, data pipelines, investigative projects. Ships `session-log.md`, `config.yaml`, `runs/` pattern.
- **`python/`** — minimal Python package skeleton with `pyproject.toml`, `src/`, and `tests/`.
- **`react-vite/`** — minimal Vite + shadcn + Tailwind v4 skeleton.
- **`nextjs/`** — minimal App Router skeleton.

## Optional MCP servers

`.mcp.json` ships with Context7 and Exa only (no secrets needed). To enable Supabase, Apify, or others, see `.env.example` for copy-paste snippets.

## Changelog

Any agent (or you) should bump `CHANGELOG.md` after major changes:

```bash
scripts/log-change.sh --topic "auth rewrite" --added "magic-link login" --removed "password reset"
```

Same-day same-topic calls reuse the existing block. Exact duplicate bullets are deduped.

## Manual Variant Use

You can still copy a variant by hand for an existing project. Each `variants/<name>/README.md` lists the exact files to copy.

## Generated Output

A generated project includes:

- agent entrypoints (`AGENTS.md`, `CLAUDE.md`, `.codex/`, `.cursor/`, `.kilocode/`, `.opencode/`)
- repo brain (`brain/project/`)
- changelog and future-work guard (`CHANGELOG.md`, `FUTURE.md`)
- shared changelog script (`scripts/log-change.sh`)
- selected stack files from `variants/<name>/`

It does not include Mantle's source README, Mantle's changelog history, `template/`, `variants/`, or `scripts/init.sh`.

## When to skip Mantle

If you're shipping a one-file script or a throwaway prototype, this is overkill. Mantle pays off when an agent will pick the project back up days or weeks later and needs to orient itself fast.
