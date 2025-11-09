# 如何在一个仓库中组织多个 Slidev 幻灯片（多 Deck）

本文给出在一个仓库中维护多份 Slidev 幻灯片（多个 deck）的组织方式与取舍建议，
并附带可直接复用的开发/构建脚本示例。

## 本仓库的约定（不污染根目录）

- 所有与 Slidev 相关的文件、依赖与产物，均放在 `slides/` 子目录层级内。
- 不在项目根目录放置 Slidev 的依赖、脚本或构建产物。
- 每个“主题（topic）”一个子目录；每个主题内采用“单目录 + 多个 Markdown 入口（Option 1）”。

推荐结构（以 `coding-agents` 主题为例）：

```text
slides/
  coding-agents/
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
```

> 说明：上述结构将“多入口（多个 Markdown 文件）”放在 `main/` 下，
> 其余 Slidev 约定目录（components/layouts/public/setup/styles 等）与之并列，
> 完全局部化到该主题目录，不向根目录“泄漏”。

## 开发与构建（使用 npx，或在主题目录内单独 package.json）

方式 A：使用 `npx`（无需在仓库根目录安装依赖）

```bash
# 开发单个入口（在仓库根目录执行）
npx slidev slides/coding-agents/main/intro.md

# 批量构建该主题下所有入口（产物写回到该主题自身的 dist）
npx slidev build 'slides/coding-agents/main/*.md' --out slides/coding-agents/dist

# 子路径部署示例（如 GitHub Pages 下的 talks 子路径）
npx slidev build slides/coding-agents/main/intro.md \
  --out slides/coding-agents/dist/intro \
  --base /talks/coding-agents/intro/
```

方式 B：在“主题目录”内单独管理依赖（可选）

```json
// slides/coding-agents/package.json（可选）
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
cd slides/coding-agents
npm install
npm run dev:intro
npm run build:all
```

## 多主题场景

当存在多个主题目录（例如 `slides/ai-agents`、`slides/prompt-engineering`）时，
可以按主题分别构建，避免产物混杂在仓库根目录：

```bash
# 从仓库根目录遍历每个主题，构建其 main 下的所有入口
for t in slides/*; do \
  if [ -d "$t/main" ]; then \
    npx slidev build "$t"/main/*.md --out "$t"/dist; \
  fi; \
done
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
> 将入口与约定目录都放在 `slides/<topic>/` 下，是实践中常见且稳妥的组织方式。
