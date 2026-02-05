# sterbe morgen 博客

[![Deploy Hugo Site](https://github.com/sterbemorgen/sterbemorgen.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/sterbemorgen/sterbemorgen.github.io/actions/workflows/deploy.yml)

这是一个基于 Hugo 和 PaperMod 主题的个人博客，完全使用 GitHub 进行内容管理和部署。

## 技术栈

- **静态站点生成器**: Hugo 0.142.0 (Extended)
- **主题**: PaperMod
- **托管**: GitHub Pages
- **CI/CD**: GitHub Actions
- **内容管理**: GitHub (直接编辑或使用 GitHub Web Editor)

## 快速开始

### 本地开发

1. 克隆仓库:
```bash
git clone https://github.com/sterbemorgen/blog.git
cd blog
```

2. 安装 Hugo Extended:
```bash
# macOS
brew install hugo

# Windows (使用 Chocolatey)
choco install hugo-extended

# Linux
# 请访问 https://github.com/gohugoio/hugo/releases
```

3. 本地预览:
```bash
hugo server -D
```

访问 http://localhost:1313

### 创建新文章

#### 方式一: 使用 Hugo 命令行

```bash
hugo new content/posts/my-new-post.md
```

#### 方式二: 直接在 GitHub 上创建

1. 进入 GitHub 仓库
2. 导航到 `content/posts/`
3. 点击 "Add file" → "Create new file"
4. 文件名格式: `my-new-post.md`
5. 添加 Front Matter 和内容

示例 Front Matter:
```yaml
---
title: "文章标题"
date: 2025-02-06T10:00:00+08:00
draft: false
categories: ["分类"]
tags: ["标签1", "标签2"]
description: "文章描述"
---

这里是文章内容...
```

#### 方式三: 使用 GitHub Web Editor (github.dev)

1. 在仓库页面按 `.` 键，或将 URL 中的 `github.com` 改为 `github.dev`
2. 打开 VS Code 网页版编辑器
3. 创建或编辑文章
4. 提交更改

### 部署

每次推送到 `main` 分支，GitHub Actions 会自动:
1. 构建 Hugo 站点
2. 部署到 GitHub Pages

## 目录结构

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions 部署配置
├── archetypes/                 # 内容模板
├── assets/                     # 资源文件
├── content/                    # 内容目录
│   ├── posts/                  # 博客文章
│   ├── about/                  # 关于页面
│   ├── archives/               # 归档页面
│   └── search/                 # 搜索页面
├── layouts/                    # 自定义布局
├── static/                     # 静态文件
│   └── images/                 # 图片
├── themes/                     # 主题目录
└── hugo.yml                    # Hugo 配置文件
```

## 配置说明

### GitHub Pages 设置

1. 进入仓库 Settings → Pages
2. Source 选择: **GitHub Actions**
3. 保存后等待部署完成

### 自定义域名 (可选)

如果你有自己的域名:

1. 在仓库根目录创建 `static/CNAME` 文件，内容为你的域名
2. 在域名提供商处添加 CNAME 记录指向 `sterbemorgen.github.io`
3. 在 `hugo.yml` 中更新 `baseURL`

## 内容管理

### 分类系统

博客使用 categories 进行分类:
- Perusal (阅读)
- Appreciation (鉴赏)
- Introspective (内省)
- Existence (存在)

### 添加图片

1. 将图片放在 `static/images/` 目录
2. 在文章中引用: `![图片描述](/images/your-image.jpg)`

### 使用标签

在文章的 Front Matter 中添加:
```yaml
tags: ["Hugo", "博客", "技术"]
```

## 功能特性

- ✅ 响应式设计
- ✅ 深色/浅色主题切换
- ✅ 全文搜索
- ✅ 代码高亮
- ✅ 阅读时间估算
- ✅ 字数统计
- ✅ 社交媒体分享
- ✅ RSS 订阅
- ✅ 评论系统 (可配置)

## 维护

### 更新主题

```bash
cd themes/PaperMod
git pull
```

### 更新 Hugo

按照官方文档更新到最新版本，并在 `.github/workflows/deploy.yml` 中更新版本号。

## 故障排查

### 部署失败

1. 检查 GitHub Actions 日志
2. 确保 `hugo.yml` 配置正确
3. 验证所有文章的 Front Matter 格式

### 本地构建失败

```bash
# 清理缓存
hugo --cleanDestinationDir

# 重新构建
hugo
```

## 支持

如有问题，请:
1. 查看 [Hugo 官方文档](https://gohugo.io/documentation/)
2. 查看 [PaperMod 主题文档](https://github.com/adityatelange/hugo-PaperMod)
3. 提交 Issue

## 许可证

本博客内容采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。

代码部分采用 MIT 许可证。
