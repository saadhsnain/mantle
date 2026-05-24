<!-- Paste below into root AGENTS.md if using the nextjs variant. -->

## Variant conventions — Next.js

- **App Router** only. `src/app/` is the source tree.
- **Path alias**: `@/` → `src/`. Never relative `../../` chains.
- **Tailwind v4**: design tokens in `src/app/globals.css` under `@theme {}`. Don't create `tailwind.config.js`.
- **Server Components by default**; opt into `"use client"` only when you need it (hooks, browser APIs, event handlers).
- **shadcn**: import from `@/components/ui/<name>`. Use `cn()` from `@/lib/utils`.
- **Package manager**: pnpm.
- **Verification**: `pnpm typecheck && pnpm build` before claiming a feature done. For UI changes, also `pnpm dev` and drive the browser via `agent-browser`.
