# DaoCloud 帮助手册

## 操作方法：

* 构建执行 `make build`
* 上传执行 `make upload`
* 测试执行 `make test`
* 清除执行 `make clean`

注意：构建时请确保 `gitbook-cli` 已安装，上传时请确保 `qrsync.json` 已正确配置
      (注意：上传根目录为 **dist**)

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
