# 新范式 · 规范驱动的 AI 开发

从“写代码”转向“定义任务”的编程方式：先达成规范，再让 AI 写码。

### SpecKit（GitHub 开源）


- 先讲清楚“要做什么”，再让 AI 按清单写代码。
- 会产出 4 个文件：项目规则（constitution.md）、需求说明（spec.md）、实现方案（plan.md）、任务清单（tasks.md）。
- 常用命令：`/speckit.specify`、`/speckit.plan`、`/speckit.tasks`、`/speckit.implement`

<br/>
```mermaid {scale: 0.9}
%%{init: {'theme':'base', 'themeVariables': {'fontSize':'16px'}, 'flowchart': {'rankSpacing': 20, 'nodeSpacing': 20}} }%%
graph LR
  A[Specify 需求] --> B[Plan 方案]
  B --> C[Tasks 任务]
  C --> D[Implement 实施]
  
  subgraph 工件 Artifacts
    direction LR
    E[constitution.md] --> F[spec.md] --> G[plan.md] --> H[tasks.md]
  end

  A -.-> E
  B -.-> F
  C -.-> G
  D -.-> H

  classDef art fill:#eef7e9,stroke:#99c27c
  class E,F,G,H art
```


---

# 新范式 · 规范驱动的 AI 开发
从“写代码”转向“定义任务”的编程方式：先达成规范，再让 AI 写码。

### OpenSpec（Fission‑AI）

- 先写一份“改动提案”，AI 和你对齐后再动手。
- 会产出 2 个核心文件：提案 `proposal.md`、任务清单 `tasks.md`。
- 你的操作：三条命令走完一件变更。

```mermaid {scale: 0.8}
graph LR
  P[Proposal 提案/动机] --> R[Review / Tasks 评审与拆解]
  R --> A[Apply 应用改动]
  A --> X[Archive 归档]
  subgraph 工件 Artifacts
    PP[proposal.md]
    TT[tasks.md]
  end
  P -.-> PP
  R -.-> TT
  classDef k1 fill:#eaf2ff,stroke:#8bb1ff
  class PP,TT k1
```