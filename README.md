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

## 相关目录

- `slides/` 幻灯片源码与静态资源
- `slides/coding-agents-intro/main/` 主题入口与各分节 Markdown
- `slides/coding-agents-intro/public/` 公开静态资源（如 GIF）

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
