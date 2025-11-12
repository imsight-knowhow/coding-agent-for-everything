# Repository Guidelines

本指南面向贡献者，说明本仓库的目录结构、开发方式、风格约定与提交规范。内容简洁、可执行。

## 项目结构与模块组织

- Python 源码：`src/`（仅供 Python 包，例：`src/code_them_all`）。TS/JS（含 Slidev）不得使用 `src/`。
- 幻灯片（Slidev）：`slides/<topic>/`
  - 入口 Markdown：`slides/<topic>/main/*.md`
  - 主题资源：`slides/<topic>/{components,layouts,public,setup,styles}`
  - 构建产物：`slides/<topic>/dist`
- 文档与素材：`tutorials/`、`talks/`、`examples/`、`resources/`

## 构建、测试与开发命令

- Python（Pixi，避免系统 python）
  - 运行脚本：`pixi run python -m code_them_all`，或 `pixi run python your_script.py`
- TS/JS（Node ≥ 18）
  - 安装依赖：`npm install`
  - 开发某个幻灯片：`npx slidev slides/<topic>/main/intro.md`
  - 构建某主题全部入口：`npx slidev build 'slides/<topic>/main/*.md' --out slides/<topic>/dist`
- 可选检查：`npx markdownlint "**/*.md"`，`npx markdown-link-check -q README.md`

## 编码风格与命名约定

- 语言：文档与示例以中文为主。
- Markdown：`#` 分级标题，使用围栏代码块并标注语言。
- 文件命名：`lowercase-kebab-case`；图片 `lowercase-kebab.png`。
- 链接：优先相对路径；图片集中 `resources/` 或就近 `images/` 子目录。

## 测试指南

- 提交前运行 Markdown Lint 与链接检查。
- `examples/` 必须包含运行步骤（`examples/<topic>/README.md`）；不可运行的代码标注为伪代码。

## 提交与 Pull Request 规范

- 提交信息（中文，祈使句），前缀建议：`docs:`、`tutorials:`、`slides:`、`talks:`、`examples:`、`fix:`、`chore:`
  - 例：`slides: 初始化 <topic> 多入口结构`
- PR 说明包含：目的、范围、影响目录与预览（如截图/构建路径），关联 Issue，保持粒度小且聚焦。

## 安全与配置

- 禁止提交真实密钥；使用 `<API_KEY>` 等占位符。
- 根目录仅放置清单（`pyproject.toml`、`package.json`、`pixi.lock` 等）；Slidev 代码与产物全部在 `slides/` 下，避免污染根空间。

## 跨平台开发

本项目支持 Windows 和 Linux 环境。Git 已配置行尾符规范化（`.gitattributes`）：
- 所有文本文件在仓库中使用 LF
- Shell 脚本（`.sh`）强制 LF
- Windows 脚本（`.bat`, `.cmd`, `.ps1`）使用 CRLF

首次克隆后执行：
```bash
git config --local core.autocrlf input
git config --local core.eol lf
```

更新 `.gitattributes` 后运行 `./normalize-line-endings.sh` 规范化现有文件。详见 [.github/LINE_ENDINGS.md](.github/LINE_ENDINGS.md)。

