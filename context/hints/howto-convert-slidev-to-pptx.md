# How to Convert Slidev Slides to PPTX

本指南说明如何将 Slidev 幻灯片导出为 PowerPoint PPTX 格式，包括使用官方 CLI 和第三方工具。

## 官方方法：Slidev CLI（推荐）

Slidev 从 v0.50.0-beta.11 开始官方支持导出 PPTX 格式。

### 前置要求

安装 Playwright Chromium 依赖（用于渲染幻灯片）：

```bash
pnpm add -D playwright-chromium
# 或
npm i -D playwright-chromium
# 或
yarn add -D playwright-chromium
```

### 基本导出命令

```bash
# 导出为 PPTX
slidev export --format pptx

# 指定输出文件名
slidev export --format pptx --output my-presentation

# 导出特定幻灯片范围
slidev export --format pptx --range 1,3-5,8
```

**来源**: [Slidev 官方文档 - Exporting](https://sli.dev/guide/exporting.html)

### 浏览器导出界面（新功能）

从 v0.50.0-beta.11 开始，Slidev 提供浏览器 UI 导出：

1. 启动开发服务器：`slidev` 或 `npm run dev`
2. 访问 `http://localhost:3030/export`（端口号根据实际调整）
3. 或点击导航栏"更多选项"菜单中的"Export"按钮
4. 在界面中选择导出为 PDF、PPTX 或 PNG

**注意**: 推荐使用现代 Chromium 内核浏览器（Chrome、Edge）以获得最佳体验。

**来源**: [Slidev 官方文档 - Browser Exporter](https://sli.dev/guide/exporting.html#browser)

### 常用导出选项

```bash
# 导出时包含点击动画步骤（每步生成一页）
# 注意：PPTX 格式默认启用此选项
slidev export --format pptx --with-clicks

# 禁用点击动画分步
slidev export --format pptx --with-clicks false

# 深色模式导出
slidev export --format pptx --dark

# 增加渲染超时（大型演示文稿）
slidev export --format pptx --timeout 60000

# 添加延迟等待内容加载（单位：毫秒）
slidev export --format pptx --wait 1000
```

**来源**: [Slidev 官方文档 - Export Options](https://sli.dev/guide/exporting.html#options)

### 配置文件中设置导出文件名

在 `slides.md` 头部添加：

```yaml
---
exportFilename: my-presentation
---
```

**来源**: [Slidev 文档 - Export Filename](https://sli.dev/guide/exporting.html#output-filename)

### 编程式导出（TypeScript）

```typescript
import { exportSlides } from '@slidev/cli'

async function exportToPPTX() {
  await exportSlides({
    total: 15,           // 幻灯片总数
    slides: [],          // SlideInfo 对象数组
    format: 'pptx',      // 导出格式
    output: 'slides.pptx', // 输出文件路径
    withClicks: true,    // 包含点击动画
    dark: false,         // 深色模式
    timeout: 30000,      // 超时时间（毫秒）
  })
  console.log('导出完成！')
}
```

**来源**: [Context7 - Slidev Programmatic Export](https://context7.com/slidevjs/slidev)

## PPTX 导出特性与限制

### 已支持特性
- ✅ 每个幻灯片导出为图片页面
- ✅ 演讲者备注自动包含在 PPTX 中
- ✅ 支持自定义尺寸和缩放
- ✅ 支持深色主题导出

### 限制
- ❌ 文本不可选择（幻灯片以图片形式导出）
- ❌ 动画和交互功能不保留
- ❌ 无法编辑导出后的内容元素

如需保持交互性，建议构建为 Web 应用并托管在线。

**来源**: [Slidev 官方文档 - PPTX Format](https://sli.dev/guide/exporting.html#pptx)

## 替代方案：slidev2pptx（已归档）

> **注意**: 该项目已归档，因为 Slidev 官方已支持 PPTX 导出。仅供参考。

### 安装与使用

```bash
# 安装
pip install slidev2pptx

# 命令行使用
slidev2pptx -i ./slidev/ -o ./output.pptx -s 2

# Python API
from slidev2pptx import slidev2pptx

slidev2pptx(
    slidev_path="./slidev/",
    output_path="./output.pptx",
    scale=2  # 图片导出缩放比例
)
```

**前置条件**: Slidev 项目需支持导出 PNG（参见 [Slidev 导出文档](https://sli.dev/guide/exporting)）。

**版本要求**: 需要 Slidev >= 0.47.4（依赖 `--scale` 参数）。

**来源**: [GitHub - slidev2pptx](https://github.com/zhangyu94/slidev2pptx)

## 故障排查

### 内容缺失或动画未完成

添加等待时间：

```bash
slidev export --format pptx --wait 1000
```

或调整等待策略：

```bash
# 不等待任何事件（最快但可能不完整）
slidev export --format pptx --wait-until none

# 等待 DOM 加载完成
slidev export --format pptx --wait-until domcontentloaded
```

### Emoji 显示异常

Linux 环境（如容器/CI）可能缺少 Emoji 字体，安装 Noto Emoji：

```bash
curl -L --output NotoColorEmoji.ttf https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf
sudo mv NotoColorEmoji.ttf /usr/local/share/fonts/
fc-cache -fv
```

**来源**: [Slidev 文档 - Troubleshooting](https://sli.dev/guide/exporting.html#troubleshooting)

### 使用自定义浏览器

Chromium 可能缺少视频解码器，可指定 Chrome/Edge 路径：

```bash
slidev export --format pptx --executable-path /path/to/chrome
```

## 相关资源

- [Slidev 官方导出文档](https://sli.dev/guide/exporting.html)
- [Slidev CLI 参考](https://sli.dev/builtin/cli.html#export)
- [Playwright 文档](https://playwright.dev/docs/intro)
- [slidev2pptx（已归档）](https://github.com/zhangyu94/slidev2pptx)
