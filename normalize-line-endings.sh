#!/bin/bash
# normalize-line-endings.sh
# 规范化仓库中所有文件的行尾符
# 在更新 .gitattributes 后运行此脚本

set -e

echo "🔧 规范化 Git 行尾符..."
echo ""

# 保存当前更改
echo "📦 检查工作区状态..."
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  工作区有未提交的更改"
    echo "请先提交或暂存更改，然后再运行此脚本"
    exit 1
fi

# 移除所有文件的缓存
echo "🗑️  清除 Git 缓存..."
git rm --cached -r . > /dev/null 2>&1 || true

# 重新规范化并添加所有文件
echo "✨ 重新规范化行尾符..."
git add --renormalize .

# 显示变更
echo ""
echo "📊 行尾符变更统计:"
changed_files=$(git diff --cached --numstat | wc -l)
if [ "$changed_files" -gt 0 ]; then
    echo "   $changed_files 个文件的行尾符已更新"
    echo ""
    echo "前 10 个受影响的文件:"
    git diff --cached --name-only | head -10
    if [ "$changed_files" -gt 10 ]; then
        echo "   ..."
        echo "   (还有 $((changed_files - 10)) 个文件)"
    fi
else
    echo "   ✅ 无需更改，所有文件行尾符已正确"
fi

echo ""
echo "✅ 完成！"
echo ""
echo "下一步:"
echo "  1. 查看变更: git diff --cached"
echo "  2. 提交变更: git commit -m 'chore: 规范化行尾符'"
echo "  3. 或者取消: git reset"
