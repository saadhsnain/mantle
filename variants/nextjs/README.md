# Variant — nextjs

Minimal Next.js 15 App Router + TypeScript + Tailwind v4 skeleton.

## What this variant adds

- `package.json` — Next.js 15, React 19, TypeScript, Tailwind v4
- `next.config.mjs`
- `tsconfig.json` — strict, with `@/` → `src/`
- `src/app/layout.tsx`, `src/app/page.tsx` — bootable hello-world
- `src/app/globals.css` — Tailwind v4 `@theme {}` with starter tokens
- `src/lib/utils.ts` — `cn()` helper

## How to apply

Manual. From the repo root:

```bash
cp variants/nextjs/package.json .
cp variants/nextjs/next.config.mjs .
cp variants/nextjs/postcss.config.mjs .
cp variants/nextjs/tsconfig.json .
cp -R variants/nextjs/src .
pnpm install
pnpm dev
```

Then paste `AGENTS_APPEND.md` into the bottom of root `AGENTS.md` if you want variant guidance baked in.

Delete `variants/` after.

## Verification ("done" for this variant)

- `pnpm typecheck` passes
- `pnpm build` passes
- `pnpm dev` boots; routes render
- For UI changes: verified via the `agent-browser` skill or manually
- Material changes recorded in `CHANGELOG.md`
