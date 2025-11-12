# 编码代理·主题幻灯片（Slidev）

[在线预览（GitHub Pages）](https://imsight-knowhow.github.io/coding-agent-for-everything/)

## 概要

本仓库包含主题为“编码代理（Coding Agents）”的演讲幻灯片，聚焦如何借助终端/IDE 里的智能代理提升编码与知识工作的效率。内容涵盖：

- 发展脉络：从 Chatbot → Copilot → Cursor → Cline → 终端编码代理（Codex CLI / Claude Code）
- 个人观点与 Human‑in‑the‑loop：人与代理的职责分工与反馈闭环
- 新范式：规范驱动开发（SpecKit、OpenSpec）的工作方式与产物
- 应用示例：专利写作、旅行规划、论文综述、工程任务等
- 过往项目回顾：基于代理完成的实践仓库与包

对应源码位于 `slides/coding-agents-intro/main/index.md`（通过 `src:` 聚合子页面）。

## 技术栈

- Slidev（基于 Vite + Vue 3）
- 默认主题 `@slidev/theme-default`
- Mermaid 图表（内置支持）
- Node.js ≥ 18（见 `package.json`）

## 本地运行

1) 安装依赖（首次）
```bash
npm install
```

2) 启动本地预览（任意其一）
```bash
# 使用 npm 脚本
npm run slides:dev:intro

# 或直接调用 Slidev 指定入口
npx slidev slides/coding-agents-intro/main/index.md

# 或使用脚本（支持多主题/端口参数）
./start-slidev.sh
```

3) 打开浏览器：`http://localhost:3030/`（或终端提示的端口）。

## 构建与发布

- 本地构建
```bash
npm run slides:build:intro
# 产物输出：slides/coding-agents-intro/dist
```

- GitHub Pages
  - 已配置工作流 `.github/workflows/deploy.yml`，推送到 `main` 自动发布
  - 线上地址：`https://imsight-knowhow.github.io/coding-agent-for-everything/`

## 目录结构（Depth=2）

```
coding-agent-for-everything/
├── .github/
│   ├── LINE_ENDINGS.md
│   └── workflows/
├── .pixi/
│   └── envs/
├── .specify/
│   ├── memory/
│   ├── scripts/
│   └── templates/
├── .vscode/
│   └── settings.json
├── AGENTS.md
├── CLAUDE.md
├── README.md
├── context/
│   ├── design/
│   ├── hints/
│   ├── instructions/
│   ├── plans/
│   ├── refcode/
│   ├── roles/
│   ├── summaries/
│   ├── tasks/
│   └── tools/
├── examples/
│   └── README.md
├── magic-context/
│   ├── blender-plugin/
│   ├── general/
│   ├── instructions/
│   ├── mcp-dev/
│   ├── roles/
│   ├── scripts/
│   └── speckit/
├── resources/
│   └── README.md
├── slides/
│   ├── README.md
│   └── coding-agents-intro/
├── src/
│   └── code_them_all/
├── talks/
│   └── README.md
├── tutorials/
│   └── README.md
├── normalize-line-endings.sh
├── setup-envs.sh
├── start-slidev.sh
├── package.json
├── package-lock.json
├── pixi.lock
└── pyproject.toml
```

说明：
- `slides/`：Slidev 幻灯片源码与资产；`slides/coding-agents-intro/` 为本主题，入口在 `main/index.md`。
- `.github/workflows/`：GitHub Pages 自动发布工作流（push 到 `main` 即发布）。
- `start-slidev.sh`：本地预览便捷脚本（支持多主题/端口参数）。
- `context/`：规格、提示、计划、角色等资料库，用于组织与沉淀方法论。
- `.specify/`：SpecKit 相关脚本与缓存，支撑“规范驱动开发”的流程。
- `magic-context/`：外部上下文与脚本集合（子仓库/子模块风格，用于复用）。
- `src/`：Python 包示例位置（若有 Python 代码）。
- `resources/`、`examples/`、`talks/`、`tutorials/`：资源、示例、演讲稿与教程文档。
- `package.json`：包含 Slidev 的开发/构建脚本；`pyproject.toml`、`pixi.lock` 为 Python/Pixi 清单。
- `normalize-line-endings.sh`：统一行尾脚本；跨平台规范见 `.github/LINE_ENDINGS.md`。

## 跨平台与行尾规范

建议在首次克隆后执行：
```bash
git config --local core.autocrlf input
git config --local core.eol lf
```
更多细节见 `.gitattributes` 与 [.github/LINE_ENDINGS.md](.github/LINE_ENDINGS.md)。
- 希望提高工作效率的任何人

## 参与贡献

欢迎贡献教程、案例研究、最佳实践和使用技巧！

## 语言说明

本项目主要使用**中文**编写所有文档、教程和幻灯片，面向中文用户群体。

## 许可证

待定

## 联系方式

如有问题或建议，请提交 Issue 或 Pull Request。
