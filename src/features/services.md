## 服务集成

大部分情况下应用的运行离不开各类后台服务，尤其是数据库。DaoCloud 服务集成功能目前提供 MongoDB、MySQL、Redis 和 InfluxDB 服务。

让我们配置一个常用的 MySQL 数据库来熟悉服务实例的创建和配置过程吧。

> 注意：服务集成目前不支持[自有主机](runtimes.md)，请将数据库服务以应用的方式部署到自有主机中。

### 配置步骤

第一步：在控制台点击「服务集成」。

![控制台：点击代码构建](/img/screenshots/features/services/dashboard.png)

---

第二步：在「Dao 服务」列表中选择「MySQL」图标。

![服务集成：准备创建新服务](/img/screenshots/features/services/services-index.png)

---

第三步：接下来点击「创建服务实例」。

![服务集成：MySQL 服务](/img/screenshots/features/services/mysql.png)

---

第四步：为服务实例指定「服务实例名称」，服务实例名称只能包含英文数字、下划线 `_`、小数点 `.`、和减号 `-`，并且不能与现有服务实例重名。

![服务集成：配置新服务](/img/screenshots/features/services/new.png)

---

第五步：选择配置：目前我们提供了从 50MB 到 100MB 不等的数据容量，可供绝大多数应用正常使用。

---

第六步：点击「创建」，DaoCloud 将在云平台为您部署相应的服务实例。

---

第七步：创建成功，进入服务实例页面。

![服务集成：服务创建成功](/img/screenshots/features/services/service-overview.png)

---

就这么简单，您的 MySQL 服务实例已经准备就绪可以和应用对接了。

### 查看服务清单

在「服务集成」页面中，点击「我的服务」即可列出服务清单。

![服务集成：服务列表](/img/screenshots/features/services/services-index-with-service.png)

在服务清单中点击服务实例名称，您可以进入项目的「概览」、「绑定的应用」和「设置」选项卡。

---

概览选项卡可以查看服务的参数：连接地址、实例名、用户和密码。

![「概览」选项卡](/img/screenshots/features/services/service-overview.png)

---

绑定的应用选项卡提供了绑定该服务实例的应用列表。

![「绑定的应用」选项卡](/img/screenshots/features/services/service-binding.png)

---

设置选项卡则允许用户删除服务实例。

![「设置」选项卡](/img/screenshots/features/services/service-settings.png)

### SaaS 服务

DaoCloud 服务市场还将陆续集成各类第三方 SaaS 化服务，目前已经提供 New Relic 服务（见下图）。

![](/img/screenshots/features/services/saas.png)

创建 New Relic 服务实例，输入 `APP_NAME` 和 `LICENSE_KEY` 后，将返回 `NEW_RELIC_APP_NAME` 和 `NEW_RELIC_LICENSE_KEY` 参数，用于和应用绑定。

DaoCloud 会很快增加更多实用的 SaaS 化服务，如果您有感兴趣的服务希望我们集成，请来信告知。

> 提示：请勿在这个环境中保存任何重要数据，请做必要的备份

### 下一步

至此，您已经掌握了如何在 DaoCloud 上创建和配置服务实例。

下面您可以：

* 了解如何部署一个应用镜像并绑定数据库服务：参考[应用部署](deployment.md)。
