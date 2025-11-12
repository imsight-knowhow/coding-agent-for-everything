# Tasks 目录

## 用途

按状态组织跟踪工作项。提供清晰的任务管理和进度可见性。

## 子目录说明

- **working/** - 当前正在进行的活动开发任务
- **done/** - 已完成的任务，移至此处进行归档和参考
- **backlog/** - 等待优先级排序和实施的计划任务

## 内容类型

- 功能实施任务
- Bug 修复任务
- 重构任务
- 测试编写任务
- 文档更新任务

## 命名规范

按状态组织，使用清晰的描述性名称：
- `working/task-implement-user-authentication.md`
- `working/task-fix-memory-leak.md`
- `done/task-modernize-api-endpoints.md`
- `backlog/task-add-integration-tests.md`

任务文件可包括任何类型的工作：功能、修复、重构或测试。

## 工作流程

1. 新任务创建在 `backlog/` 中
2. 开始工作时移至 `working/`
3. 完成后移至 `done/` 归档

## 示例

```markdown
# 任务：实施用户认证

## HEADER
- **Purpose**: 为应用添加 JWT 认证功能
- **Status**: In Progress
- **Date**: 2025-01-15
- **Dependencies**: 数据库用户表, JWT 库
- **Target**: 后端开发者和 AI 助手

## 任务详情
[任务的详细描述和要求...]
```
