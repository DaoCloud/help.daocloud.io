![](http://blog.daocloud.io/wp-content/uploads/2015/05/phpmyadmin.png)

## **phpMyAdmin**是什么？

phpMyAdmin 是一个以PHP为基础，以Web-Base方式的MySQL的数据库管理工具，让管理者可用Web管理MySQL数据库。

它具有两大优势：

1. phpMyAdmin这个Web工具能够以简易的方式输入繁杂SQL语法，尤其是在处理大量数据的导入及导出时更为方便。

2. 由于phpMyAdmin与其他PHP程序一样在网页服务器上运行，您可以在任何地方使用这些程序产生的HTML页面，远程管理MySQL数据库，从而方便地创建、修改、删除数据库及数据表。也可借由phpMyAdmin创建常用的php语法，在编写网页时轻松实现sql语法正确性。

## 部署**phpMyAdmin**

### 在镜像仓库中选中**phpMyAdmin**，点击“部署最新版本”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-0.png)

### 绑定您想管理的MySQL数据库实例，并设置服务别名为“**mysql**”。请注意，此处需要通过绑定的方式，让phpMyAdmin容器，与被管理的MySQL附件建立连接。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-1.png)

### 根据您的MySQL实例参数，在启动页面的填写相应的**用户名**和**密码**

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-2.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-php-3.png)