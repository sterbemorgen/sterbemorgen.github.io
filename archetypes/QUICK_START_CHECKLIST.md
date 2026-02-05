# ✅ GitHub Pages 迁移清单

## 📋 快速操作步骤

### 第一步: 运行迁移脚本
```bash
chmod +x migrate.sh
./migrate.sh
```

### 第二步: GitHub 仓库设置

#### 2.1 配置 GitHub Pages
1. 访问 https://github.com/sterbemorgen/sterbemorgen.github.io/settings/pages
2. **Source** 选择: `GitHub Actions`
3. 保存

#### 2.2 配置工作流权限
1. 访问 https://github.com/sterbemorgen/sterbemorgen.github.io/settings/actions
2. 滚动到 **Workflow permissions**
3. 选择 `Read and write permissions`
4. 勾选 `Allow GitHub Actions to create and approve pull requests`
5. 点击 **Save**

### 第三步: 推送更改
```bash
git add .
git commit -m "Migrate from Netlify to GitHub Pages"
git push origin main
```

### 第四步: 验证部署
1. 访问 https://github.com/sterbemorgen/sterbemorgen.github.io/actions
2. 查看 "Deploy Hugo site to GitHub Pages" 工作流
3. 等待完成（约 1-2 分钟）
4. 访问 https://sterbemorgen.github.io/

---

## 🎯 完成后你将获得

✅ 不再依赖 Netlify  
✅ 完全基于 GitHub 的部署流程  
✅ 更简单的内容管理（直接用 Git）  
✅ 自动化的 CI/CD 部署  
✅ 无限制的构建时间和带宽  

---

## 📝 日常使用

### 创建新文章
```bash
# 方式 1: 本地
hugo new content/posts/my-post.md
vim content/posts/my-post.md

# 方式 2: GitHub 网页
# 直接在 content/posts/ 目录创建新文件

# 方式 3: GitHub Codespaces
# 在线 VS Code 环境编辑
```

### 发布文章
```bash
git add .
git commit -m "Add new post: my-post"
git push
```

自动部署会在 1-2 分钟内完成！

---

## 🔗 有用链接

- 📖 [完整迁移指南](GITHUB_PAGES_MIGRATION.md)
- 🌐 [网站地址](https://sterbemorgen.github.io/)
- 💻 [仓库地址](https://github.com/sterbemorgen/sterbemorgen.github.io)
- 📊 [Actions 面板](https://github.com/sterbemorgen/sterbemorgen.github.io/actions)

---

## ❓ 遇到问题?

**部署失败?**
- 检查 Actions 日志
- 确认权限设置正确
- 验证 hugo.yml 配置

**网站无法访问?**
- 等待 DNS 传播（1-2 分钟）
- 清除浏览器缓存
- 检查 GitHub Pages 设置

详细故障排查请查看 [GITHUB_PAGES_MIGRATION.md](GITHUB_PAGES_MIGRATION.md)
