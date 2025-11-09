# 编码代理完全指南

> 最大化利用 AI 编码代理提升工作效率的教程、演讲和幻灯片

## 项目简介

本项目旨在提供全面的教程、演讲材料和幻灯片，帮助开发者和非技术人员最大化利用各种编码代理（Coding Agents）来提高日常工作效率。

## 支持的编码代理

本项目涵盖以下主流编码代理工具：

- **Claude Code** - Anthropic 的命令行 AI 编程助手
- **GitHub Copilot** - GitHub 的 AI 代码补全工具
- **Cline** - 自主编码代理
- **Codex** - OpenAI 的代码生成模型
- 以及其他新兴的 AI 编码工具

## 项目结构

```
coding-agent-for-everything/
├── tutorials/          # 详细教程文档
├── slides/            # 演讲幻灯片
├── talks/             # 演讲材料和脚本
├── examples/          # 示例代码和实践案例
├── resources/         # 额外资源和参考材料
└── README.md          # 项目说明文档
```

## 开发与运行

- 语言栈：Python 与 TypeScript/JavaScript。
- Python 环境由 Pixi 管理，请使用 `pixi run` 执行所有 Python 脚本，避免使用系统 `python`。
- 示例：
  - `pixi run python -c "print('hello')"`
  - `pixi run python -m code_them_all`（如项目内提供相应入口）
- TypeScript/JavaScript 相关内容请按各子目录的 README 说明运行。

### 目录约定

- `src/` 仅用于 Python 包源码（例如 `src/code_them_all`）；TS/JS（含 Slidev）不得使用该目录。
- 根目录用于集中清单与脚本（如 `pyproject.toml`、`package.json`、`pixi.lock`），避免在根放置幻灯片源码与构建产物。
- 幻灯片源码与资产放在 `slides/` 下；构建产物建议输出到 `slides/<topic>/dist` 或集中到 `slides/dist`。

### Slidev 幻灯片组织（多 deck）

- 采用“每个主题一个子目录 + 该主题内多入口 Markdown（Option 1）”的方式组织。
- 推荐布局（占位名示例）：
  ```
  slides/
    <topic-a>/
      main/
        index.md        # 聚合入口（通过 src 引入各分节）
        intro.md
        advanced.md
      components/
      public/
      dist/
    <topic-b>/
      main/
        index.md
        overview.md
        deep-dive.md
      components/
      public/
      dist/
  ```
- 预览与构建（Node ≥ 18）：
  - 预览（推荐聚合入口）：`npx slidev slides/<topic-a>/main/index.md`
  - 预览（仓库示例）：`npm run slides:dev:intro`
  - 构建该主题全部入口：`npx slidev build 'slides/<topic-a>/main/*.md' --out slides/<topic-a>/dist`
- 详见：`context/hints/slidev-kb/howto-organize-multiple-decks-in-slidev.md`

### 预览 Slidev 幻灯片（快速上手）

1) 安装依赖（首次执行）：`npm install`
2) 预览示例主题：`npm run slides:dev:intro`
3) 打开浏览器访问：`http://localhost:3030/`（或终端提示的链接）。
   - 常用快捷键：`o` 打开、`r` 重启、`q` 退出；演讲者视图：`/presenter`。

## 内容范围

### 软件开发场景
- 代码生成与自动补全
- 代码审查与重构
- 测试用例编写
- 文档生成
- Bug 修复
- 性能优化

### 非开发场景
- 数据分析与处理
- 脚本自动化
- 文档编写与整理
- 工作流优化
- 学习新技术

## 目标受众

- 软件工程师
- 产品经理
- 数据分析师
- 技术写作者
- 希望提高工作效率的任何人

## 参与贡献

欢迎贡献教程、案例研究、最佳实践和使用技巧！

## 语言说明

本项目主要使用**中文**编写所有文档、教程和幻灯片，面向中文用户群体。

## 许可证

待定

## 联系方式

如有问题或建议，请提交 Issue 或 Pull Request。
