# Git Line Ending Configuration

本项目已配置 Git 以正确处理跨平台（Windows/Linux/macOS）的行尾符（line endings）。

## 配置说明

### .gitattributes 文件

项目根目录的 `.gitattributes` 文件定义了所有文件的行尾处理规则：

- **默认行为**: `* text=auto` - Git 自动检测文本文件并规范化行尾
- **文本文件**: 所有代码、配置、文档文件在仓库中统一使用 LF（Unix 风格）
- **Shell 脚本**: 强制使用 LF（`.sh`, `.bash`）- Unix 系统要求
- **Windows 脚本**: 使用 CRLF（`.bat`, `.cmd`, `.ps1`）- Windows 系统要求
- **二进制文件**: 明确标记，防止行尾转换

### Git 配置

本地仓库已设置：
```bash
core.autocrlf = input  # 提交时转换 CRLF → LF，检出时不转换
core.eol = lf          # 默认行尾为 LF
```

## 新贡献者设置

克隆仓库后，Git 会自动应用 `.gitattributes` 规则。建议额外执行：

```bash
# 确保本地配置正确
git config --local core.autocrlf input
git config --local core.eol lf

# 如果已有文件，重新规范化行尾
git add --renormalize .
```

## Windows 用户注意事项

Windows 用户在本地编辑时：
- 编辑器可能使用 CRLF，但提交到仓库时会自动转换为 LF
- 建议配置编辑器默认使用 LF（VS Code: `"files.eol": "\n"`）
- Shell 脚本（`.sh`）必须保持 LF，否则在 Linux/WSL 中无法执行

## 常见问题

**Q: 为什么 Shell 脚本在 Windows 上无法运行？**
A: Shell 脚本使用 LF 行尾，需要在 WSL、Git Bash 或 Cygwin 中运行，不能直接在 Windows CMD 执行。

**Q: 如何检查文件的行尾符？**
A: 
- VS Code: 右下角状态栏显示 "LF" 或 "CRLF"
- 命令行: `file <filename>` 或 `dos2unix -i <filename>`

**Q: 提交时出现行尾警告？**
A: 运行 `git add --renormalize .` 重新规范化所有文件。
