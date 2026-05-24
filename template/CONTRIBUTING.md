# Contributing

## Local Checks

Run the checks that match this project's stack before committing. At minimum:

```bash
bash -n scripts/log-change.sh
jq . .mcp.json > /dev/null
```

For Python projects:

```bash
uv run pytest
uv run ruff check .
```

For Node projects, use the scripts in `package.json`.

## Standards

- `AGENTS.md` is the canonical agent guide.
- Keep `brain/project/compiled-truth.md` current when architecture or product truth changes.
- Append material changes to `CHANGELOG.md` with `scripts/log-change.sh`.
- Put repeatable procedures in `skills/`.
