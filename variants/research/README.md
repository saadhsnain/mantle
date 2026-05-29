# Variant — research

For scrapers, data pipelines, investigative or research-heavy projects. Inspired by `depopscraperuk`.

## What this variant adds

- `SESSION-LOG.md` — running history of every investigative session. What was tried, what failed, what was decided. Lives at repo root.
- `config.yaml` — single YAML config for runtime knobs (queries, targets, proxy, headless flags). Keep it flat; no per-environment overrides.
- `runs/` directory pattern — each execution writes to `runs/YYYYMMDD_HHMMSS_<mode>/` with its own logs and outputs. Already in `.gitignore`.

## How to apply

Manual. From this folder, copy:

```bash
cp variants/research/SESSION-LOG.md ./
cp variants/research/config.yaml ./
mkdir -p runs   # gitignored already
```

Then paste the contents of `AGENTS_APPEND.md` into the bottom of root `AGENTS.md` if you want the variant-specific guidance baked into the harness.

Delete `variants/` after you've copied what you need.

## Verification ("done" for this variant)

A change is done when:

- The script runs end-to-end on a small input without errors.
- New behavior is recorded in `SESSION-LOG.md` (what was tried, what worked).
- Material changes are in `CHANGELOG.md` via `scripts/log-change.sh`.
- `README.md` reflects current architecture if it shifted; any decision is recorded in `DECISIONS.md`.
