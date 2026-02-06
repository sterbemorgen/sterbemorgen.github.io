#!/bin/bash

# GitHub Pages部署检查脚本
# 用于诊断和验证Hugo网站的GitHub Pages部署配置

echo "================================"
echo "GitHub Pages 部署检查工具"
echo "================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查函数
check_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# 1. 检查必需文件
echo "检查必需文件..."
if [ -f "hugo.yml" ] || [ -f "hugo.yaml" ] || [ -f "config.toml" ]; then
    check_pass "Hugo配置文件存在"
else
    check_fail "未找到Hugo配置文件"
fi

if [ -f ".github/workflows/deploy-pages.yml" ]; then
    check_pass "GitHub Actions workflow文件存在"
else
    check_fail "未找到GitHub Actions workflow文件"
fi

if [ -d "content" ]; then
    check_pass "content目录存在"
else
    check_fail "未找到content目录"
fi

if [ -d "themes/PaperMod" ]; then
    if [ "$(ls -A themes/PaperMod)" ]; then
        check_pass "PaperMod主题目录存在且不为空"
    else
        check_fail "PaperMod主题目录为空"
        echo "  提示: 运行 'git submodule update --init --recursive'"
    fi
else
    check_fail "未找到PaperMod主题"
fi

echo ""

# 2. 检查.gitignore
echo "检查.gitignore配置..."
if [ -f ".gitignore" ]; then
    if grep -q "public/" .gitignore; then
        check_pass "public/目录在.gitignore中"
    else
        check_warn "public/目录不在.gitignore中（应该忽略）"
    fi
    
    if grep -q ".hugo_build.lock" .gitignore; then
        check_pass ".hugo_build.lock在.gitignore中"
    else
        check_warn ".hugo_build.lock不在.gitignore中"
    fi
else
    check_warn "未找到.gitignore文件"
fi

echo ""

# 3. 检查Git子模块
echo "检查Git子模块..."
if [ -f ".gitmodules" ]; then
    check_pass ".gitmodules文件存在"
    echo "子模块列表:"
    git submodule status | sed 's/^/  /'
else
    check_warn "未找到.gitmodules文件"
fi

echo ""

# 4. 检查baseURL
echo "检查baseURL配置..."
if [ -f "hugo.yml" ]; then
    baseurl=$(grep "^baseURL:" hugo.yml | cut -d':' -f2- | tr -d ' "' | tr -d "'")
    if [ ! -z "$baseurl" ]; then
        echo "  当前baseURL: $baseurl"
        if [[ "$baseurl" == https://sterbemorgen.github.io* ]]; then
            check_pass "baseURL配置正确"
        else
            check_warn "baseURL可能不正确"
        fi
    fi
fi

echo ""

# 5. 统计内容
echo "内容统计..."
post_count=$(find content -name "*.md" -type f | grep -v "_index.md" | wc -l)
echo "  文章数量: $post_count"

if [ -d "static/images" ]; then
    image_count=$(find static/images -type f | wc -l)
    echo "  图片数量: $image_count"
fi

echo ""

# 6. 检查workflow配置
echo "检查GitHub Actions workflow配置..."
if [ -f ".github/workflows/deploy-pages.yml" ]; then
    if grep -q "actions/upload-pages-artifact" .github/workflows/deploy-pages.yml; then
        check_pass "使用GitHub Pages artifact上传"
    fi
    
    if grep -q "actions/deploy-pages" .github/workflows/deploy-pages.yml; then
        check_pass "使用GitHub Pages部署action"
    fi
    
    hugo_version=$(grep "HUGO_VERSION:" .github/workflows/deploy-pages.yml | cut -d':' -f2 | tr -d ' ')
    if [ ! -z "$hugo_version" ]; then
        echo "  Hugo版本: $hugo_version"
    fi
fi

echo ""

# 7. 建议
echo "================================"
echo "下一步操作建议:"
echo "================================"
echo ""
echo "1. 确保GitHub仓库Settings中:"
echo "   - Pages设置为'GitHub Actions'"
echo "   - Actions有'Read and write permissions'"
echo ""
echo "2. 如果主题目录为空，运行:"
echo "   git submodule update --init --recursive"
echo ""
echo "3. 提交并推送更改:"
echo "   git add ."
echo "   git commit -m \"Update site configuration\""
echo "   git push origin main"
echo ""
echo "4. 检查GitHub Actions运行状态:"
echo "   https://github.com/sterbemorgen/sterbemorgen.github.io/actions"
echo ""
echo "5. 访问网站:"
echo "   https://sterbemorgen.github.io/"
echo ""
