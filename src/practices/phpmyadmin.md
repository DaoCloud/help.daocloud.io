![](http://blog.daocloud.io/wp-content/uploads/2015/05/phpmyadmin.png)

## phpMyAdmin 是什么？

**phpMyAdmin** 是使用 PHP 编写的，以网站的方式管理 MySQL 的数据库管理工具，让数据库管理员可以方便的管理 MySQL 数据库。

它具有两大优势：

1. phpMyAdmin 能够以简易的方式输入繁杂 SQL 语法，尤其是在处理大量数据的导入及导出时更为方便。

2. 由于 phpMyAdmin 与其他 PHP 程序一样在网页服务器上运行，您可以在任何地方使用这些程序产生的 HTML 页面，远程管理 MySQL 数据库，从而方便地创建、查询、修改、删除数据库与表。也可借由 phpMyAdmin 生成 PHP 语句，在编写 PHP 互联网应用时轻松插入 SQL 查询。

## 部署 phpMyAdmin？

首先保证存在一个或新建一个需要被管理的 MySQL 服务实例（如果已有 MySQL 服务实例，可跳过这个步骤）

在**镜像仓库**中选择 **phpMyAdmin**，点击「部署最新版本」。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-0.png)

部署时在**服务&环境**绑定 MySQL 服务，切记此处需要使用 `mysql` 作为连接字符串的别名，然后点击**立即部署**。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-1.png)


部署成功后打开应用的 URL，根据您的 MySQL 实例参数，在启动页面的填写相应的**用户名**和**密码**，您就可以开始管理 MySQL 数据库了。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-2.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-3.png)
