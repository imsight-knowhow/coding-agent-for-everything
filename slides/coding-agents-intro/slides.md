---
title: 编码代理与 Slidev 简介
infos: 中文向幻灯片示例（Slidev 子目录结构）
favicon: https://sli.dev/logo-square.png
colorSchema: auto
layout: cover
---

# 编码代理与 Slidev 简介

使用 Markdown + Vue 组件，快速制作高质量中文幻灯片。

---

## 项目结构（子目录组织）

```text
slides/
  coding-agents-intro/
    slides.md
    components/
    layouts/
    public/
    setup/
    styles/
    vite.config.ts
```

- 每个 deck 独立放在 `slides/<deck-name>/`，互不干扰
- 资源放在该 deck 的 `public/` 或相对路径引用
- 构建产物输出至根目录 `dist/`

---

## 本地开发

在仓库根目录执行（需要 Node ≥ 18）：

```bash
npm install  # 或 pnpm install / yarn
npm run slides:dev:intro
```

打开浏览器后即可热更新预览。

---

## 构建与部署

构建当前 deck：

```bash
npm run slides:build:intro
```

一次性构建所有 deck：

```bash
npm run slides:build:all
```

如需在子路径（如 GitHub Pages）部署，请在命令后追加 `-- --base /talks/coding-agents-intro/`。

---

## 小贴士

- 直接在 Markdown 中插入代码、图表、组件
- 复杂 deck 可在本目录添加 `vite.config.ts` 定制别名/插件
- 参考 Slidev 官方文档 https://sli.dev （中文也可流畅使用）

---

## 结束

祝使用顺利，愉快分享！

