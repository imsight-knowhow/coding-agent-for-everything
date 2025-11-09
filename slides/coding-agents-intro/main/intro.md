# 简介：编码代理发展脉络

- **Chatbot（你问我答）**：仅 Prompt/Response，对话里产出代码，需人工复制粘贴进工程。
- **GitHub Copilot（你一行我一行）**：IDE 内联补全，把"复制粘贴"缩短为"就地补齐"。
- **Cursor （你一行我一段）**：多行/乱序补全与任务式对话，引入 Composer 做跨文件改动。
- **Cline （你一句我做完）**：全代理化、以提示为中心、多文件编辑、命令执行。
- **Claude Code （万能乙方）**：接管 CLI 与文件编辑，接受复杂的需求，像乙方一样一次做完整个工程。
- **Codex CLI （金牌乙方）**：OpenAI 的对应方案，模型擅长算法理解，奥赛金牌选手。

<br/>

```mermaid
%%{init: {'theme':'base', 'themeVariables': {'fontSize':'24px'}}}%%
graph LR
    A["<b>Chatbot</b><br/>2022<br/>对话式代码辅助"] --> B["<b>GitHub Copilot</b><br/>2021-2022<br/>IDE内联补全"]
    B --> C["<b>Cursor</b><br/>2023<br/>AI IDE + 项目级别的上下文"]
    C --> D["<b>Cline</b><br/>2024-2025<br/>自主代理"]
    D --> E["<b>终端编码代理</b><br/>2024-2025<br/>CLI + 文件 + 沙箱"]
    E --> F["<b>Claude Code</b><br/>Anthropic"]
    E --> G["<b>Codex CLI</b><br/>OpenAI"]

    style A fill:#e1f5ff
    style B fill:#b3e5fc
    style C fill:#81d4fa
    style D fill:#4fc3f7
    style E fill:#29b6f6
    style F fill:#03a9f4
    style G fill:#03a9f4
```
