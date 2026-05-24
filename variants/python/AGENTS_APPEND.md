<!-- Paste below into root AGENTS.md if using the python variant. -->

## Variant conventions — Python

- **Package layout**: use `src/<package_name>/` for importable code and `tests/` for tests.
- **Environment**: prefer `uv` for sync, running tools, and dependency management.
- **Typing**: keep public functions typed. Avoid broad `Any` unless the boundary truly requires it.
- **Formatting/linting**: use Ruff when configured.
- **Verification**: `uv run pytest` before claiming a behavioral change done; also run `uv run ruff check .` when Ruff is installed.
