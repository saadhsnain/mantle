# Mantle Manifest

This file maps Mantle's source tree so future agents can orient quickly.

## Source Generator

| Path | Role |
|---|---|
| `scripts/init.sh` | Creates downstream projects from `template/` and an optional `variants/<name>/` overlay. |
| `scripts/log-change.sh` | Appends material changes to `CHANGELOG.md`; copied into generated projects. |
| `scripts/check.sh` | Runs Mantle's repository-level hygiene and smoke checks. |
| `template/` | Base files copied into every generated project. |
| `variants/` | Stack overlays applied after the base template. |

## Root Knowledge Files

| Path | Role |
|---|---|
| `README.md` | Current-state overview for humans and agents. |
| `AGENTS.md` | Canonical agent operating guide. |
| `CHANGELOG.md` | Append-only dated history of material changes. |
| `DECISIONS.md` | Append-only ADR log explaining why decisions were made. |
| `FUTURE.md` | Admission rules and deferred ideas. |
| `CONTRIBUTING.md` | Local checks and contribution rules. |
| `MANIFEST.md` | This source-tree map. |

## Generated Project Shape

Every generated project receives:

- agent entrypoints: `AGENTS.md`, `CLAUDE.md`, `.codex/AGENTS.md`, `.cursor/rules/agents.mdc`, `.kilocode/rules.md`, `.opencode/AGENTS.md`
- repo docs: `README.md`, `CHANGELOG.md`, `DECISIONS.md`, `FUTURE.md`, `CONTRIBUTING.md`
- maintenance scripts: `scripts/log-change.sh`, `scripts/check.sh`
- skill registry: `skills/README.md`
- optional stack files from exactly one variant

Generated projects must not receive Mantle source-only files: `template/`, `variants/`, `scripts/init.sh`, or Mantle's own changelog history.

## Variant Registry

| Variant | Source | Purpose |
|---|---|---|
| `none` | `template/` only | Plain project harness. |
| `python` | `variants/python/` | Minimal Python package with pytest/Ruff conventions. |
| `research` | `variants/research/` | Research, scraping, and pipeline projects with session logging. |
| `react-vite` | `variants/react-vite/` | React + Vite + TypeScript + Tailwind v4 starter. |
| `nextjs` | `variants/nextjs/` | Next.js App Router + TypeScript + Tailwind v4 starter. |
