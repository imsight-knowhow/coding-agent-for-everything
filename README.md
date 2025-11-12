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

## 目录结构

```
coding-agent-for-everything/
├── .specify/             # SpecKit 配置、脚本与模板
├── .vscode/              # VS Code 编辑器配置
├── context/              # AI 辅助开发的上下文资料库（规格、计划、角色、提示等）
├── examples/             # 可运行代码示例
├── magic-context/        # 可复用的 AI 提示模板与工具脚本
├── resources/            # 共享资源（图片、参考资料）
├── slides/               # Slidev 幻灯片源码（主题：coding-agents-intro）
├── src/                  # Python 包源码（code_them_all）
├── talks/                # 演讲稿、大纲与 Q&A
├── tutorials/            # 长篇教程文档
├── AGENTS.md             # AI 代理相关文档
├── CLAUDE.md             # Claude Code 项目开发指引
├── README.md             # 项目说明文档
├── normalize-line-endings.sh  # 行尾统一化脚本
├── setup-envs.sh         # 环境初始化脚本
├── start-slidev.sh       # Slidev 本地预览启动脚本
├── package.json          # Node.js 项目配置（Slidev 相关）
├── package-lock.json     # Node.js 依赖锁定文件
└── pyproject.toml        # Python 项目配置
```

## 跨平台与行尾规范

建议在首次克隆后执行：
```bash
git config --local core.autocrlf input
git config --local core.eol lf
```
更多细节见 `.gitattributes` 与 [.github/LINE_ENDINGS.md](.github/LINE_ENDINGS.md)