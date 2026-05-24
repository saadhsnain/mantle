# Variant — python

Minimal Python package skeleton using `pyproject.toml`, `src/`, pytest, and Ruff.

## What this variant adds

- `pyproject.toml` — package metadata, pytest config, Ruff config
- `src/app/__init__.py` — package entry point before `init.sh` renames it
- `src/app/__main__.py` — runnable module
- `tests/test_smoke.py` — smoke test

## How to apply

Manual. From the repo root:

```bash
cp variants/python/pyproject.toml .
cp -R variants/python/src .
cp -R variants/python/tests .
uv sync --extra dev
uv run pytest
```

Then:

1. Rename `src/app/` to the real import package when the project name is stable.
2. Update `pyproject.toml` package metadata.
3. Paste `AGENTS_APPEND.md` into the bottom of root `AGENTS.md` if you want variant guidance baked in.
4. Delete `variants/` after.

## Verification ("done" for this variant)

- `uv run pytest` passes
- `uv run ruff check .` passes when Ruff is installed
- Material changes recorded in `CHANGELOG.md`
