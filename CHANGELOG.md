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
