# 演讲幻灯片

本目录包含用于技术分享和培训的演讲幻灯片。

## 计划主题

- AI 编码代理概述
- 提高开发效率的实用技巧
- 企业场景下的 AI 辅助编程
- 未来趋势与展望

## Slidev 用法（子目录工程）

- 本项目使用 Slidev（基于 Markdown + Vue）制作幻灯片。
- 结构：每个 deck 独立位于 `slides/<deck-name>/`，入口为 `slides.md`。
- 运行：
  - 在仓库根目录执行 `npm install`（或 `pnpm install / yarn`）。
  - 开发：`npm run slides:dev:intro`
  - 构建：`npm run slides:build:intro`（输出到 `dist/coding-agents-intro`）
  - 批量构建：`npm run slides:build:all`
- 如需部署在子路径（如 GitHub Pages），可在构建命令后追加 `-- --base /talks/<deck-name>/`。
