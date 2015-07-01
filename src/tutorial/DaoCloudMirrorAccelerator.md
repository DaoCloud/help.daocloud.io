#DaoCloud加速器

##DaoMirror
DaoMirror是DaoCloud推出的Docker Hub Mirror服务的官方名称。

Docker官方对Mirror的定义
> Such a registry is provided by a third-party hosting infrastructure but is targeted at their customers only. Some mechanism ensures that public images are pulled from a sponsor registry to the mirror registry, to make sure that the customers of the third-party provider can docker pull those images locally.

Mirror是Docker Registry的一种特殊类型，它起到了类似代理服务器的缓存角色，在用户和Docker Hub之间做Image的缓存。 这个功能的设计目的是为了企业客户访问Docker Hub时降低网络开销。

## 加速器是什么？
DaoCloud加速器是我们为中国开发者提供的Docker Hub Mirror服务。DaoCloud的博客有两篇文章非常详细的介绍了Docker Hub Mirror的工作机制，和DaoCloud加速器的后台架构：
- [玩转Docker镜像](http://blog.daocloud.io/how-to-master-docker-image/)
- [DaoCloud宣布Docker Hub Mirror服务永久免费](http://blog.daocloud.io/daocloud-mirror-free/)

Docker镜像的分层文件系统是非常有趣的创新，作为Docker用户，大家感兴趣可以阅读DaoCloud成员孙宏亮撰写的Docker源码分析系列中有关[Docker镜像](http://blog.daocloud.io/docker-source-code-analysis-part9/)的文章。

## 使用加速器的必要性
- 使用Docker的时候，需要经常从官方获取镜像。由于显而易见的网络原因，获取镜像的过程较慢，令人非常痛苦。因此DaoCloud推出Docker加速器解决这个难题。Docker加速器利用Docker官方的Mirror机制，一次配置，无缝使用。
- 值得一提的是，DaoCloud系统本身也是加速器的重度用户。我们在运行Docker的机器上都配置了加速器服务，有效的节省了`docker pull`的时间。

## 加速方法
请先确定你的Docker版本高于1.3.2。
请仔细参考[控制台中加速器](https://dashboard.daocloud.io/mirror)的操作手册。

## Mirror与Private Registry的区别
二者有着本质的差别。
- Private Registry是开发者或者企业自建的Image存储库，通常用来保存企业内部的Docker Image，用于内部开发流程和产品的发布、版本控制。
- Mirror是一种代理中转服务，我们提供的Mirror服务，直接对接Docker Hub的官方Registry。Docker Hub上有数以十万计的各类Docker Image。
- 在使用Private Registry时，需要在Docker Pull，或Dockerfile中直接键入Private Registry的地址，通常这样会导致跟Private Registry的绑定，缺少灵活性。
- 使用Mirror服务，只需要在Docker Daemon的配置文件中加入Mirror参数，即可在全局范围内透明的访问官方的Docker Hub，避免了对Dockerfile Image引用来源的修改。


## 加速器与其他第三方提供的镜像有何区别？
- 加速器机制（mirror机制）是Docker的官方机制，更方便，安全，高效。
- 加速器机制是Docker官方推出，在1.3.2版本之后提供长期的稳定支持，今后官方会在mirror之上做更多的功能。
- 加速器可以Docker无缝集成，无需修改DockerFile，也无需修改命令。
- 加速器直接使用Docker官方的镜像，由于有Docker内置安全机制，可以确保不会有任何篡改。相比与其他第三方镜像，不会有安全隐患，内置后门。

## 为什么我使用加速器后，没有明显提速？
- 请确保您的docker版本是1.3.2及以上，您可以使用 `docker -v` 查看您当前的版本。并且确保当您启动 `Docker Deamon` 进程时指定了 `–registry-mirror` 参数，您可以参考加速器页面的“操作手册”获得详尽的配置帮助。

## 工作原理
Mirror是Docker的官方机制，它是Registry的一种特殊类型，在部署了Registry之后，需要开启Mirror模式并做一定的配置。具体的流程如下图：
![](http://blog.daocloud.io/wp-content/uploads/2015/03/1.jpg)

###准备工作

- 在公有云环境部署Mirror Registry，并优化存储和网络访问（后文会详述）
- 在客户端，修改Docker的配置文件，添加registry-mirror参数（Mirror控制台中有详细的配置步骤）

### DaoMirror云端部署架构

下图是DaoCloud在搭建Mirror服务时，采用的架构
![](http://blog.daocloud.io/wp-content/uploads/2015/03/Mirror_Arch.jpg)

我们选择了UCloud和七牛云存储。这样的架构是基于以下的几个考虑：
- 我们的Mirror服务主节点位于UCloud北京BGP机房。BGP机房网络上行下行的速度都非常快，有助于获得稳定高速的对外访问带宽，在Docker Hub Regsitry下载Image，获得不错的速度。
- 我们扩展了Mirror的Registry Disk Driver，使它可以支持UCloud的UDisk服务。
- BGP机房的云主机需要绑定外网IP，并且是根据带宽收费。提供类似Image下载服务，开销巨大。因此我们把下载缓存完成后的静态Image文件，定期同步到七牛云，即降低了带宽成本，同时也享受到了CDN的加速。

### 工作流程

Docker Hub由Index和Registry构成，Index保存Image Layer的hash和关联关系等元数据（Metadata），Registry用于存储Image Layer的实际二进制数据。在客户端没有配置registry-mirror参数的情况下，每一次docker pull，客户端都会先连接Index获取元数据，然后再连接Registry获取实际的Image文件。由于Docker Hub的Index节点和Regsitry都部署国外，国内用户访问，经常遭遇连接超时或中断的情况，下载速度也极其缓慢。

在启用了Mirror之后，访问流程如下：

- 客户端的Docker Daemon连接Index获取Metadata，这一部分的数据量极小，直连国外的速度可以忍受
- 根据Metadata的信息，Docker Daemon与Mirror服务器建立连接。如果pull的Image在Mirror上已经有缓存，就直接在Mirror上返回地址并下载
- 如果Image在Mirror并无缓存，Mirror会与Docker Hub Registry建立连接，下载Image，提供给用户的同时，在本地缓存
- Mirror下载Docker Hub Image采用stream的方式，即可以一边下载，一边提供给客户端的Docker Daemon，不必等Image完全下载完

通过以上的描述，可以发现，对于常用的Image，Mirror缓存命中率会非常高，如Ubuntu等基础Image，这会极大提高下载速度。同时，Docker Image采用分层的结构，即使Image被更新，也只是下载最新一层非常少的增量数据。

Mirror服务亦可以通过网络优化，加速对远端Docker Hub Registry的访问速度，如采用高速的商业VPN建立从Mirror到Docker Hub Registry的访问。通过七牛等云存储和CDN分发网络，会进一步提高国内客户端的下载速度。