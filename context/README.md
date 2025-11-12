# Context 目录说明

这是项目的 AI 辅助开发上下文目录，用于存储项目知识库、开发历史和参考资料。

## 目录结构

```
context/
├── design/          # 技术规范和架构设计
├── hints/           # 操作指南和故障排查技巧
├── instructions/    # 可复用的提示词片段和命令模板
├── logs/            # 开发会话记录和结果
├── plans/           # 实施路线图和策略
├── refcode/         # 参考实现和示例代码
├── roles/           # 基于角色的系统提示词和记忆
├── summaries/       # 知识库和分析文档
├── tasks/           # 当前和计划中的工作项
│   ├── working/     # 正在进行的任务
│   ├── done/        # 已完成的任务（归档）
│   └── backlog/     # 计划中但尚未开始的任务
└── tools/           # 自定义开发工具
```

## 使用说明

每个子目录都包含特定类型的文档和资料。详细说明请参阅各子目录中的 README.md 文件。

## 文档格式规范

每个上下文文档都应包含以下 HEADER 部分：

```markdown
# 文档标题

## HEADER
- **Purpose**: 文档目的
- **Status**: 当前状态（active/completed/deprecated/failed）
- **Date**: 创建或最后更新日期
- **Dependencies**: 相关依赖或需求
- **Target**: 目标受众（AI 助手、开发者等）

## 内容
[主要文档内容...]
```

## 命名规范

- **Logs**: 使用日期前缀和描述性结果，如 `YYYY-MM-DD_feature-name-implementation-success.md`
- **Hints**: 使用面向操作的前缀，如 `howto-setup-development-environment.md`
- **Tasks**: 按状态组织，使用清晰的描述性名称，如 `task-implement-user-authentication.md`

更多详细信息请参阅 `../magic-context/instructions/dir-setup/make-context-dir.md`
