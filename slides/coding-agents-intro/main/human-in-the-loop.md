# 人在回路（Human-in-the-loop）

关注任务定义与结果校验，降低幻觉与偏差。

```mermaid {scale: 0.7}
%%{init: {'theme':'base', 'themeVariables': {'fontSize':'20px'}}}%%
graph LR
    Human["<b>👤 人类开发者</b><br/>定义需求<br/>验证结果"]
    Spec["<b>📋 软件规格</b><br/>需求文档<br/>技术标准"]
    Agent["<b>🤖 AI 编码代理</b><br/>理解任务<br/>生成代码<br/>执行操作"]
    System["<b>💻 计算机系统</b><br/>代码库<br/>开发环境<br/>测试运行"]

    Human -->|"1. 定义任务"| Agent
    Spec -.->|"参考标准"| Agent
    Agent -->|"2. 读取/分析"| System
    System -->|"3. 状态反馈"| Agent
    Agent -->|"4. 修改/执行"| System
    Agent -->|"5. 提交结果"| Human
    Human -->|"6. 校验/反馈"| Agent
    Human -.->|"更新规格"| Spec

    style Human fill:#e3f2fd
    style Agent fill:#fff3e0
    style System fill:#f3e5f5
    style Spec fill:#e8f5e9

    classDef loopStyle stroke:#ff6b6b,stroke-width:2px
    class Human,Agent loopStyle
```

<div class="h-7"></div>

### 人类在回路中的作用：
<div class="h-3"></div>

- **任务定义**：明确任务目标、输入输出要求和成功标准。
- **结果校验**：审查 AI 生成的代码，确保其符合预期并无误。
- **反馈循环**：提供反馈以改进 AI 代理的性能和准确性。
