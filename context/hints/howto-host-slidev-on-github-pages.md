# How to Host Slidev Slides on GitHub Pages

本指南说明如何将 Slidev 幻灯片部署到 GitHub Pages，包括构建配置、GitHub Actions 自动部署和故障排查。

## 前置要求

- Slidev 项目已初始化
- GitHub 仓库（公开或私有均可）
- 基础 Git 和 GitHub Actions 知识

## 部署步骤

### 1. 构建 Slidev 项目为静态 SPA

Slidev 可构建为单页应用（SPA）用于静态托管：

```bash
# 基本构建命令
slidev build

# 指定输出目录
slidev build --out dist

# 设置基础路径（用于子路径部署）
slidev build --base /my-slides/
```

构建产物默认生成在 `dist/` 目录。

**来源**: [Slidev 官方文档 - Building](https://sli.dev/guide/hosting)

### 2. 配置 GitHub Pages 基础路径

**重要**: GitHub Pages 项目站点的 URL 格式为 `https://<username>.github.io/<repository-name>/`，因此需要设置正确的 `base` 路径。

#### 方法 A: 在构建命令中指定

```bash
# 手动指定仓库名
slidev build --base /your-repo-name/
```

#### 方法 B: 在 package.json 中配置

```json
{
  "scripts": {
    "dev": "slidev --open",
    "build": "slidev build --base /your-repo-name/",
    "export": "slidev export"
  }
}
```

**来源**: [Slidev 官方文档 - Custom Base Path](https://sli.dev/guide/hosting)

### 3. 使用 GitHub Actions 自动部署

#### 3.1 设置仓库权限

1. 进入 GitHub 仓库 **Settings** → **Actions** → **General**
2. 滚动到页面底部 **Workflow permissions** 区域
3. 选择 **Read and write permissions**
4. 点击 **Save**

**来源**: [Medium 教程](https://medium.com/@imanmalekian31/how-to-deploy-slidev-project-on-github-pages-65d83ef8e1f1)

#### 3.2 创建 GitHub Actions 工作流

在项目根目录创建 `.github/workflows/deploy.yml`：

```yaml
name: Deploy pages

on:
  workflow_dispatch:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 'lts/*'

      - name: Setup @antfu/ni
        run: npm i -g @antfu/ni

      - name: Install dependencies
        run: nci

      - name: Build
        run: nr build --base /${{github.event.repository.name}}/

      - name: Setup Pages
        uses: actions/configure-pages@v4

      - uses: actions/upload-pages-artifact@v3
        with:
          path: dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    needs: build
    runs-on: ubuntu-latest
    name: Deploy
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**关键点说明**:
- `${{github.event.repository.name}}` 自动获取仓库名作为 base 路径
- 使用 `@antfu/ni` 实现跨包管理器兼容（`nci` = `npm ci` / `pnpm install` / `yarn install`）
- `pages: write` 权限必需
- `dist` 目录将被上传并部署

**来源**: [Slidev 官方文档 - GitHub Pages Deployment](https://sli.dev/guide/hosting)

#### 3.3 简化版工作流（不使用 ni）

如果只使用 npm，可简化为：

```yaml
name: Deploy pages

on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build
        run: npm run build -- --base /${{github.event.repository.name}}/
      
      - name: Setup Pages
        uses: actions/configure-pages@v4
      
      - uses: actions/upload-pages-artifact@v3
        with:
          path: dist

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 4. 启用 GitHub Pages

1. 推送 `.github/workflows/deploy.yml` 到仓库
2. 前往 **Settings** → **Pages**
3. **Source** 选择 **GitHub Actions**（新版界面会自动识别）
4. 工作流将自动运行并部署

等待 Actions 构建完成后，访问：`https://<username>.github.io/<repository-name>/`

**来源**: [Medium 教程 - Enable GitHub Pages](https://medium.com/@imanmalekian31/how-to-deploy-slidev-project-on-github-pages-65d83ef8e1f1)

## 多幻灯片部署

如果项目包含多个幻灯片文件（如本项目结构 `slides/<topic>/main/*.md`）：

### 方案 A: 构建所有幻灯片到统一 dist

```bash
# 构建所有 Markdown 文件
npx slidev build 'slides/*/main/*.md' --out dist
```

### 方案 B: 分别构建子目录

```bash
# 为每个主题构建到独立目录
npx slidev build 'slides/topic1/main/*.md' --out dist/topic1
npx slidev build 'slides/topic2/main/*.md' --out dist/topic2
```

在 GitHub Actions 中：

```yaml
- name: Build
  run: |
    npx slidev build 'slides/coding-agents-intro/main/*.md' --out dist/coding-agents-intro --base /${{github.event.repository.name}}/coding-agents-intro/
```

**来源**: [Slidev 官方文档 - Multiple Exports](https://sli.dev/guide/hosting)

## 其他静态托管平台

### Netlify

创建 `netlify.toml`：

```toml
[build]
publish = 'dist'
command = 'npm run build'

[build.environment]
NODE_VERSION = '20'

[[redirects]]
from = '/*'
to = '/index.html'
status = 200
```

**来源**: [Slidev 官方文档 - Netlify](https://sli.dev/guide/hosting)

### Vercel

创建 `vercel.json`：

```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

**来源**: [Slidev 官方文档 - Vercel](https://sli.dev/guide/hosting)

## 编程式构建（TypeScript）

```typescript
import { build } from '@slidev/cli'
import { resolveOptions } from '@slidev/cli'

async function buildPresentation() {
  const options = await resolveOptions({
    entry: './slides.md',
    theme: 'seriph',
  }, 'build')

  await build(
    options,
    {
      // Vite 构建配置
      build: {
        outDir: 'dist',
      },
    },
    {
      // 构建参数
      base: '/slides/',
      download: false,
      ogImage: true,
    }
  )

  console.log('构建完成！')
}

buildPresentation().catch(console.error)
```

**来源**: [Context7 - Slidev Programmatic Build](https://context7.com/slidevjs/slidev)

## 故障排查

### 问题 1: 样式丢失或资源 404

**原因**: base 路径配置错误。

**解决方案**:
- 确保 `--base` 参数以 `/` 开头和结尾：`--base /repo-name/`
- 检查 GitHub 仓库名是否与 base 路径匹配
- 查看浏览器控制台网络请求，确认资源路径正确

### 问题 2: 图片路径问题

**相对路径在 Markdown 中**:

```markdown
# ✅ 正确：相对路径在 Markdown 正文中
![alt](./image.png)

# ❌ 错误：frontmatter 中相对路径在构建后失效
---
background: "./image.png"
---

# ✅ 正确：使用 public 目录
---
background: /image.png
---
```

图片应放在 `public/` 目录或使用相对路径在 Markdown 内容中。

**来源**: [Slidev 官方文档 - Relative Path Assets](https://sli.dev/guide/faq)

### 问题 3: GitHub Actions 权限错误

**错误信息**: `Error: Resource not accessible by integration`

**解决方案**:
1. 检查工作流文件中 `permissions` 配置是否包含 `pages: write`
2. 确认仓库 Settings → Actions → Workflow permissions 设置为 **Read and write**

### 问题 4: 部署后页面空白

**可能原因**:
- Base 路径配置错误
- 资源加载失败
- SPA 路由问题

**调试步骤**:
1. 打开浏览器开发者工具查看控制台错误
2. 检查 Network 标签确认资源加载路径
3. 验证 `dist/index.html` 中的资源引用路径

## 额外功能：PDF 下载

在构建时生成 PDF 并提供下载按钮：

```bash
slidev build --download
```

或在 frontmatter 中配置：

```yaml
---
download: true
---
```

**来源**: [Slidev 官方文档 - PDF Download](https://sli.dev/features/build-with-pdf)

## 相关资源

- [Slidev 官方托管文档](https://sli.dev/guide/hosting)
- [GitHub Actions 文档](https://docs.github.com/actions)
- [GitHub Pages 文档](https://docs.github.com/pages)
- [Vite 静态资源处理](https://vitejs.dev/guide/assets.html)
- [Medium 教程：Deploy Slidev on GitHub Pages](https://medium.com/@imanmalekian31/how-to-deploy-slidev-project-on-github-pages-65d83ef8e1f1)
