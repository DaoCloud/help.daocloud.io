# 在DaoCloud上快速发布PHP应用

## Docker官方途径构建

参考链接：[https://registry.hub.docker.com/_/php/](https://registry.hub.docker.com/_/php/)

在这篇官方参考文档中有三个点需要注意：
 - 一半情况下我们都需要php来做web应用因此我们需要重点参考例子With Apache
 - 源码目录在`/var/www/html/`，注意复制代码进去的方式。
 - php.ini的文件夹在`/usr/local/etc/php`，注意放入配置文件的方式。

其他注意要素：

 - 此image基于Debian8 可以使用apt-get但是最后。
 - 有pecl，可以自动安装php模块。
 - 在官方文档中php.ini文件复制这句文档是错误的`COPY config/php.ini /usr/local/etc/php`路径最后应该有一个斜杠。
 - 正确的写法为：`COPY config/php.ini /usr/local/etc/php/`

## 从ubuntu开始构建

请先参考[https://github.com/robychen/apache2-php5](https://github.com/robychen/apache2-php5)

Dockerfile:
```
FROM ubuntu:trusty
# Ubuntu 14.04, Trusty Tahr(可靠的塔尔羊)发行版

# 道客船长荣誉出品
MAINTAINER Captain Dao (support@daocloud.io)

# APT自动安装PHP相关的依赖包,如需其他依赖包在此添加.
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -yq install \
		curl \
		wget \
		apache2 \
		libapache2-mod-php5 \
		php5-mysql \
		php5-sqlite \
		php5-gd \
		php5-curl \
		php-pear \
		php-apc && \

	# 用完包管理器后安排打扫卫生可以显著的减少镜像大小.
	apt-get clean && \
	apt-get autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

	# 安装Composer,此物是PHP用来管理依赖关系的工具,laravel symfony等时髦的框架会依赖它.
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Apache2配置文件:/etc/apache2/apache2.conf
# 给Apache2设置一个默认服务名,避免启动时给个提示让人紧张.
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \

	# PHP配置文件:etc/php5/apache2/php.ini
	# 调整PHP处理Request里变量提交值的顺序,解析顺序从左到右,后解析新值覆盖旧值.
	# 默认设定为EGPCS(ENV/GET/POST/COOKIE/SERVER)
	sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# 配置默认放置App的目录
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD . /app
WORKDIR /app
RUN chmod 755 ./start.sh

EXPOSE 80
CMD ["./start.sh"]
```

此种方法更为灵活，适合项目依赖比较多的情况下使用。
在start.sh中，除了设置环境变量之外，还提供了显示日志的方法。


## 服务集成

这里以PHP添加DaoCloud中服务集成中的MySQL服务为例。
 - 按照说明文档[服务集成](http://help.daocloud.io/function/services.html)添加MySQL服务

 - 应用部署到达基础设置选择自己的MySQL服务，并会显示服务参数如下图
![](/img/php/1.png)

 - 在php程序开发时使用getenv()函数来获取环境变量。

## DaoCloud PHP应用访问MySQL数据库实战

 - 根据文档[服务集成](http://help.daocloud.io/function/services.html)添加MySQL服务
 - 在控制台中选择镜像仓库，然后选择DaoCloud镜像，选择PhpMyAdmin
 - 部署最近版本，选择目标集成的MySQL数据库
 - 启动应用后，在数据库运行SQL语句，方便部署的应用查询测试用的数据
 ```
	CREATE TABLE `test` (
		`id` int NOT NULL AUTO_INCREMENT,
		`data` varchar(255) NOT NULL,
		PRIMARY KEY (`id`)
	);

	insert into `test` ( `data`) values ( '1');
 ```
 - 插入数据的结果
 ![](/img/php/2.png)

 - 例子参考：[https://github.com/lijianying10/DaoCloudPHPDemo](https://github.com/lijianying10/DaoCloudPHPDemo)

## 实例分析

Dockerfile：

```
FROM php:5.6-apache
# Docker 官方PHP5.6+apache发行版本，底层系统使用Debian

# 道客船长荣誉出品
MAINTAINER Captain Dao (support@daocloud.io)

COPY config/php.ini /usr/local/etc/php/
# 复制php配置文件到Image中

COPY src/ /var/www/html/
# 复制代码到Image中

RUN docker-php-ext-install mysqli
# 安装Mysql依赖模块

EXPOSE 80
```

注意事项：

 - 本方法基于Docker官方的 php:5.6-apache 直接就有PHP环境
 - 可以使用插件docker-php-ext-install安装你的依赖模块
 - 不要忘记EXPOSE 80否则无法在DaoCloud中使用Web端口

### 建议工作流程：

 1. 克隆这个例子。
 2. 添加您的php代码到src文件夹中
 3. 修改php.ini到您需要的配置
 4. 在本地调试您的Image可以大幅缩减在DaoCloud中部署调试的时间。
	建议调试脚本：
	```
	docker stop daocloudphpc
	docker rm daocloudphpc
	docker rmi daocloudphp

	docker build -t daocloudphp /root/DaoCloudPHP
	docker run -it -d --name daocloudphpc -e "MYSQL_PORT_3306_TCP_ADDR=10.0.2.15" -e "MYSQL_USERNAME=root" -e "MYSQL_PASSWORD=1" -e "MYSQL_INSTANCE_NAME=test" -p 11210:80 daocloudphp
	docker exec -it daocloudphpc /bin/bash
	```
	容器与镜像的名字可以随您的意愿更换。运行脚本可以删除容器与镜像并重新构建运行您的程序方便调试。
 5. 部署到DaoCloud

### 数据库连接参数说明

index.php
```php
<?php
$mysqli = new mysqli(getenv("MYSQL_PORT_3306_TCP_ADDR"), getenv("MYSQL_USERNAME"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_INSTANCE_NAME"));
// 请注意连接参数的构建，直接使用getenv方法来获取连接参数。参数名字是DaoCloud给的固定参数。
$result = $mysqli->query("SELECT id,data FROM test");
$row = $result->fetch_assoc();
echo htmlentities($row['id'] . " " . $row['data']);
?>
```

在文件中可以看到使用getenv函数来获取环境变量中的参数，也可以使用此方法写入到您需要的配置文件中。
