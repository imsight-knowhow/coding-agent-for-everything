# Repository Guidelines

This repository hosts Chinese-language tutorials, slides, talks, examples, and resources about coding agents. Keep contributions focused, well-structured, and easy to review.

## Project Structure & Module Organization
- `tutorials/` long-form guides; one topic per file/folder.
- `slides/` slide decks; attach images under `resources/`.
- `talks/` outlines, scripts, Q&A.
- `examples/` runnable or illustrative snippets with a short `README.md`.
- `resources/` shared assets (images, links, reference lists).
- `README.md` project overview. Update when major areas change.

## Build, Test, and Development Commands
There is no build pipeline. Recommended local checks:
- Markdown lint (optional): `npx markdownlint "**/*.md"`
- Link check (optional): `npx markdown-link-check -q README.md`
- Preview Markdown in editor (e.g., VS Code: Ctrl+Shift+V).

## Coding Style & Naming Conventions
- Language: write content in Chinese.
- Markdown: use `#`-based headings, ordered hierarchy, and fenced code blocks with language tags.
- Line length: aim for ≤100 characters; wrap lists/paragraphs naturally.
- Filenames: lowercase-kebab-case, e.g., `getting-started.md`; images `lowercase-kebab.png`.
- Links: use relative paths within the repo; provide descriptive alt text for images.
- Place shared assets in `resources/`; keep directory-local images in a nested `images/` folder when needed.

## Testing Guidelines
- Lint Markdown and check links before submitting.
- For `examples/`, include minimal run steps in `examples/<topic>/README.md` (commands, prerequisites).
- Validate that code blocks compile or run when feasible; otherwise mark as pseudo-code.

## Commit & Pull Request Guidelines
- Commit messages in Chinese; concise, imperative style.
- Suggested prefixes: `docs:`, `tutorials:`, `slides:`, `talks:`, `examples:`, `fix:`, `chore:` (e.g., `docs: 更新 README 结构`).
- Pull Requests: include purpose, scope, affected directories, and screenshots/previews for slides. Link related issues. Keep PRs small and focused.

## Agent-Specific Instructions
- Do not reformat unrelated files or restructure directories without need.
- Prefer minimal diffs; keep edits scoped to the relevant folder.
- Preserve Chinese terminology; do not auto-translate.
- When adding new content, update the corresponding folder `README.md` and, if broadly relevant, the root `README.md`.
- Avoid real secrets in examples; use placeholders like `<API_KEY>`.

