#!/bin/bash

echo "════════════════════════════════════════════════════════"
echo "  🚀 从 Netlify 迁移到 GitHub Pages - 快速操作指南"
echo "════════════════════════════════════════════════════════"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

step=1

print_step() {
    echo -e "${BLUE}步骤 $step:${NC} $1"
    ((step++))
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# ============= 步骤 1: 清理 Netlify 文件 =============
print_step "清理 Netlify 相关文件"

if [ -d "static/admin" ]; then
    rm -rf static/admin
    print_success "删除 static/admin/ (Netlify CMS)"
else
    print_warning "static/admin/ 目录不存在，跳过"
fi

if [ -f ".github/workflows/gh-pages.yml" ]; then
    rm .github/workflows/gh-pages.yml
    print_success "删除旧的 .github/workflows/gh-pages.yml"
else
    print_warning "gh-pages.yml 不存在，跳过"
fi

if [ -f ".github/workflows/deploy.yml" ]; then
    rm .github/workflows/deploy.yml
    print_success "删除 .github/workflows/deploy.yml"
else
    print_warning "deploy.yml 不存在，跳过"
fi

if [ -f "netlify.toml" ]; then
    rm netlify.toml
    print_success "删除 netlify.toml"
else
    print_warning "netlify.toml 不存在，跳过"
fi

# 清理 macOS 临时文件
find . -name ".DS_Store" -delete 2>/dev/null
find . -name "._*" -delete 2>/dev/null
print_success "清理 macOS 临时文件"

echo ""

# ============= 步骤 2: 创建新的 workflow =============
print_step "创建新的 GitHub Pages workflow"

mkdir -p .github/workflows

cat > .github/workflows/deploy-pages.yml << 'EOF'
name: Deploy Hugo site to GitHub Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.142.0
    steps:
      - name: 📥 Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0
          submodules: recursive

      - name: 🔧 Git Configuration
        run: |
          git config --global core.quotePath false
          git config --global core.autocrlf false
          git config --global core.safecrlf true
          git config --global core.ignorecase false

      - name: 🛠️ Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: ${{ env.HUGO_VERSION }}
          extended: true

      - name: 🏗️ Build with Hugo
        run: |
          hugo \
            --gc \
            --minify \
            --baseURL "https://sterbemorgen.github.io/"

      - name: 📤 Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: 🚀 Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF

print_success "创建 .github/workflows/deploy-pages.yml"

echo ""

# ============= 步骤 3: 显示 Git 状态 =============
print_step "检查更改"

echo "已更改的文件:"
git status --short

echo ""

# ============= 步骤 4: 下一步操作 =============
print_step "下一步操作"

echo "请按照以下步骤完成迁移:"
echo ""
echo "1️⃣  在 GitHub 上配置 Pages:"
echo "   → 进入仓库: https://github.com/sterbemorgen/sterbemorgen.github.io"
echo "   → 点击 Settings → Pages"
echo "   → Source 选择: ${YELLOW}GitHub Actions${NC}"
echo ""
echo "2️⃣  配置仓库权限:"
echo "   → Settings → Actions → General"
echo "   → Workflow permissions: 选择 ${YELLOW}Read and write permissions${NC}"
echo "   → 勾选 ${YELLOW}Allow GitHub Actions to create and approve pull requests${NC}"
echo "   → 点击 Save"
echo ""
echo "3️⃣  提交并推送更改:"
echo "   ${GREEN}git add .${NC}"
echo "   ${GREEN}git commit -m 'Migrate from Netlify to GitHub Pages'${NC}"
echo "   ${GREEN}git push origin main${NC}"
echo ""
echo "4️⃣  等待部署完成:"
echo "   → 访问 Actions 标签查看部署进度"
echo "   → 通常需要 1-2 分钟"
echo "   → 完成后访问: https://sterbemorgen.github.io/"
echo ""

# ============= 步骤 5: 提示 =============
print_step "重要提示"

echo "• 删除旧的 Netlify 仓库配置后,此项目将完全由 GitHub 管理"
echo "• 所有内容管理现在通过 Git 进行,不再使用 Netlify CMS"
echo "• 创建新文章: ${GREEN}hugo new content/posts/article-name.md${NC}"
echo "• 本地预览: ${GREEN}hugo server -D${NC}"
echo "• 详细文档请查看: GITHUB_PAGES_MIGRATION.md"
echo ""

echo "════════════════════════════════════════════════════════"
echo "  ✅ 准备工作完成!"
echo "════════════════════════════════════════════════════════"
