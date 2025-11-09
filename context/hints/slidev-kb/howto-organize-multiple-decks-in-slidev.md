# 如何在一个仓库中组织多个 Slidev 幻灯片（多 Deck）

本文给出在一个仓库中维护多份 Slidev 幻灯片（多个 deck）的组织方式与取舍建议，
并附带可直接复用的构建与开发脚本示例。

## 结论与建议（TL;DR）

- 两种方式都是被官方 CLI 支持的：
  1) 单目录多 Markdown 文件（共享一套组件/样式/公共资源）
  2) 每个 deck 一个子目录（每个目录内有自己的 `slides.md` 与资源）
- 推荐：当你需要隔离资源、按 deck 定制主题/样式/配置或规模较大时，
  采用“每个 deck 一个子目录”的方式，结构更清晰、冲突更少、扩展更方便。
- 若多个 deck 极简且高度共享同一套组件/样式，且不需要按 deck 配置，
  则“单目录多 Markdown 文件”也能满足需求，脚本更简洁。

## 方式一：单目录 + 多个 Markdown 入口

结构示例（入口都在同一目录下，共享 components/layouts/public 等）：

```text
slides/
  intro.md
  advanced.md
components/
layouts/
public/
styles/
```

运行与构建（可用通配符一次性构建多个入口）：

```bash
# 开发其中一个 deck
slidev slides/intro.md

# 一次性构建多个 deck（官方文档：Multiple Builds）
slidev build slides/intro.md slides/advanced.md --out dist
# 或使用 glob（shell 需支持）
slidev build 'slides/*.md' --out dist
```

package.json 脚本示例：

```json
{
  "scripts": {
    "slides:dev:intro": "slidev slides/intro.md",
    "slides:build:all": "slidev build 'slides/*.md' --out dist"
  }
}
```

何时选择：deck 很少且共享一切，几乎不做按 deck 的差异化配置。

## 方式二：每个 deck 单独子目录（推荐）

结构示例（每个 deck 自己的目录与约定文件/文件夹）：

```text
slides/
  deck-a/
    slides.md
    components/
    layouts/
    public/
    setup/
    styles/
    vite.config.ts   # 可选，仅影响该 deck
  deck-b/
    slides.md
```

运行与构建：

```bash
# 开发某个 deck
slidev slides/deck-a/slides.md

# 批量构建所有 deck
slidev build 'slides/*/slides.md' --out dist

# 部署到子路径时（如 GitHub Pages），需指定 base
slidev build slides/deck-a/slides.md --out dist/deck-a --base /talks/deck-a/
```

package.json 脚本示例：

```json
{
  "scripts": {
    "slides:dev:a": "slidev slides/deck-a/slides.md",
    "slides:build:a": "slidev build slides/deck-a/slides.md --out dist/deck-a",
    "slides:build:all": "slidev build 'slides/*/slides.md' --out dist"
  }
}
```

为什么更推荐：
- 资源隔离：每个 deck 自有 `public/`、`components/`，避免命名冲突。
- 配置灵活：按 deck 添加 `vite.config.ts`、主题、样式覆盖与插件。
- 部署方便：不同 deck 可以输出到不同目录、使用不同 `--base`。
- 规模友好：多人协作、长期维护更清晰。

## 参考与来源（官方文档）
- Multiple Builds（一次构建多个入口）：
  https://sli.dev/guide/hosting#multiple-builds
- CLI 入口文件可为任意路径：
  https://sli.dev/builtin/cli
- 目录结构约定（components/layouts/public/setup/styles 等）：
  https://sli.dev/custom/directory-structure

> 备注：官方 CLI 支持把入口指向任意位置的 Markdown 文件，
> 因此将 deck 放在子目录是实践中常见且可行的组织方式。
> 少数版本曾出现入口不在项目根目录时 `public/` 解析的小问题，
> 将静态资源放在每个 deck 自己的 `public/` 可规避大多数坑。
