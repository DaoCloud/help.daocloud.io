## Docker 新手入门 30 min

### 简介

首先欢迎来到 DaoCloud，如果您是 Docker 新手请您花大约三十分钟的时间来了解 Docker 相关的知识和内容。由于在 DaoCloud 上的工作全部是围绕 Docker 展开的，同时 Docker 又与 Linux 息息相关，因此在阅读本文档之前请您确保以下条件：

1. 对 Linux 的命令行操作有一定了解，并且懂得一些基础命令。
2. 对 Linux 服务管理有一定的了解。

当阅读完本文之后您可以了解什么是 Docker、使用它有什么好处、以及 Docker 具体的使用方法。

### 为什么选择 Docker？

1. 相对于虚拟机来说 Docker 有镜像管理。
2. 相对于虚拟机来说更强大的迁移能力。
3. 云计算的未来，再也不用受到环境 API 的限制。

### 安装 Docker

Docker 的安装十分简单方便，如果您有 Linux 虚拟机 VPS 可以直接参考 **[Docker 极速下载](http://get.daocloud.io/)** 运行如下脚本来安装 Docker：

```shell
user$ curl -sSL https://get.daocloud.io/docker | sh
```

在 Docker 安装完成以后，国内的特殊网络环境会导致在构建 Docker 镜像或者是抓取（pull）来自 Docker Hub 上的镜像时会遇到连接问题，这时我们就需要使用 **[DaoCloud 加速器服务](https://dashboard.daocloud.io/mirror)**

1. 注册 DaoCloud 账号，打开控制台进入加速服务。
2. 在网页的最下方有详细的使用步骤请参考。

如果您使用的是 Windows 或 Mac 请您下载安装 Boot2Docker。

这里我推荐使用 Ubuntu Server 操作系统，无论是在裸机上还是虚拟机上。

<!-- TODO: Docker User Guide 链接？ -->

### Hello World

这部分的代码来自 Docker 用户指南，但是与用户指南不同的是我们会描述更多的执行过程。

#### Case 1 启动一个容器

```shell 
root# docker run ubuntu:14.04 /bin/echo 'Hello world'
Hello world
```

1. 注意操作 Docker 是需要权限的，这里使用 `root` 用户操作，当然你也可以把 `docker` 加入自己的用户。
2. `run` 作为 Docker 的子命令来控制新建容器并且运行。Docker 命令虽然比较多，但是命令是分级来执行的，多参照 `help` 就会习惯。
3. `ubuntu:14.04` 代表镜像的名字和版本号，托管在 Docker Hub 上，如果本地没有抓取过那么执行命令的时候会自动从 Docker Hub 抓取。
4. `/bin/echo` 为在容器内执行的程序（应用）
5. `'Hello world'` 为程序执行的参数

> 提示：Docker 在命令执行完毕后不会销毁容器，但是状态为变为 `Exited`。

从这句命令中我们可以看到 Docker 可以根据情况判断镜像存在的情况，在后文中会介绍镜像的管理。同时 `ubuntu:14.04` 将会被载入到缓存中，如果后面的镜像构建依赖于它并不会花费额外的网络带宽抓取，十分方便。

#### Case 2-1 以交互模式启动一个容器

```shell
root# docker run -t -i ubuntu:14.04 /bin/bash
root@af8bae53bdd3:/#
```

与上面的 Case 不同的是这条命令带有 `-t` 和 `-i` 选项，这两个选项在这指的是：

    -i, --interactive=false    Keep STDIN open even if not attached
    -t, --tty=false            Allocate a pseudo-TTY

上面来自 `docker help run` 的输出，`help` 命令是获取文档帮助信息最简短而高效的途径。本次启动的进程是 bash，运行 bash 之后，容器会在交互的模式下启动。当 bash 退出后就会停止运行。这就是 Docker 运行程序的最简单方式。

> 提示：此程序运行完成之后，容器不会被销毁，但是状态为 `Exited`。此外对于以交互模式启动的容器可以先按下 `Ctrl+P` 然后按下 `Ctrl+Q` 这样的按键顺序脱离（detach）一个容器，脱离后的容器状态仍为 `Up` 并且程序会继续在后台运行，这时可以使用 `attach` 命令重新附到一个已经脱离的程序。

#### Case 2-2 查看容器内的文件以及容器本身

在上一个例子中如果容器没有关闭通过如下命令可以看出:

```shell
root@33d90ffaf1ac:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@33d90ffaf1ac:/# pwd
/
root@33d90ffaf1ac:/#
```

Docker 中整个容器是一个 Linux 环境，ubuntu 镜像的默认用户为 root，默认工作目录为根目录。

```
root@33d90ffaf1ac:/# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  18172  3104 ?        Ss   08:50   0:00 /bin/bash
root        16  0.0  0.0  15572  2200 ?        R+   09:04   0:00 ps aux
```

容器中的进程相当简洁，只有正在运行的两个程序没有其他任何进程。

并且 PID 号码是独立存在的，与宿主机完全没有关系。

#### Case 3 查看后台运行容器的日志信息

```shell
root# sudo docker run -t -i -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
8b8aad0aa7670441f99ce88fbac021bfb9cb124e7de4417a00ed3c0ccc6cb203
```

在这个 Case 中加入了新的选项 `-d`，这个选项中可以让 Docker 后台运行程序。

如果我们查看运行的结果：

```shell
root# docker logs 8b8aad0aa767
hello world
hello world
hello world
```

从上面的命令来看，使用 logs 能看到程序的输出 log 过程，这样对服务的调试是非常有帮助的。如果容器没有自己设定的名字很难快速准确的调度容器。

#### Case 4 快速准确的调度容器--给容器起名字

```shell
root# docker run -t -i -d --name helloubuntu ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
8b8aad0aa7670441f99ce88fbac021bfb9cb124e7de4417a00ed3c0ccc6cb203
```

上面的命令跟之前 Case 中的命令对比多了一个 `--name` 选项给调度容器带来了很多方便，用户可以自己设定容器的名字，当然如果未指定名字系统会自动起一个随机的名字给容器。那么我们查看 logs 的时候就可以通过命令 `docker logs helloubuntu` 来查看日志信息了。

> 注意：容器名必须以英文字母和数字开头，并且只能包含英文数字、下划线 `_`、小数点 `.`、和减号 `-`。

#### Case 5 列出所有正在运行的 Container 和它们的基本信息

```shell
root# docker ps -a
CONTAINER ID        IMAGE                      COMMAND                CREATED             STATUS                      PORTS                    NAMES
53d90769be11        ubuntu:14.04               "/bin/sh -c 'while t   2 minutes ago       Up 2 minutes                                         helloubuntu
8b8aad0aa767        ubuntu:14.04               "/bin/sh -c 'while t   14 minutes ago      Up 14 minutes                                        backstabbing_ardinghelli
deaaa8e60c9f        ubuntu:14.04               "-d /bin/sh -c 'whil   14 minutes ago                                                           distracted_darwin
33d90ffaf1ac        ubuntu:14.04               "/bin/bash"            26 minutes ago      Exited (0) 14 minutes ago                            tender_franklin
```

在 `# docker ps -a` 这个命令中我们可以看到容器的 ID、使用的镜像、启动的命令、创建的时间、当前状态、端口映射状态和名字。

#### Case 6 容器管理

以下管理命令都可以通过传入容器的 ID 或者名字来管理指定的容器：

* `stop` 停止一个正在运行的容器。
* `start` 运行一个正在停止的容器。
* `restart` 重启一个容器。
* `rm` 删除一个容器。

传入多个 ID 或者名字可以操作多个容器。例如：`docker rm name1 name2` 可以同时删除两个容器。

> 提示：如果要删除所有容器 `docker rm $(docker ps -q -a)`

#### 阶段总结

当您看到这里的时候可以说对 Docker 已经有了初步的操作能力，包括运行容器中的程序、查看容器内容、运行容器、停止容器、查看容器、重启容器和删除容器。但是距离在 Docker 上运行自己的业务或者组织开发还是有一定距离的。接下来我们开始进阶学习，重点研究一下 Docker 操作的组成要素。

### Docker组成要素

如果将轮船拉着集装箱运行在大海上，与Docker运行容器里面的程序类比：

* Linux 相当于大海，有不同的海洋气候各有不同。
* Docker 相当于能行驶在各种大海上的轮船，容器相当于各种规格的集装箱。
* Docker 内的系统相当于货物的包装。
* 目标程序则相当于货物。

当你看完上面的描述之后可以了解到每一种角色不同的作用以及所处的位置有所了解。

当然理论上的 Docker 只是一个轮船图纸，必须得有一个守护进程才能运行。

镜像也是一样，它只是集装箱的图纸，需要在 Docker 中运行容器。

<!-- TODO: 单独列出来 -->

### 通过 Docker 运行你的 Web 应用，Step By Step

代码文件请参考：[DaoCloudStaticBlog](https://github.com/lijianying10/DaoCloudStaticBlog) 以及  [整个研究过程参考](http://open.daocloud.io/build-and-deploy-the-thinnest-docker-image/)
Step 1: 编译自己的web应用，在参考文件中，static这个文件为处理静态资源的golang应用程序。
Step 2: 准备运行在Docker中的操作系统，在参考文件中root.fs为打包好的BusyBox。
Step 3: 准备Dockerfile：
```
#从一个空镜像中开始创建，没有任何依赖。
FROM scratch
MAINTAINER Jianying Li <lijianying12@gmail.com>

#给Docker文件系统中添加根目录，也是Linux的一些基础目录。
ADD ./rootfs.tar /
#给镜像添加工作目录/app
RUN mkdir -p /app
#设定默认工作路径
WORKDIR /app
#复制应用进入到Image中
COPY ./static /app/
#复制应用依赖的静态文件目录
COPY ./public /public
#对外开放的服务接口为8080
EXPOSE 8080

#容器运行时默认调用的启动命令
CMD ["/app/static"]
```
Step4: Build Image： `sudo docker build -t [tag] .` 其中tag为给容器命名的标签，最后有一个点表示Dockerfile存在的文件夹。
Step5: Run 这一步就不用讲了最开始的一个章节就在描述这个 

这里重点讲解一下第三步中Dockerfile的意义。参照Dockerfile中的注释

关于Dockerfile 内部的命令网上虽然很多，但是坑也不少。首先要注意，构建用的依赖文件都要放到同一个文件夹中，不可以寻找到目录之外的文件，这也是为了安全性考虑。
COPY 或者ADD的 目的地址比如说上面的`/app/`与`/public`意义不同，第一个是复制文件到app下，第二个是复制文件夹到根名字叫public。

为了更详细的介绍Dockerfile添加一个额外的Case：
```
FROM node:slim

MAINTAINER Jianying Li <lijianying12@gmail.com>

RUN apt-get update && apt-get install -y git ssh-client ca-certificates --no-install-recommends && rm -r /var/lib/apt/lists/*
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN npm install hexo@3.0.0 -g
RUN mkdir /hexo
WORKDIR /hexo

EXPOSE 4000

CMD ["/bin/bash"]
```
在这个Dockerfile中：
FROM node:slim 表示构建的时候依赖于Nodejs系统，并标明了tag为slim，但是没标明也不需要标明的是node依赖于Debian，这是用户自己需要了解的，下一步就开始Run，当开始构建时是可以运行Dockerfile中的脚本的。
第一个RUN 后面标记的是需要让Debian更新源并且安装一系列的软件，最后清空无用缓存。
第二个RUN 设定时区
第三个RUN 安装HEXO博客系统
最后新建文件夹设定工作目录开放80端口上文中已经提过。

在补充的这个例子中我们可以清楚的看到构建自己的Image可以依赖于其他Image构建环境基本上都已经准备好了，非常方便。第二个例子是构建Hexo blog环境的做法。


### 管理Docker image

#### 拿来主义 pull
第一种是直接pull比如说下载一个docker管理用的dockerui工具，我们可以直接告诉docker pull回来:` docker pull dockerui/dockerui` 
也可以通过运行的方式来pull回image`docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`
这样用直接访问http://host:9000的方法来管理docker了。
#### 查看自己所有的image
```
[#7#root@jianyingLi ~]#docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
hexo3               latest              66f7fc371b44        9 days ago          261.5 MB
node                slim                84326d4c0101        11 days ago         164.5 MB
dockerui/dockerui   latest              9ac79962b9b0        2 weeks ago         5.422 MB
busybox             latest              8c2e06607696        7 weeks ago         2.433 MB
garland/butterfly   latest              114f9c134231        3 months ago        394.5 MB
progrium/busybox    latest              8cee90767cfe        4 months ago        4.789 MB
```
注意使用root权限来查看自己的Docker iamges 提供信息如输出信息所示。

#### 搜索需要的iamge
推荐到[Docker Hub Registry](https://registry.hub.docker.com/)上搜索，非常方便查找您所需要的image。

#### 清空所有当前image
使用命令：`docker rmi $(docker images -q) `
如果当前已经没有image了命令会报错找不到image

#### 构建image的缓存
在构建镜像时运行的命令会进入缓存，如果运行的命令是一样的docker，可以做到很快执行完，非常方便，这一点要擅加利用。

### Docker文件系统的挂载与外部服务访问
首先要注意的一点，如果container被删除，之后在docker持久化的数据会被删除，因此要注意挂载文件系统保证数据安全。
因此这里介绍一下挂载host中的文件系统到Docker中的方法：`docker run -it -d -p 4000:4000 -v /root/blog/:/hexo --name hexo hexo3`这是上一个case中运行hexo blog的方法，注意挂载方法是`-v`之后，容器中就可以访问到host中的持久化位置了。
注意，在数据库应用中最需要根据配置文件将数据库持久化的位置放到host中。
对于开发更加详细的意见可以产考[使用Docker做开发的建议团队工作流](http://www.philo.top/2015/06/04/DockerWorkflow/)
在上面Docker 运行的命令中我们需要从容器外查看Hexo blog的编译结果，因此使用`-p` 参数来映射Docker的端口到Host中。

### Docker学习建议：
1. 在详细实践完成本文之后如果您有精力，并且英文阅读能力还不错请您移步到[Docker官方文档](https://docs.docker.com/userguide/)继续更深入的学习
2. Docker只是一种非常实用的工具，不要以Docker为目的去学习Docker，重要的不是Docker而是您用Docker做什么。

### 总结
由于篇幅有限新手教程就到这里，希望您在这半个小时到一个小时中能又一次非常完美的Docker学习体验，在接下来的学习中您还可以继续从Docker官方的文档中了解更多的Docker相关的信息，尤其是Docker容器与容器之间的问题解决，以及更多更加丰富的命令参数使用，比如环境变量的控制。
相信做完这部分实践之后您已经了解了Docker是干什么的，如何进行基础方面的使用。在下一篇中我们会 根据您现有的基础介绍如何使用DaoCloud各项服务。

在接下来的学习中，如果需要请您学习使用版本管理工具GIT，及其相关基础知识。
