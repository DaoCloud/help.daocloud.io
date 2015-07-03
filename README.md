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

## 写作规范

* Markdown 主要使用 **[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)**。
  + 此外对于无序列表，第一层使用字符 `*`，第二层使用字符 `+`，第三层使用字符 `-`。
  + 对于除了标题的列表应以句号结尾。
* URL PATH 链接格式统一采用标题的英语翻译小写并用字符 `-` 分割单词。
  - 如 `/section-name/subsection-name/topic-name`。
* 内容文本风格参考 **[文案风格指南](http://open.leancloud.cn/copywriting-style-guide.html)**。
