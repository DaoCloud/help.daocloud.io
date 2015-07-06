# DaoCloud 帮助手册

## 操作方法：

* 构建执行 `make build`。
* 上传执行 `make upload`。
* 测试执行 `make test`。
* 浏览执行 `make browse`。
* 清除执行 `make clean`。
* 构建 Docker 镜像使用 `Dockerfile`。

> 注意：构建时请确保 `gitbook-cli` 已安装，上传时请 `qrsync.json` 配置上传目录为当前目录下的 **dist**。

## 目录结构

```
[项目目录]
 |- src            项目源码
 |   |- readme.io  旧链接重定向
 |   |- styles     扩展的样式链表
 |   |- img        图片
 |   |- book.json  GitBook 项目配置
 |   |- _book      构建临时目录 (不在 Repo 中)
 |   `- [...]      项目文档 (Markdown 文件)
 |- inject         注入的 HTML 文件
 |- dist           构建完成目录 (不在 Repo 中)
 |- Makefile       你要的 Makefile
 |- [*.sh]         各种脚本
 `- README.md      这个说明文档
```

## 协作规范

* 「DaoCloud 帮助手册」 使用 **[gitflow](https://github.com/petervanderdoes/gitflow)** 进行仓库维护，请参考 **[git-flow 备忘清单](https://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html)**。

### 文档风格

* 文档的 Markdown 主要采用 **[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)**。
  + 此外对于无序列表，第一层使用字符 `*`，第二层使用字符 `+`，第三层使用字符 `-`，缩进为**两个空格**。
  + 对于除了标题的列表应以句号结尾。
* URL PATH 链接格式统一采用标题的英语翻译小写并用字符 `-` 分割单词。
  - 如 `/section-name/subsection-name/topic-name`。
* 文档内容风格参考 **[文案风格指南](http://open.leancloud.cn/copywriting-style-guide.html)**。
* 修改章节的链接需要同步更新文档中其他章节的链接。

### 推送提交

* 推送提交流程
  1. Rebase 跟踪的上游分支：`git fetch` 并且 `git rebase origin/分支名` 以防止不必要的冲突。
    - 提示：如果有未提交的变更，先 `git stash` 暂存起来并在 rebase 后执行 `git stash pop` 恢复。
  2. 本地测试：执行测试 `make test` 并**确保没有错误**。
  3. 提交：执行 `git commit` 并**编写提交信息**。
    - 提交信息规范参考 **[「Pro Git 第二版」 章节 5.2 分布式 Git - 为项目作贡献](http://git-scm.com/book/zh/v1/%E5%88%86%E5%B8%83%E5%BC%8F-Git-%E4%B8%BA%E9%A1%B9%E7%9B%AE%E4%BD%9C%E8%B4%A1%E7%8C%AE)。**
  4. 推送：执行 `git push` 推送提交的更改到上游跟踪的分支。

> 提示：使用 fetch + rebase 可以避免因为 pull (fetch + merge) 造成的分支混乱。
> 注意：不要 push 临时的 feature 分支。
> **警告：强制推送 `git push -f` 会破坏他人的协作环境，如有必要请与所有协作人员沟通后执行。**

### 发布版本

* 发布（Release）版本号采用 **[语义化版本 2.0.0](http://semver.org/lang/zh-CN/)**。
* 发布信息格式使用下述格式：
  + 首行为 `Release` 加版本号，以空格分割。
  + 第二行为空行。
  + 接下来为修改的详细列表。
    - 为添加的功能使用字符 `+`。
    - 为删除的功能使用字符 `-`。
    - 为修改的功能使用字符 `*`。

发布 Tag 样例：

```
Release v1.2.3

+ Add something
- Remove something
* Modify something
* Major change
  + minor change
  - minor change
  * minor change
```

## 参考链接

* **[GitBook 文档](http://help.gitbook.com/)**
