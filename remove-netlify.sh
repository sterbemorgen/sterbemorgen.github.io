#!/bin/bash

echo "🧹 开始清理 Netlify 相关文件..."

# 删除 Netlify CMS admin 目录
if [ -d "static/admin" ]; then
    echo "  ✓ 删除 static/admin/ (Netlify CMS)"
    rm -rf static/admin
fi

# 删除旧的 deploy.yml (如果存在)
if [ -f ".github/workflows/deploy.yml" ]; then
    echo "  ✓ 删除 .github/workflows/deploy.yml"
    rm .github/workflows/deploy.yml
fi

# 删除可能存在的 netlify.toml
if [ -f "netlify.toml" ]; then
    echo "  ✓ 删除 netlify.toml"
    rm netlify.toml
fi

# 清理 macOS 临时文件
echo "  ✓ 清理 macOS 临时文件"
find . -name ".DS_Store" -delete
find . -name "._*" -delete

echo ""
echo "✅ Netlify 清理完成!"
echo ""
echo "📝 下一步:"
echo "   1. git add ."
echo "   2. git commit -m 'Remove Netlify, use GitHub Pages only'"
echo "   3. git push"
echo ""
