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



