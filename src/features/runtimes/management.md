### 管理主机

#### 主机

在添加了自有主机以后，您就可以开始管理您的自有主机了。

这时在「我的主机」中的主机列表就可以看到已经与当前账号绑定的自有主机和它们的主机名、IP 地址、容器数量和 CPU、内存以及硬盘的使用比率。

![我的主机：主机列表](/img/screenshots/features/runtimes/management/hosts-list.png)

在主机列表中点击主机名，您就可以看到这台自有主机的详细信息了，也可以进入主机的「容器」、「监控」和「设置」选项卡。

---

容器选项卡可以查看运行于该主机容器的容器名、镜像名、映射的端口、和当前的容器状态。

![主机列表：容器](/img/screenshots/features/runtimes/management/host-containers.png)

> 提示：这里的容器是主机 Docker 上正在运行的所有容器，某些容器也许不是 DaoCloud 管理的应用。

---

监控选项卡可以显示当前主机实时（一小时内）和二十四小时内的 CPU、内存以及硬盘使用比率的统计信息。

![主机列表：监控](/img/screenshots/features/runtimes/management/host-monitor.png)

---

设置界面中，可以重新配置主机名、修改部署标签、查看 Daomonit 版本并更新，也可以删除该主机。

![主机列表：设置](/img/screenshots/features/runtimes/management/host-settings.png)

> 提示：删除主机不会影响 Docker 的容器。如有必要删除，请手动用 `docker rm 容器名/ID` 进行删除。

#### 容器

同时在「我的主机」中的容器列表也可以看到运行在自有主机上的容器和它们的容器名、镜像名、主机名、映射的端口和当前的容器状态。

![我的主机：容器列表](/img/screenshots/features/runtimes/management/containers-list.png)

在容器列表中点击容器名，您就可以看到这个容器的详细信息了，也可以进入容器的「概览」、「日志」和「监控」选项卡。

在这里您还可以启动/停止容器、重启容器、暂停容器（暂不支持）和强制终止容器。

<!-- TODO: 是暂停么？ -->

---

概览选项卡可以检视当前容器执行的命令、映射的端口映射的容器卷和配置的环境变量。

![容器列表：概览](/img/screenshots/features/runtimes/management/container-overview.png)

---

日志选项卡可以查看当前容器的运行日志。

![容器列表：日志](/img/screenshots/features/runtimes/management/container-logs.png)

---

监控选项卡可以显示当前容器实时（一小时内）和二十四小时内的 CPU、内存以及网络使用比率的统计信息。

![容器列表：监控](/img/screenshots/features/runtimes/management/container-monitor.png)
