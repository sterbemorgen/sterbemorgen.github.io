# 🚀 从 Netlify 迁移到 GitHub Pages 完整指南

## 📋 概述

本指南将帮助你将 Hugo 博客从 Netlify 完全迁移到 GitHub Pages，包括移除 Netlify CMS。

## 🎯 迁移目标

- ✅ 使用 GitHub Pages 托管静态网站
- ✅ 移除所有 Netlify 和 Netlify CMS 依赖
- ✅ 使用 GitHub Actions 自动部署
- ✅ 直接通过 Git 管理内容（无需 CMS）

## 📁 项目结构变化

### 删除的文件
```
static/admin/           # Netlify CMS 配置
netlify.toml           # Netlify 配置
.github/workflows/gh-pages.yml  # 旧的 workflow
```

### 新增的文件
```
.github/workflows/deploy-pages.yml  # 新的 GitHub Pages workflow
```

## 🔧 迁移步骤

### 步骤 1: 清理 Netlify 相关文件

运行清理脚本：

```bash
chmod +x remove-netlify.sh
./remove-netlify.sh
```

### 步骤 2: 配置 GitHub Pages

1. 进入你的 GitHub 仓库 `sterbemorgen/sterbemorgen.github.io`
2. 点击 **Settings** → **Pages**
3. 在 **Source** 下选择 **GitHub Actions**

   ![GitHub Pages Settings](https://docs.github.com/assets/cb-47267/mw-1440/images/help/pages/publishing-source-drop-down.webp)

### 步骤 3: 配置仓库权限

确保 GitHub Actions 有正确的权限：

1. 进入 **Settings** → **Actions** → **General**
2. 滚动到 **Workflow permissions**
3. 选择 **Read and write permissions**
4. 勾选 **Allow GitHub Actions to create and approve pull requests**
5. 点击 **Save**

### 步骤 4: 提交并推送更改

```bash
# 查看更改
git status

# 添加所有更改
git add .

# 提交
git commit -m "Migrate from Netlify to GitHub Pages"

# 推送到 GitHub
git push origin main
```

### 步骤 5: 验证部署

1. 推送后，进入仓库的 **Actions** 标签
2. 你应该看到 "Deploy Hugo site to GitHub Pages" workflow 正在运行
3. 等待 workflow 完成（通常 1-2 分钟）
4. 访问 https://sterbemorgen.github.io/ 查看你的网站

## 📝 内容管理方式变化

### 之前（使用 Netlify CMS）
- 通过 Web 界面在 `/admin` 编辑内容
- CMS 自动提交到 GitHub

### 现在（直接使用 Git）
你可以通过以下方式管理内容：

#### 方式 1: 本地编辑（推荐）
```bash
# 创建新文章
hugo new content/posts/my-new-post.md

# 编辑文章
vim content/posts/my-new-post.md  # 或使用任何文本编辑器

# 本地预览
hugo server -D

# 提交并推送
git add .
git commit -m "Add new post: my-new-post"
git push
```

#### 方式 2: GitHub Web 界面
1. 在 GitHub 上进入 `content/posts/` 目录
2. 点击 **Add file** → **Create new file**
3. 创建文件（例如：`my-post.md`）
4. 添加 Front Matter 和内容
5. 点击 **Commit changes**

#### 方式 3: GitHub Codespaces（云端 VS Code）
1. 在仓库页面点击 **Code** → **Codespaces** → **Create codespace**
2. 在云端 VS Code 中编辑
3. 使用终端运行 `hugo server` 预览
4. 提交并推送

#### 方式 4: 移动设备编辑
- **iOS**: 使用 Working Copy 或 GitHub 官方 app
- **Android**: 使用 GitJournal 或 GitHub 官方 app

## 🎨 新文章模板

在 `content/posts/` 创建新文章时，使用以下模板：

```markdown
---
title: "文章标题"
date: 2026-02-06T12:00:00+09:00
draft: false
categories:
  - perusal  # 可选: appreciation, introspective, existence
tags:
  - 标签1
  - 标签2
description: "文章简短描述"
---

在这里写文章内容...
```

## 🔄 自动部署流程

现在的工作流程：

```
本地编辑 → Git Commit → Git Push → GitHub Actions 自动构建 → 部署到 GitHub Pages
```

每次推送到 `main` 分支时：
1. GitHub Actions 自动触发
2. 使用 Hugo 构建网站
3. 部署到 GitHub Pages
4. 通常 1-2 分钟后网站更新

## ⚙️ Workflow 配置说明

新的 workflow (`.github/workflows/deploy-pages.yml`) 包含以下功能：

- ✅ 自动触发（push 到 main）
- ✅ 手动触发（workflow_dispatch）
- ✅ 使用最新的 Hugo 0.142.0
- ✅ 启用 Hugo Extended 版本
- ✅ 代码压缩和优化（--minify, --gc）
- ✅ 支持 Git 子模块（主题）
- ✅ 完整的 Git 历史（支持 .GitInfo）

## 🌐 域名配置（可选）

如果你想使用自定义域名：

1. 在仓库根目录创建 `static/CNAME` 文件：
   ```bash
   echo "yourdomain.com" > static/CNAME
   ```

2. 在域名提供商处添加 DNS 记录：
   ```
   Type: CNAME
   Name: www (或 @)
   Value: sterbemorgen.github.io
   ```

3. 在 GitHub Pages 设置中添加自定义域名

## 🐛 故障排查

### 部署失败
- 检查 Actions 标签中的错误日志
- 确保 workflow 权限设置正确
- 验证 hugo.yml 配置正确

### 网站无法访问
- 等待 1-2 分钟让 DNS 传播
- 清除浏览器缓存
- 检查 GitHub Pages 设置是否选择了 "GitHub Actions"

### 样式丢失
- 确保 `hugo.yml` 中的 `baseURL` 正确
- 检查主题是否正确加载

## 📚 有用的命令

```bash
# 本地开发服务器（含草稿）
hugo server -D

# 本地开发服务器（不含草稿）
hugo server

# 构建生产版本
hugo --minify

# 创建新文章
hugo new content/posts/article-name.md

# 查看 Hugo 版本
hugo version

# 检查配置
hugo config
```

## 🎉 优势

使用 GitHub Pages 相比 Netlify 的优势：

1. **完全免费**：无限制的构建时间和带宽
2. **更简单**：减少一个服务依赖
3. **更快**：GitHub Actions 构建速度很快
4. **更灵活**：完全掌控部署流程
5. **版本控制**：所有内容都在 Git 中
6. **开发者友好**：使用熟悉的 Git 工作流

## 🔗 相关资源

- [Hugo 官方文档](https://gohugo.io/documentation/)
- [GitHub Pages 文档](https://docs.github.com/pages)
- [GitHub Actions 文档](https://docs.github.com/actions)
- [PaperMod 主题文档](https://github.com/adityatelange/hugo-PaperMod)

## 💡 下一步

现在你的博客完全由 GitHub 管理了！你可以：

- 开始写新文章
- 自定义主题样式
- 配置自定义域名
- 添加更多 GitHub Actions 功能（如自动发布到社交媒体等）

## 📞 需要帮助？

如果遇到问题：
1. 查看 GitHub Actions 的错误日志
2. 参考本文档的故障排查部分
3. 查看 Hugo 和 GitHub Pages 官方文档

祝你博客运行愉快！ 🎊
