应用的运行离不开各类后台服务。DaoCloud服务集成功能目前提供MongoDB、MySQL、Redis和InfluxDB服务。

点击服务图标，可以创建服务实例，具体步骤如下：

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-1.png)

1. 在DaoCloud控制台首页点击“服务集成”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-2.png)

2. 在“服务列表”中选择“MySQL”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-3.png)

3. 点击“创建服务实例”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-4.png)

4. 输入服务实例名称并选择配置。目前我们提供了从50MB到200MB不等的数据容量，可供绝大多数应用正常使用。

5. 点击“创建“，DaoCloud将在云平台为您部署相应的服务实例

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-5.png)

6. 创建成功，进入服务实例页面。

在服务实例的页面中，可以查看服务参数，链接地址、密码，绑定应用情况和删除服务实例。

---

DaoCloud服务市场还将陆续集成各类第三方SaaS化服务，目前提供了New Relic服务（见下图）。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/service-6.png)

创建New Relic服务实例，输入` APP_NAME 和 LICENSE_KEY` 后，将返回 `NEW_RELIC_APP_NAME` 和 `NEW_RELIC_LICENSE_KEY` 参数，用于和应用绑定。

DaoCloud会很快增加更多实用的SaaS化服务，如果您有感兴趣的服务希望我们集成，请来信告知。

> 友情提醒：请勿在这个环境中保存任何重要数据，请做必要的备份