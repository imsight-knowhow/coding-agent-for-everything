#!/usr/bin/env bash
set -euo pipefail

# install-pptx-deps.sh
# Purpose: Install dependencies required to export Slidev slides to PPTX.
# - Ensures dev dependency: playwright-chromium
# - Downloads Chromium browser binaries used by Playwright
# - Verifies @slidev/cli is available

echo "[install] Checking Node.js and npm..."
if ! command -v node >/dev/null 2>&1; then
  echo "Error: Node.js is not installed (>=18 required)." >&2
  exit 1
fi
if ! command -v npm >/dev/null 2>&1; then
  echo "Error: npm is not installed." >&2
  exit 1
fi

node_ver=$(node -v)
echo "[install] Node: $node_ver"

echo "[install] Ensuring @slidev/cli is installed..."
if ! npm ls @slidev/cli --depth=0 >/dev/null 2>&1; then
  npm i -D @slidev/cli
else
  echo "[install] @slidev/cli already present."
fi

echo "[install] Ensuring playwright-chromium is installed..."
if ! npm ls playwright-chromium --depth=0 >/dev/null 2>&1; then
  npm i -D playwright-chromium
else
  echo "[install] playwright-chromium already present."
fi

echo "[install] Downloading Playwright Chromium browser..."
npx playwright install chromium

echo "[ok] PPTX export dependencies installed."
echo
echo "Next: export PPTX, e.g."
echo "  npx slidev export slides/coding-agents-intro/main/index.md \\
      --format pptx --with-clicks \\
      --output slides/coding-agents-intro/dist/coding-agents-intro"

