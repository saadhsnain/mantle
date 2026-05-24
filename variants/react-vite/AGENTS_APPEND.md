<!-- Paste below into root AGENTS.md if using the react-vite variant. -->

## Variant conventions — React + Vite

- **Path alias**: `@/` → `src/`. Never use relative `../../` chains.
- **Tailwind v4**: design tokens live in `src/index.css` under `@theme {}`. Don't create `tailwind.config.js`.
- **shadcn components**: import from `@/components/ui/<name>`. Use `cn()` from `@/lib/utils`.
- **TypeScript**: strict mode on. No `any` — use proper types or generics.
- **Package manager**: pnpm. Don't run `npm`/`yarn`/`bun`.
- **Verification**: `pnpm typecheck && pnpm dev` before claiming a UI change done. For visual changes, drive the browser via the `agent-browser` skill rather than guessing.
