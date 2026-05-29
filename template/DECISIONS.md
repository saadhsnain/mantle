# Decisions

Append-only, ADR-style. Newest at top. Once an entry is **Accepted**, never edit or delete it — supersede it with a new entry and flip the old one's status to `Superseded by ADR-NNNN`.

Each entry:

```markdown
## ADR-NNNN — <title>   (YYYY-MM-DD · Status: Proposed | Accepted | Superseded by ADR-MMMM)

**Context** — what forced the decision.
**Decision** — what we chose.
**Consequences** — what this commits us to / rules out.
```

A `Proposed` entry is an open question: it records a decision not yet made. Resolve it by flipping its status to `Accepted` (and filling in Decision/Consequences) — not by deleting it.

Multi-scope projects use `##`-level scope headings here rather than separate folders.

---

## ADR-0001 — Project scaffolded from Mantle   (__DATE__ · Status: Accepted)

**Context** — __PROJECT_NAME__ needed a starting structure.
**Decision** — Scaffold from Mantle, adopting the flat repo-doc set (`README.md`, `CHANGELOG.md`, `DECISIONS.md`, `FUTURE.md`) and `skills/`.
**Consequences** — Record subsequent decisions here as new ADRs; record changes in `CHANGELOG.md`.
