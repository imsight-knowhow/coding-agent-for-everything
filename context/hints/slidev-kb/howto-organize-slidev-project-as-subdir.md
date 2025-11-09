Totally doable. Keep your Slidev deck in a subfolder and run the CLI against that entry file from the repo root.

### Recommended layout

```
my-project/
├─ src/                   # your app/TS stuff
├─ package.json           # single root manifest (devDep: @slidev/cli)
├─ tsconfig.json
├─ slides/                # <— all slide-specific files live here
│  ├─ deck-a/             # (one folder per deck if you have many)
│  │  ├─ slides.md
│  │  ├─ components/
│  │  ├─ layouts/
│  │  ├─ public/
│  │  ├─ setup/
│  │  ├─ styles/
│  │  └─ vite.config.ts   # optional, only affects this deck
│  └─ deck-b/
│     └─ slides.md
└─ dist/                  # slide builds (per-deck) go here
```

* The Slidev “conventional” folders (`components/`, `layouts/`, `public/`, `setup/`, `styles/`, optional `vite.config.ts`) are discovered by convention next to your deck; keep them in each deck folder so they don’t collide with your app. ([Slidev][1])
* You can point Slidev at any Markdown entry file, so a subdir entry like `slides/deck-a/slides.md` is fine. ([Slidev][2])

### Root `package.json` scripts

```json
{
  "scripts": {
    "slides:dev:a": "slidev slides/deck-a/slides.md",
    "slides:build:a": "slidev build slides/deck-a/slides.md --out dist/deck-a",
    "slides:build:all": "slidev build 'slides/*/slides.md' --out dist"
  },
  "devDependencies": {
    "@slidev/cli": "^0.52.0"
  }
}
```

* Slidev supports multiple inputs in one build; each Markdown entry produces its own folder in `--out`. Handy for many decks in one repo. ([Slidev][3])

### Hosting under a subpath (GitHub Pages, `/talks/foo/`, etc.)

When publishing a deck under a sub-route, pass `--base` so asset URLs resolve correctly:

```bash
pnpm run slides:build:a -- --base /talks/deck-a/
```

(Leading and trailing slashes are required.) ([Slidev][3])

### Assets & “public/” tips

* Images you reference with relative paths inside Markdown (e.g. `![alt](./img.png)`) are bundled by Vite and “just work.” ([Slidev][4])
* Anything under `public/` is copied verbatim and served from `/` in dev and build. Use a **per-deck** `public/` to avoid name clashes across decks. ([Slidev][1])
* Be cautious with front-matter strings that contain relative paths (they don’t get rewritten at build). Prefer Markdown imports or Vue props over front-matter URLs. ([Slidev][4])

### Custom Vite tweaks per deck (optional)

If a deck needs aliases or plugins, put a `vite.config.ts` right inside that deck folder; Slidev merges it with its defaults. Example: add an alias to reuse shared components:

```ts
// slides/deck-a/vite.config.ts
import { defineConfig } from 'vite'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
  resolve: {
    alias: {
      '@shared': fileURLToPath(new URL('../_shared', import.meta.url))
    }
  }
})
```

This only applies to that deck. ([Slidev][5])

### Known edge cases (so you don’t get tripped)

* Pointing the CLI to a **sibling** path outside the deck directory has had regressions in recent versions (dev server resolving). Use a subfolder layout as above, or run the command from inside the deck folder if you ever hit this. ([GitHub][6])
* A few versions also had quirks with `public/` when the entry wasn’t at the project root; keeping a per-deck `public/` next to `slides.md` avoids surprises. ([GitHub][7])

That’s it—single `package.json` at the root, deck(s) in `slides/`, and scripts that target each `slides.md`. If you want, I can generate the exact scripts for your deck names and hosting paths.

[1]: https://sli.dev/custom/directory-structure "Directory Structure | Slidev"
[2]: https://sli.dev/builtin/cli?utm_source=chatgpt.com "Slidev CLI"
[3]: https://sli.dev/guide/hosting?utm_source=chatgpt.com "Building and Hosting"
[4]: https://sli.dev/guide/faq?utm_source=chatgpt.com "FAQ"
[5]: https://sli.dev/custom/config-vite "Configure Vite and Plugins | Slidev"
[6]: https://github.com/slidevjs/slidev/issues/2071?utm_source=chatgpt.com "bug: error in `dev` command when specifying a an entry file ..."
[7]: https://github.com/slidevjs/slidev/issues/2161?utm_source=chatgpt.com "Static assets in public/ fail (redirect or resolve error) with ..."
