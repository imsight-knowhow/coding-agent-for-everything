# Tools 目录

## 用途

存放项目工作流特定的自定义脚本、实用程序和开发辅助工具。

## 内容类型

- 自动化脚本
- 构建工具
- 测试辅助工具
- 代码生成器
- 部署脚本
- 开发环境配置脚本

## 文件组织

可以按功能或用途组织：
```
tools/
├── build/
│   └── optimize-bundle.sh
├── deployment/
│   └── deploy-staging.sh
├── testing/
│   └── run-integration-tests.sh
└── codegen/
    └── generate-api-client.js
```

## 命名规范

使用描述性名称，清楚说明工具用途：
- `deploy-to-production.sh`
- `generate-types.js`
- `run-security-scan.py`
- `setup-local-db.sh`

## 文档要求

每个工具应包含：
- 用途说明
- 使用方法
- 依赖要求
- 示例用法

## 示例

```markdown
# 数据库迁移工具

## HEADER
- **Purpose**: 自动执行数据库架构迁移
- **Status**: Active
- **Date**: 2025-01-15
- **Dependencies**: PostgreSQL, Node.js
- **Target**: 开发者和 CI/CD 流水线

## 使用方法
```bash
./tools/db-migrate.sh up
```
