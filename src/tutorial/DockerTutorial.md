# Docker新手入门 30min

## Introduction
首先欢迎来到DaoCloud，如果您是Docker新手请您花大约30分钟的时间来了解Docker相关的知识和内容。
由于在DaoCloud上的工作全部是围绕Docker展开的，同时Docker又与Linux息息相关，因此在阅读本文档之前请您确保以下条件：

1. 对Linux的命令行操作有一定了解，并且懂的一些基础命令。
2. 对Linux服务管理有一定的了解。

当阅读完本文之后您可以了解什么是Docker，使用它有什么好处，以及Docker具体的使用方法。


## 为什么选择Docker？
1. 相对于虚拟机来说Docker有Image管理。
2. 相对于虚拟机来说更强大的迁移能力。
3. 云计算的未来，再也不用受到环境API的限制。


## Install Docker
Docker的安装十分简单方便，如果您有Linux虚拟机VPS可以直接参考[DaoCloud中的做法](http://get.daocloud.io/)运行如下脚本：
```shell
curl -sSL https://get.daocloud.io/docker | sh
```
安装Docker。

安装完成之后因为地理位置的问题在构建Dockerimage或者是Pull来自Docker Hub上的image会遇到网络问题，这适合我们就需要使用[DaoCloud加速器服务](https://dashboard.daocloud.io/mirror)

1. 注册DaoCloud账号，打开控制台进入加速服务。
2. 在网页的最下方有详细的使用步骤请参考。

如果您使用的是Windows或Mac请您下载安装Boot2Docker。

这里我推荐使用Ubuntu Server操作系统，无论是在host上还是虚拟机上。

## Hello World
这部分的代码来自Docker UserGuide，但是与User Guide不同的是我们会描述更多的执行过程。

### case1 运行一个容器
```shell 
$ sudo docker run ubuntu:14.04 /bin/echo 'Hello world'
Hello world
```
1. 注意Docker是需要使用root权限的。
2. Run作为Docker的子命令来控制新建容器并且运行。
    Docker命令虽然比较多，但是命令是分级来执行的，多参照Help就会习惯。
3. ubuntu:14.04 代表镜像的名字，由Docker Hub来提供，如果本地没有pull那么执行命令的时候会有Pull的动作。
4. /bin/echo 在容器内执行的程序（进程） 
5. 'Hello world' 程序执行的参数

Tip：此程序运行完成之后，容器状态为存在，但是为Stop。

从这句命令中我们可以看到Docker可以根据情况判断image存在的情况，在后文中会介绍image的管理。同时Ubuntu:14.04放到缓存中，如果后面的镜像构建依赖于它并不会占用网络带宽，十分方便。

### case2-1 进入容器内操作
```shell
$ sudo docker run -t -i ubuntu:14.04 /bin/bash
root@af8bae53bdd3:/#
```
与上面的Case不同的是这里有一个 `-t -i`在这指的是：
`-i, --interactive=false    Keep STDIN open even if not attached`
`-t, --tty=false            Allocate a pseudo-TTY`
上面来自help命令的提示，help命令提示的是最简短最高效的获取文档信息途径。本次启动的进程是bash，运行bash之后，Container会在attach状态随时操作。Ctrl+c就会停止运行。这就是Docker运行程序的最简单方式。

Tip：此程序运行完成之后，容器状态为存在，但是为Run。
Tip：次程序关闭之后（detach）容器依然为存在状态，但是为Stop。

### case2-2 查看容器内的文件以及容器本身
在上一个例子中如果容器没有关闭通过如下命令可以看出:
```shell
root@33d90ffaf1ac:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@33d90ffaf1ac:/# pwd
/
root@33d90ffaf1ac:/#
```
Docker中容器使用了root权限，整个容器内也是一个操作系统，且默认工作目录为根。

```
root@33d90ffaf1ac:/# ps
  PID TTY          TIME CMD
    1 ?        00:00:00 bash
   15 ?        00:00:00 ps
```
容器中的进程相当简洁，只有正在运行的两个程序没有其他任何进程。
并且PID号码是独立存在的，与Host主机完全没有关系。
```
root@33d90ffaf1ac:~# uname -a
Linux 33d90ffaf1ac 3.13.0-24-generic #46-Ubuntu SMP Thu Apr 10 19:11:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
root@33d90ffaf1ac:~# free -m
             total       used       free     shared    buffers     cached
Mem:          3162        567       2594          0         36        341
-/+ buffers/cache:        189       2972
Swap:         2043          0       2043
root@33d90ffaf1ac:~# df -h
Filesystem                 Size  Used Avail Use% Mounted on
rootfs                      77G  4.7G   68G   7% /
none                        77G  4.7G   68G   7% /
tmpfs                      1.6G     0  1.6G   0% /dev
shm                         64M     0   64M   0% /dev/shm
/dev/mapper/jianyingLi--vg-root   77G  4.7G   68G   7% /etc/hosts
tmpfs                      1.6G     0  1.6G   0% /proc/kcore
tmpfs                      1.6G     0  1.6G   0% /proc/latency_stats
tmpfs                      1.6G     0  1.6G   0% /proc/timer_stats
```
整个容器内为一个独立有效的操作系统，设备输出信息与Host一致。但由于文件系统问题，还是有一定出入。


### Case3 运行一个后台容器，并且查看日志信息
```
[#3#root@jianyingLi ~]#sudo docker run -t -i -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
8b8aad0aa7670441f99ce88fbac021bfb9cb124e7de4417a00ed3c0ccc6cb203
```
在这个Case中加入了新的选项`-d`这个选项中可以让Docker后台运行进程，托管到Docker守护进程中。
如果我们查看运行的结果：
```shell
[#4#root@jianyingLi ~]#docker logs 8b8aad0aa767
hello world
hello world
hello world
```
从上面的命令来看，使用logs能看到程序的输出log过程，这样对服务的调试是非常有帮助的。如果容器没有自己设定的名字很难快速准确的调度容器。

### case4 快速准确的调度容器--给容器起名字
```
[#5#root@jianyingLi ~]#sudo docker run -t -i -d --name helloubuntu ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
8b8aad0aa7670441f99ce88fbac021bfb9cb124e7de4417a00ed3c0ccc6cb203
```

上面的命令跟之前Case中的命令对比多了一个--name选项（-name已经过时）给调度容器带来了很多方便，用户可以自己设定容器的名字，当然如果未指定名字系统会自动起一个随机的名字给容器。
那么我们查看logs的时候就可以通过命令`sudo docker logs helloubuntu`愉快的查看日志信息了。

Tip：Container name only [a-zA-Z0-9][a-zA-Z0-9_.-] are allowed.

### Case5 查看所有正在运行的Container

```shell
[#6#root@jianyingLi ~]#docker ps -a
CONTAINER ID        IMAGE                      COMMAND                CREATED             STATUS                      PORTS                    NAMES
53d90769be11        ubuntu:14.04               "/bin/sh -c 'while t   2 minutes ago       Up 2 minutes                                         helloubuntu
8b8aad0aa767        ubuntu:14.04               "/bin/sh -c 'while t   14 minutes ago      Up 14 minutes                                        backstabbing_ardinghelli
deaaa8e60c9f        ubuntu:14.04               "-d /bin/sh -c 'whil   14 minutes ago                                                           distracted_darwin
33d90ffaf1ac        ubuntu:14.04               "/bin/bash"            26 minutes ago      Exited (0) 14 minutes ago                            tender_franklin
```

在`# docker ps -a` 这个命令中我们可以看到容器的ID（hash）使用的Image的名字，启动的命令，创建的时间，目前状态，端口映射状态以及名字。
这些信息组成了我们需要管理容器的所有要素，接下来我们就来做这些测试用的Docker，开始进阶实践。

Tip： docker运行需要root权限，不要忘了。

### Case6 容器管理
`docker stop [ID/Name]` 停止一个正在运行的容器。
`docker start [ID/Name]` 运行一个正在停止的容器。
`docker restart [ID/Name]` 重启一个容器。
`docker rm [ID/Name]` 删除一个容器。
以上的命令可以同时操作多个容器。比如说：`docker rm name1 name2`这样两个容器就会被同时删除了。
如果要删除所有容器` docker rm $(docker ps -q -a) `

### 阶段总结
当您看到这里的时候可以说对Docker已经有了初步的操作能力，包括运行容器中的程序，查看容器内容，运行容器，停止容器，查看容器，重启容器，删除容器。但是距离在Docker上运行自己的业务或者组织开发还是有一定距离的，接下来我们开始进阶学习，重点研究一下Docker操作的组成要素。

## Docker组成要素
如果将轮船拉着集装箱运行在大海上，与Docker运行容器里面的程序类比：
Linux相当于大海，有不同的海洋气候各有不同，Docker相当于能行驶在各种大海上的轮船，容器相当于各种规格的集装箱，Docker内的系统相当于货物的包装，目标程序相当于货物。
当你看完上面的描述之后可以了解到每一种角色不同的作用以及所处的位置有所了解。
当然理论上的Docker只是一个轮船图纸，必须得有一个守护进程才能运行。
Image也是一样，它只是集装箱的图纸，需要在docker中运行容器。


## 通过Docker运行你的Web应用，Step By Step
代码文件请参考：[https://github.com/lijianying10/DaoCloudStaticBlog](https://github.com/lijianying10/DaoCloudStaticBlog) 以及  [整个研究过程参考](http://open.daocloud.io/build-and-deploy-the-thinnest-docker-image/)
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


## 管理Docker image

### 拿来主义 pull
第一种是直接pull比如说下载一个docker管理用的dockerui工具，我们可以直接告诉docker pull回来:` docker pull dockerui/dockerui` 
也可以通过运行的方式来pull回image`docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui`
这样用直接访问http://host:9000的方法来管理docker了。
### 查看自己所有的image
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

### 搜索需要的iamge
推荐到[https://registry.hub.docker.com/](https://registry.hub.docker.com/)上搜索，非常方便查找您所需要的image。

### 清空所有当前image
使用命令：`docker rmi $(docker images -q) `
如果当前已经没有image了命令会报错找不到image

### 构建image的缓存
在构建镜像时运行的命令会进入缓存，如果运行的命令是一样的docker，可以做到很快执行完，非常方便，这一点要擅加利用。

## Docker文件系统的挂载与外部服务访问
首先要注意的一点，如果container被删除，之后在docker持久化的数据会被删除，因此要注意挂载文件系统保证数据安全。
因此这里介绍一下挂载host中的文件系统到Docker中的方法：`docker run -it -d -p 4000:4000 -v /root/blog/:/hexo --name hexo hexo3`这是上一个case中运行hexo blog的方法，注意挂载方法是`-v`之后，容器中就可以访问到host中的持久化位置了。
注意，在数据库应用中最需要根据配置文件将数据库持久化的位置放到host中。
对于开发更加详细的意见可以产考[http://www.philo.top/2015/06/04/DockerWorkflow/](http://www.philo.top/2015/06/04/DockerWorkflow/)
在上面Docker 运行的命令中我们需要从容器外查看Hexo blog的编译结果，因此使用`-p` 参数来映射Docker的端口到Host中。

##Docker学习建议：
1. 在详细实践完成本文之后如果您有精力，并且英文阅读能力还不错请您移步到[Docker官方文档](https://docs.docker.com/userguide/)继续更深入的学习
2. Docker只是一种非常实用的工具，不要以Docker为目的去学习Docker，重要的不是Docker而是您用Docker做什么。

## 总结
由于篇幅有限新手教程就到这里，希望您在这半个小时到一个小时中能又一次非常完美的Docker学习体验，在接下来的学习中您还可以继续从Docker官方的文档中了解更多的Docker相关的信息，尤其是Docker容器与容器之间的问题解决，以及更多更加丰富的命令参数使用，比如环境变量的控制。
相信做完这部分实践之后您已经了解了Docker是干什么的，如何进行基础方面的使用。在下一篇中我们会 根据您现有的基础介绍如何使用DaoCloud各项服务。

在接下来的学习中，如果需要请您学习使用版本管理工具GIT，及其相关基础知识。
