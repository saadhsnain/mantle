# Changelog

Append-only, dated. Newest at top. Each block follows:

```
## YYYY-MM-DD — <topic>

### Added
- ...

### Changed
- ...

### Removed
- ...
```

Use `scripts/log-change.sh` for canonical writes — it reuses same-day same-topic blocks and dedupes bullets.

---

## 2026-05-29 — brain consolidation

### Added
- DECISIONS.md (ADR-style, append-only) as the canonical 'why' record; template/DECISIONS.md ships token-stamped ADR-0001

### Changed
- AGENTS.md: 'Brain-first lookup' -> 'Repo-first lookup'; brain conventions replaced with flat repo-doc set (README/CHANGELOG/decisions/FUTURE)
- redirect + convenience docs (CLAUDE.md, .cursor rules, README, CONTRIBUTING, FUTURE, research variant) repointed from brain to repo docs

### Removed
- brain/ folder (compiled-truth.md, timeline.md, open-questions.md, linked.md) from root and template; brain/raw + brain/out from .gitignore and the Stop-hook path filter

## 2026-05-24 — production scaffold layout

### Added
- template directory as the canonical base tree for generated projects

### Changed
- init.sh now copies template plus variants and performs token replacement
- Mantle source docs now distinguish root generator docs from generated project files
- Mantle brain now describes the scaffold generator architecture

### Removed
- inline generated-project file bodies from init.sh

## 2026-05-24 — clean scaffold generator

### Added
- scripts/init.sh to create clean downstream projects from Mantle

### Changed
- Mantle docs now describe scaffold generation instead of raw folder copying
- generated projects omit variants, scripts/init.sh, Mantle README, and Mantle changelog history
- generated project AGENTS, CONTRIBUTING, FUTURE, README, changelog, and brain files are written as project-facing files

## 2026-05-24 — duplicate guidance

### Added
- python manual variant for future Python project copies

### Changed
- agent guide now tells agents to personalize copied Mantle projects instead of stopping after cp -r
- variant append headings no longer depend on numbered AGENTS.md sections
- README variant list now includes the Python overlay

## 2026-05-24 — template cleanup

### Changed
- variant overlay instructions now copy explicit files instead of overwriting the root README
- scope and skill docs now describe creating the four-file shape directly

### Removed
- committed .DS_Store metadata files
- internal brain and skill _template folders

## 2026-05-24 — scaffold

### Added
- Initial Mantle template: AGENTS.md as canonical agent spec, CLAUDE.md redirect, brain/ skeleton (_template + project), skills/ skeleton, scripts/log-change.sh, .mcp.json with Context7 + Exa, .claude convenience hook, three variant overlays (research, react-vite, nextjs).
