# Roles 目录

## 用途

包含基于角色的系统提示词、记忆和不同 AI 助手角色的上下文。每个角色都有自己的子目录，包含该特定角色或领域专业知识的专门提示词和累积知识。

## 内容类型

- 角色特定的系统提示词
- 角色记忆和上下文
- 领域专业知识文档
- 角色特定的最佳实践

## 目录结构

每个角色一个子目录：
```
roles/
├── backend-developer/
│   ├── system-prompt.md
│   ├── memory.md
│   └── knowledge-base.md
├── frontend-specialist/
│   ├── system-prompt.md
│   └── context.md
└── devops-engineer/
    ├── system-prompt.md
    └── knowledge-base.md
```

## 命名规范

- 使用描述性角色名称作为目录名
- 每个角色目录包含：
  - `system-prompt.md` - 角色系统提示词
  - `memory.md` - 角色记忆和历史
  - `knowledge-base.md` - 角色特定知识

## 示例

```markdown
# 后端开发者系统提示词

## HEADER
- **Purpose**: 定义后端开发 AI 助手的角色和能力
- **Status**: Active
- **Date**: 2025-01-15
- **Dependencies**: 无
- **Target**: AI 助手角色配置
```
