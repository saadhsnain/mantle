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

## ADR-0005 — Baseline checks are first-class scaffold files   (2026-06-06 · Status: Accepted)

**Context** — Mantle had a documented local-check sequence in `CONTRIBUTING.md`, but no single command to run it. Generated projects also had `scripts/log-change.sh` but no equivalent baseline verification script.
**Decision** — Add `scripts/check.sh` to Mantle source and `template/scripts/check.sh` to generated projects. Mantle's script verifies shell syntax, MCP JSON, script parity, source hygiene, redirect files, and a generated-project smoke test. The generated-project script verifies shell syntax, MCP JSON when `jq` exists, and `.DS_Store` hygiene.
**Consequences** — Future agents can run one canonical check before claiming Mantle maintenance done. Stack-specific checks still live in variant docs and are not folded into the base script.

## ADR-0004 — Mantle keeps a source manifest and variant registry   (2026-06-06 · Status: Accepted)

**Context** — Mantle's README explained the project, but there was no compact source-tree map or single registry for variants. That made future maintenance rely on reading `scripts/init.sh` and several README files.
**Decision** — Add `MANIFEST.md` for source layout and generated-output shape. Add `variants/README.md` for variant names, purposes, checks, and rules.
**Consequences** — Any source-layout or variant change must update these files alongside README/AGENTS as needed. The manifest is source-only and is not copied into generated projects.

## ADR-0003 — Generated projects exclude generator-only files   (2026-05-24 · Status: Accepted)

**Context** — Raw copying of Mantle leaked source-only docs and stale overlays into downstream projects.
**Decision** — Generated projects must not include `template/`, `variants/`, `scripts/init.sh`, Mantle's own README, or Mantle's changelog history.
**Consequences** — `scripts/init.sh` is the only supported path to a new project; downstream repos are clean scaffolds, not Mantle clones. Template files use explicit tokens (`__PROJECT_NAME__`, `__SLUG__`, `__PACKAGE_NAME__`, `__DATE__`) replaced at creation time.

## ADR-0002 — Mantle is a generator, not a folder to duplicate   (2026-05-24 · Status: Accepted)

**Context** — Copying the Mantle directory directly was the original workflow, but it dragged source-only docs and variants into every project.
**Decision** — Mantle is a scaffold *generator*. Downstream projects are produced by `scripts/init.sh` from `template/` plus an optional `variants/<name>/` overlay.
**Consequences** — `template/` is the canonical base output tree; `variants/` are shallow overlays; root docs describe Mantle itself, not generated projects.

## ADR-0001 — Repo docs replace the four-file brain   (2026-05-29 · Status: Accepted)

**Context** — The repo brain shipped four files per scope (`compiled-truth.md`, `timeline.md`, `open-questions.md`, `linked.md`) into every generated project. `timeline.md` duplicated `CHANGELOG.md` (both append-only dated logs); `compiled-truth.md` duplicated `README.md` (synthesized current state) and silently drifted because its `last_reviewed` stamp was passive; decisions lived in a *rewritable* section of `compiled-truth.md`, destroying decision history on every rewrite. As a generator, this maintenance cost multiplied across every downstream repo.
**Decision** — Collapse the brain into a flat doc set: `README.md` (current state), `CHANGELOG.md` (what changed — absorbs the timeline), `DECISIONS.md` (why — this file, append-only/ADR-style, absorbs open-questions as `Proposed` entries), `FUTURE.md` (forward intent). Remove the `brain/` folder. Keep `scripts/log-change.sh` as-is (a git commit-msg hook was considered and rejected: fires on human commits, not cleanly deletable, depends on disciplined commit messages).
**Consequences** — "Brain-first lookup" becomes "Repo-first lookup": the same principle (repo truth beats agent memory) over fewer files. Scopes become optional `##` headings instead of folders. Decisions are now append-only and superseded rather than overwritten.
