# sterbe morgen - Personal Blog

基于Hugo和PaperMod主题的个人博客网站。

## 本地开发

### 前置要求

- Git
- Hugo Extended (v0.142.0 或更高版本)

### 初始化

```bash
# 克隆仓库
git clone https://github.com/sterbemorgen/sterbemorgen.github.io.git
cd sterbemorgen.github.io

# 初始化主题子模块
git submodule update --init --recursive
```

### 本地预览

```bash
# 启动开发服务器
hugo server -D

# 在浏览器中访问 http://localhost:1313
```

### 构建网站

```bash
# 构建生产版本
hugo --gc --minify --baseURL "https://sterbemorgen.github.io/"
```

## 部署到GitHub Pages

网站配置为通过GitHub Actions自动部署。

### 自动部署流程

1. 推送代码到 `main` 分支
2. GitHub Actions自动运行构建
3. 构建的网站自动部署到GitHub Pages

### 手动触发部署

1. 进入GitHub仓库的 Actions 标签页
2. 选择 "Deploy Hugo site to GitHub Pages" workflow
3. 点击 "Run workflow" 按钮

## 项目结构

```
.
├── .github/
│   └── workflows/
│       └── deploy-pages.yml    # GitHub Actions部署配置
├── archetypes/                 # 文章模板
├── content/
│   └── posts/                  # 博客文章
│       ├── perusal/           # 阅读分类
│       ├── appreciation/       # 鉴赏分类
│       ├── introspective/      # 内省分类
│       └── existence/          # 存在分类
├── layouts/                    # 自定义布局
├── static/                     # 静态资源（图片等）
├── themes/
│   └── PaperMod/              # PaperMod主题（子模块）
├── hugo.yml                    # Hugo配置文件
└── README.md                   # 本文件
```

## 添加新文章

### 使用命令创建

```bash
# 创建新文章
hugo new content/posts/category-name/article-title.md
```

### 文章Front Matter示例

```yaml
---
title: "文章标题"
summary: "文章摘要"
date: 2024-02-06
categories: ["perusal"]  # perusal, appreciation, introspective, existence
tags: ["标签1", "标签2"]
---

文章内容...
```

## 配置说明

主要配置在 `hugo.yml` 文件中：

- **baseURL**: 网站的基础URL
- **theme**: 使用的主题
- **params**: 主题参数配置
- **menu**: 导航菜单配置

## 故障排查

### 网站无法访问

1. 检查GitHub Actions是否成功运行
2. 确认GitHub Pages设置为"GitHub Actions"
3. 检查仓库的Settings → Actions权限

### 主题丢失

```bash
# 更新主题子模块
git submodule update --init --recursive
```

### 样式未加载

1. 确认 `baseURL` 配置正确
2. 清除浏览器缓存
3. 检查浏览器控制台的错误信息

## 主题文档

PaperMod主题文档：https://github.com/adityatelange/hugo-PaperMod/wiki

## License

个人博客项目
