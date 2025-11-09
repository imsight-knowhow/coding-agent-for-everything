# 如何在一个仓库中组织多个 Slidev 幻灯片（多 Deck）

本文给出在一个仓库中维护多份 Slidev 幻灯片（多个 deck）的组织方式与取舍建议，
并附带可直接复用的开发/构建脚本示例。

## 项目布局与理由（Python + TS/JS，根清单，子目录代码）

- 技术栈：仓库同时包含 Python 与 TypeScript/JavaScript。
- 管理方式：
  - Python 采用 Pixi（使用 `pyproject.toml`，通过 `pixi run` 运行脚本）。
  - TS/JS 采用 Node.js（使用根级 `package.json` 管理依赖与脚本，Node ≥ 18）。
- 清单位置：所有清单/清单锁文件（如 `pyproject.toml`、`package.json`、`pixi.lock`）集中在仓库根目录，便于统一 CI/CD 与开发者认知。
- 代码与资产：各自脚本与资源放在子目录中；Slidev 的 Markdown、组件、布局与静态资源全部位于 `slides/` 之下，不在根目录堆放幻灯片相关文件与产物。
- 多主题（topic）组织：每个“主题”一个子目录；每个主题内采用“单目录 + 多个 Markdown 入口（Option 1）”。

推荐结构（使用占位名 `<topic-a>`、`<topic-b>` 展示多个主题）：

```text
slides/
  <topic-a>/
    main/                # 多个入口 Markdown（每个入口对应一个 deck）
      intro.md
      advanced.md
    components/          # 仅作用于该主题的组件
    layouts/             # 仅作用于该主题的布局
    public/              # 仅作用于该主题的静态资源
    setup/               # 预处理/扩展（可选）
    styles/              # 主题样式（可选）
    vite.config.ts       # 可选，仅影响该主题
    dist/                # 构建输出目录（仅该主题）
  <topic-b>/
    main/
      overview.md
      deep-dive.md
    components/
    public/
    dist/
```

> 说明：上述结构将“多入口（多个 Markdown 文件）”放在 `main/` 下，
> 其余 Slidev 约定目录（components/layouts/public/setup/styles 等）与之并列，
> 完全局部化到该主题目录，不向根目录“泄漏”。

## 开发与构建（使用 npx，或在主题目录内单独 package.json）

方式 A：使用 `npx`（根级 `package.json` 管理依赖，或临时使用 npx）

```bash
# 开发单个入口（在仓库根目录执行）
npx slidev slides/<topic-a>/main/intro.md

# 批量构建该主题下所有入口（产物写回到该主题自身的 dist）
npx slidev build 'slides/<topic-a>/main/*.md' --out slides/<topic-a>/dist

# 子路径部署示例（如 GitHub Pages 下的 talks 子路径）
npx slidev build slides/<topic-a>/main/intro.md \
  --out slides/<topic-a>/dist/intro \
  --base /talks/<topic-a>/intro/
```

方式 B：在“主题目录”内单独管理依赖（可选，不是本项目默认）

```json
// slides/<topic-a>/package.json（可选）
{
  "private": true,
  "devDependencies": { "@slidev/cli": "^0.52.0" },
  "scripts": {
    "dev:intro": "slidev main/intro.md",
    "build:all": "slidev build 'main/*.md' --out dist"
  }
}
```

在主题目录内运行：

```bash
cd slides/<topic-a>
npm install
npm run dev:intro
npm run build:all
```

## 多主题场景

当存在多个主题目录（例如 `slides/<topic-a>`、`slides/<topic-b>`）时，
可以按主题分别构建，避免产物混杂在仓库根目录：

```bash
# 从仓库根目录遍历每个主题，构建其 main 下的所有入口
for t in slides/*; do \
  if [ -d "$t/main" ]; then \
    npx slidev build "$t"/main/*.md --out "$t"/dist; \
  fi; \
done

或使用单条命令（将所有入口输出到 `slides/dist`，每个入口生成一个子目录）：

```bash
npx slidev build 'slides/*/main/*.md' --out slides/dist
```

> 注意：为保持根目录整洁，建议输出到 `slides/<topic>/dist` 或集中到 `slides/dist`，而非仓库根的 `dist/`。

## 资产与 public/ 提示（合并自“子目录组织”指南）

- 引用相对路径图片（如 `![alt](./img.png)`）会由 Vite 处理并打包，通常“开箱即用”。
- `public/` 下的文件会被原样拷贝并在开发/构建时挂载到根路径 `/`；为避免冲突，请使用“每主题一个 public/”。
- 少数场景下，front‑matter 内的相对路径不会在构建时重写，建议改用 Markdown 引用或通过组件 props 传入。

## 每主题的 Vite 定制（可选）

某些主题需要自定义别名或插件时，可在该主题目录内放置 `vite.config.ts`，仅对该主题生效：

```ts
// slides/<topic-a>/vite.config.ts
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

## 已知边界（来自官方 issue，总结）

- 指向“兄弟路径”的入口在部分版本的 dev 服务中可能出现解析问题；建议将入口放在主题子目录内，或在该目录内运行命令。
- 入口不在项目根目录时，历史版本有过 `public/` 解析异常；将静态资源放在每主题 `public/` 通常可规避。
```

## 何时考虑“每个 deck 一个子目录（Option 2）”

- 当单个主题内部的 deck 需要完全不同的组件/布局/插件，且难以共享；
- 当构建逻辑需要严格隔离每个 deck 的配置与依赖；
- 或者历史原因已按 deck 拆分且成本较高时。

对于本仓库，优先采用“每主题一个目录 + 该目录下多入口 Markdown（Option 1）”方式，
保证简洁并与“不要污染根目录”的约束一致。

## 参考与来源（官方文档）
- Multiple Builds（一次构建多个入口）：
  https://sli.dev/guide/hosting#multiple-builds
- CLI 入口文件可为任意路径：
  https://sli.dev/builtin/cli
- 目录结构约定（components/layouts/public/setup/styles 等）：
  https://sli.dev/custom/directory-structure

> 备注：官方 CLI 支持把入口指向任意位置的 Markdown 文件；
> 将入口与约定目录都放在 `slides/<topic>/` 下，根目录仅放置清单与通用脚本，
> 是实践中常见且稳妥的组织方式（便于 Python/Node 双栈协作与 CI/CD）。
