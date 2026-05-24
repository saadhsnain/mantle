<!-- Paste below into root AGENTS.md if using the research variant. -->

## Variant conventions — research

This project is research-shaped: scraping, investigation, pipelines.

- **`session-log.md`** is the running history. After any session that involved trial-and-error, append a Session block (what tried, what failed, what decided). This is distinct from `brain/project/timeline.md`: the brain timeline is for *facts*; session-log is for *the path we walked to get there*.
- **`config.yaml`** is the single config. Don't add `.env`-style toggles for things that belong here.
- **`runs/`** is per-execution output. Self-contained, gitignored. Each run writes `run.log`, `run.jsonl`, and any data artifacts under `runs/YYYYMMDD_HHMMSS_<mode>/`.
- **Cloudflare / proxy quirks**, rate limits, and other infrastructure gotchas belong in `session-log.md` first, then promoted to `brain/project/compiled-truth.md` once stable.
