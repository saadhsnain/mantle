# Variants

Variants are shallow overlays applied by `scripts/init.sh` after `template/` is copied.

## Available Variants

| Name | Path | Purpose | Primary checks |
|---|---|---|---|
| `none` | `template/` only | Plain project harness. | `scripts/check.sh` |
| `python` | `variants/python/` | Minimal Python package with pytest/Ruff conventions. | `uv run pytest`; `uv run ruff check .` when Ruff is installed |
| `research` | `variants/research/` | Scrapers, pipelines, and investigation-heavy projects. | Small-input run; `SESSION-LOG.md` updated |
| `react-vite` | `variants/react-vite/` | Vite + React + TypeScript + Tailwind v4 starter. | `pnpm typecheck`; `pnpm dev` |
| `nextjs` | `variants/nextjs/` | Next.js App Router + TypeScript + Tailwind v4 starter. | `pnpm typecheck`; `pnpm build` |

## Rules

- Keep variants shallow. They are bootable skeletons, not applications.
- Each variant must include `README.md`.
- Each variant should include `AGENTS_APPEND.md` when stack-specific conventions exist.
- Add new variants to this registry, root `README.md`, and `MANIFEST.md`.
- Do not let generated projects inherit `variants/`; `scripts/init.sh` copies only selected overlay files.
