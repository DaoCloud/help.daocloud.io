### 添加主机

如果想要使用自有主机功能，首先您需要添加至少一台自有主机。

接下来我们将会为您介绍添加自有主机的三种方式。

#### 免费体验

如果您还没有一台装有 Linux 的主机，我们邀请您体验「免费胶囊主机」。

要启动一台胶囊主机请参考下面的步骤：

第一步：在控制台点击「我的主机」。

![控制台：点击我的主机](/img/screenshots/features/runtimes/new/dashboard.png)

---

第二步：在「我的主机」的界面中点击「添加新主机」。

![我的主机：准备添加新主机](/img/screenshots/features/runtimes/new/runtimes-index.png)

---

第三步：在「添加新主机」的界面中点击「免费胶囊主机」。

![添加新主机：免费胶囊主机](/img/screenshots/features/runtimes/new/try.png)

---

这时点下「免费体验」即可启动一台「胶囊主机」。

> 提示：胶囊主机已经预先配置了 Docker，用来学习 [Docker 新手入门 30 min](../../tutorials/README.md) 会很方便哦。

> 警告：每个「胶囊」的生命目前是 120 分钟。尽管胶囊主机里使用 DaoCloud 管理的应用信息会被保留下来，但是胶囊主机内的其他文件和数据将被删除，故不要存放重要文件。

#### 手动安装

如果您有一台 Linux 主机（不论是裸机还是虚机），我们推荐您手动安装 `daomonit` 以配置自有主机。

`daomonit` 为 DaoCloud 的主机监控程序，帮助与用户账户或组织账户进行绑定以及对 Docker 服务进行监控和管理。

##### 安装前准备

安装前请确保：

* 已连接至互联网（但不需要公网 IP）。
* 建议使用官方支持的操作系统。

目前由 DaoCloud 官方支持的操作系统：

* Ubuntu
  - 兼容版本：12.04、14.04、15.04\*
* CentOS
  - 兼容版本：6、7
* Debian
  - 兼容版本：7\*
* Fedora
  - 兼容版本：18\*、20\*

> 提示：带有 `*` 的版本仅提供安装支持。

##### 安装 `daomonit`

要安装 `daomonit` 到自有主机请参考下面的步骤：

第一步：在控制台点击「我的主机」。

![控制台：点击我的主机](/img/screenshots/features/runtimes/new/dashboard.png)

---

第二步：在「我的主机」的界面中点击「添加新主机」。

![我的主机：准备添加新主机](/img/screenshots/features/runtimes/new/runtimes-index.png)

---

第三步：按照最新的安装步骤进行操作。

![我的主机：手动添加](/img/screenshots/features/runtimes/new/manual.png)

---

完成后，您将会看到「检测到主机」。

##### 开启或关闭自动启动

* 对于非 systemd 管理的系统请使用 `chkconfig daomonit on|off`。
* 对于 systemd 管理的系统请使用 `systemctl enable|disable daomonit`。

##### 要启动、停止或重启

* 对于非 systemd 管理的系统请使用 `service daomonit start|stop|restart`。
* 对于 systemd 管理的系统请使用 `systemctl start|stop|restart daomonit`。

##### 卸载 `daomonit`

* 对于 CentOS 和 Fedora 请使用 `rpm -e daomonit`。
* 对于 Ubuntu 和 Debian 请使用 `dpkg -r daomonit`。

#### 应用市场

##### 腾讯云

要在腾讯云使用应用市场模板请参考下面的步骤：

第一步：访问腾讯云[服务市场](http://market.qcloud.com/detail.php?productId=143)并点击「立即使用」。

![腾讯云：服务市场](/img/screenshots/features/runtimes/new/qcloud-market.png)

---

第二步：登录腾讯云[云主机管理](http://console.qcloud.com/cvm/index)找到新创建的腾讯云主机并点击「登陆到 Web 客户端」。

![腾讯云：管理云主机](/img/screenshots/features/runtimes/new/qcloud-manage.png)

> 提示：如果找不到新创建的主机，请确认选择正确的区域，实例中为「华东区-上海」。

---

第三步：在 Web 客户端中找到绑定用的网址，并输入到浏览器中。

![腾讯云：开启 Web 客户端](/img/screenshots/features/runtimes/new/qcloud-console.png)

---

第四步：在打开的网页中选择要绑定到的账户，并点击「确认绑定」。

![我的主机：主机绑定](/img/screenshots/features/runtimes/new/binding.png)

---

就这么简单，这时您已经成功创建了一台腾讯云主机并和 DaoCloud 账户成功绑定了。您可以在主机列表中找到这台主机。

![腾讯云：绑定成功](/img/screenshots/features/runtimes/new/qcloud-success.png)

> **Aliyun 和 UCloud 即将上线。**

<!-- ##### Aliyun -->

<!-- ##### UCloud -->

#### 下一步

至此，您已经掌握了如何在 DaoCloud 上添加一台自有主机。

下面您可以：

* 了解如何对自有主机进行管理：参考[管理主机](management.md)。
* 了解如何将应用部署到我的主机：参考[应用部署](../deployment.md)。

<!-- TODO: 部署部分完成后更新链接 -->
