#!/bin/bash
# 发布 ztools-api-types 到 npm 的脚本

set -e

echo "📦 准备发布 ztools-api-types 到 npm..."
echo ""

# 检查是否登录
if ! npm whoami > /dev/null 2>&1; then
  echo "❌ 错误：未登录 npm，请先运行 'npm login'"
  exit 1
fi

echo "✅ 已登录 npm，用户名: $(npm whoami)"
echo ""

# 显示当前版本
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo "📌 当前版本: $CURRENT_VERSION"
echo ""

# 确认发布
echo "⚠️  即将发布以下内容:"
npm pack --dry-run
echo ""

read -p "确认发布？(y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "❌ 已取消发布"
  exit 0
fi

# 发布
echo "🚀 正在发布..."
# 如果是组织包，使用: npm publish --access public
# 如果是个人包，使用: npm publish
npm publish --access public

echo ""
echo "✅ 发布成功！"
echo ""
echo "📝 下一步:"
echo "   1. 访问 https://www.npmjs.com/package/@ztools-center/ztools-api-types"
echo "   2. 验证包信息"
echo "   3. 在插件项目中测试安装:"
echo "      npm install @ztools-center/ztools-api-types --save-dev"
