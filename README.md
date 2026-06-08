# Mantle

Mantle is a small scaffold generator for agent-led projects. It gives new repos a durable operating harness: one canonical agent guide, flat project docs, a changelog writer, a skill registry, and optional stack overlays.

Mantle is not an application framework. It is a repo-shape generator.

## Principles

- **Agent-agnostic.** `AGENTS.md` is canonical. Claude, Codex, Cursor, KiloCode, OpenCode, DeepSeek, Kimi, and unknown future agents all read the same contract.
- **Repo-first.** Current truth lives in `README.md`; material history lives in `CHANGELOG.md`; rationale lives in `DECISIONS.md`.
- **Fat skills, thin harness.** `AGENTS.md` describes posture. Repeatable procedures live in `skills/`.
- **Clean generated output.** Downstream projects receive a focused scaffold, not Mantle's source tree.
- **Boring beats clever.** Markdown and small shell scripts. No symlinks, daemons, or placeholder-heavy orchestration.

## Quick Start

```bash
cd /Users/saad/code/mantle
scripts/init.sh --name "My Project" --slug my-project --variant python
```

This creates `../my-project` as a clean downstream project.

Supported variants:

```bash
scripts/init.sh --name "Plain Project" --variant none
scripts/init.sh --name "Python Tool" --variant python
scripts/init.sh --name "Research Bot" --variant research
scripts/init.sh --name "Vite App" --variant react-vite
scripts/init.sh --name "Next App" --variant nextjs
```

Useful flags:

```bash
scripts/init.sh --name "My App" --slug my-app --target "../my-app" --variant react-vite
scripts/init.sh --name "Scratch" --variant none --target "/tmp/scratch" --no-git
```

## Source Layout

| Path | Purpose |
|---|---|
| `scripts/init.sh` | Creates downstream projects from `template/` plus a selected variant. |
| `scripts/log-change.sh` | Writes material changes to `CHANGELOG.md`; also copied into generated projects. |
| `scripts/check.sh` | Runs Mantle source hygiene and generated-project smoke checks. |
| `template/` | Base files copied into every generated project. |
| `variants/` | Optional stack overlays. See `variants/README.md`. |
| `MANIFEST.md` | Source-tree and generated-output map. |
| `AGENTS.md` | Canonical agent contract for Mantle itself. |
| `CHANGELOG.md` | Append-only material history. |
| `DECISIONS.md` | Append-only ADR log. |
| `FUTURE.md` | Admission rules and deferred ideas. |

## Generated Project Shape

A generated project includes:

- agent entrypoints: `AGENTS.md`, `CLAUDE.md`, `.codex/`, `.cursor/`, `.kilocode/`, `.opencode/`
- repo docs: `README.md`, `CHANGELOG.md`, `DECISIONS.md`, `FUTURE.md`, `CONTRIBUTING.md`
- maintenance scripts: `scripts/log-change.sh`, `scripts/check.sh`
- `skills/README.md`
- optional stack files from exactly one variant

A generated project does not include Mantle's own README, Mantle changelog history, `template/`, `variants/`, or `scripts/init.sh`.

## Variants

| Variant | Purpose |
|---|---|
| `none` | Plain project harness with no stack starter. |
| `python` | Minimal Python package skeleton with `pyproject.toml`, `src/`, and `tests/`. |
| `research` | Research, scraping, and pipeline projects with `SESSION-LOG.md`, `config.yaml`, and `runs/`. |
| `react-vite` | React + Vite + TypeScript + Tailwind v4 starter. |
| `nextjs` | Next.js App Router + TypeScript + Tailwind v4 starter. |

Each `variants/<name>/README.md` documents its copied files and verification rule.

## Maintenance Workflow

Before claiming Mantle source changes done:

```bash
scripts/check.sh
```

After material changes:

```bash
scripts/log-change.sh --topic "maintenance scaffold" --added "scripts/check.sh verifies source hygiene"
```

For decisions, prepend a new ADR in `DECISIONS.md`. Do not edit accepted ADRs except to mark them superseded by a newer ADR.

## Optional MCP Servers

`.mcp.json` ships with Context7 and Exa only. They require no secrets in this repo. Optional secret-backed servers such as Supabase or Apify are documented in `.env.example` as snippets to copy when needed.

## When To Skip Mantle

Skip Mantle for one-file scripts or throwaway prototypes. It pays off when an agent or human will return later and needs to understand project state quickly.
