---
scope: project
last_reviewed: 2026-05-24
---

# Compiled Truth — Mantle

## Overview

Mantle is a small scaffold generator for agent-led projects. It creates clean downstream repositories with a shared agent harness, repo brain, changelog discipline, and optional stack overlays.

## Architecture

- `scripts/init.sh` is the scaffold generator.
- `template/` is the base project tree copied into every generated project.
- `variants/` contains optional overlays for `python`, `research`, `react-vite`, and `nextjs`.
- `scripts/log-change.sh` is the changelog writer used by Mantle and copied into generated projects through `template/scripts/log-change.sh`.
- Root docs describe Mantle itself; generated projects receive their own project-facing docs from `template/`.

## Decisions

- Mantle is a generator, not a folder to duplicate directly. Raw copying leaked Mantle source docs and stale variants into downstream projects.
- Generated projects must not include `template/`, `variants/`, or `scripts/init.sh`.
- Template files use explicit tokens (`__PROJECT_NAME__`, `__SLUG__`, `__PACKAGE_NAME__`, `__DATE__`) that `scripts/init.sh` replaces before handing off the project.

## Glossary

- **Template** — the base file tree under `template/` copied into every generated project.
- **Variant** — an optional stack overlay under `variants/<name>/`.
- **Repo brain** — the `brain/project/` files that store compiled truth, timeline, open questions, and links.
