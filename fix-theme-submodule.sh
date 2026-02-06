#!/bin/bash

# 修复PaperMod主题子模块的脚本

echo "================================"
echo "修复PaperMod主题子模块"
echo "================================"
echo ""

# 检查是否在git仓库中
if [ ! -d ".git" ]; then
    echo "错误: 不在git仓库中"
    echo "请确保在项目根目录运行此脚本"
    exit 1
fi

# 1. 如果.gitmodules不存在，创建它
if [ ! -f ".gitmodules" ]; then
    echo "创建.gitmodules文件..."
    cat > .gitmodules << 'GITMODULES'
[submodule "themes/PaperMod"]
	path = themes/PaperMod
	url = https://github.com/adityatelange/hugo-PaperMod.git
GITMODULES
    echo "✓ .gitmodules文件已创建"
else
    echo "✓ .gitmodules文件已存在"
fi

# 2. 如果themes/PaperMod目录为空或不存在，初始化子模块
if [ ! -d "themes/PaperMod" ] || [ -z "$(ls -A themes/PaperMod 2>/dev/null)" ]; then
    echo ""
    echo "初始化PaperMod主题子模块..."
    
    # 确保themes目录存在
    mkdir -p themes
    
    # 如果目录存在但为空，先删除
    if [ -d "themes/PaperMod" ]; then
        rm -rf themes/PaperMod
    fi
    
    # 添加子模块
    git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
    
    if [ $? -eq 0 ]; then
        echo "✓ PaperMod主题子模块添加成功"
    else
        echo "✗ 添加子模块失败"
        exit 1
    fi
else
    echo "✓ PaperMod主题目录已存在且不为空"
    echo ""
    echo "更新主题到最新版本..."
    git submodule update --init --recursive --remote
fi

echo ""
echo "================================"
echo "验证主题安装"
echo "================================"
echo ""

# 验证关键文件
if [ -f "themes/PaperMod/layouts/index.html" ]; then
    echo "✓ 主题布局文件存在"
else
    echo "✗ 主题布局文件缺失"
    exit 1
fi

if [ -d "themes/PaperMod/assets" ]; then
    echo "✓ 主题资源目录存在"
else
    echo "✗ 主题资源目录缺失"
    exit 1
fi

echo ""
echo "================================"
echo "完成!"
echo "================================"
echo ""
echo "下一步:"
echo "1. 提交更改: git add ."
echo "2. 提交: git commit -m \"Fix theme submodule\""
echo "3. 推送: git push origin main"
echo ""
