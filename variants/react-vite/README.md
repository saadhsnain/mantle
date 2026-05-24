# Variant — react-vite

Minimal Vite + React + TypeScript + Tailwind v4 + shadcn-ready skeleton.

## What this variant adds

- `package.json` — Vite, React 19, TypeScript, Tailwind v4, shadcn-ready dependencies
- `vite.config.ts` — SWC, `@/` alias → `src/`
- `tsconfig.json` + `tsconfig.node.json` — strict, with `@/` path mapping
- `index.html`
- `src/main.tsx`, `src/App.tsx` — bootable hello-world
- `src/index.css` — Tailwind v4 `@theme {}` with starter tokens
- `src/lib/utils.ts` — `cn()` helper for shadcn

## How to apply

Manual. From the repo root:

```bash
cp variants/react-vite/package.json .
cp variants/react-vite/index.html .
cp variants/react-vite/vite.config.ts .
cp variants/react-vite/tsconfig*.json .
cp -R variants/react-vite/src .
pnpm install
pnpm dev
```

Then paste `AGENTS_APPEND.md` into the bottom of root `AGENTS.md` if you want variant guidance baked in.

Delete `variants/` after.

## Verification ("done" for this variant)

A change is done when:

- `pnpm typecheck` passes
- `pnpm lint` passes (if configured)
- `pnpm dev` boots and the change renders in the browser
- For UI changes: verified via the `agent-browser` skill or manually
- Material changes recorded in `CHANGELOG.md`
