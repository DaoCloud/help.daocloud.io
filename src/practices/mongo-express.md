![](http://blog.daocloud.io/wp-content/uploads/2015/05/MongoDB.png)

## 什么是 **mongo-express**

mongo-express是使用Node.js和express实现的轻量级MongoDB管理程序，通过它您可以轻松管理您存储在MongoDB的数据。

DaoCloud平台有大量用户使用MongoDB服务，我们在镜像仓库中增加了Mongo Express工具，方便用户管理和维护MongoDB实例。

> *注意：目前在DaoCloud镜像仓库提供的monog-exress版本不支持授权认证，您启动mongo-express容器后，容器的URL是公开访问的。所以，您使用完毕后请立即“停止”容器，防止MongoDB数据被他人操作。*

## 如何创建 **mongo-express**

### 启动步骤

1. 从最新镜像启动mongo-express容器
2. 绑定一个需要管理的MongoDB服务实例，设置服务别名为“MongoDB”（绑定时的默认值）
3. 启动容器

### 具体的创建过程

#### 首先创建一个被管理的MongoDB服务实例（如果已有MongoDB实例，可跳过这个步骤）

1. 在控制台，点击“服务集成”
2. 在Dao服务中，点击MongoDB
3. 点击“创建服务实例”
4. 为服务实例命名，并点击“创建”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/mongo-express-1.jpg)

#### 接着，我们启动mongo-express容器

1. 在控制台，点击“镜像仓库”
2. 在示例中，点击“mongo-express”图标
3. 点击“部署新版本”
4. 为mongo-exress容器命名
5. 选择容器配置和运行环境
6. 点击“服务&环境”
7. 点击之前创建的MongoDB实例，显示“待绑定”
8. 在环境变量的服务别名中，输入MongoDB
9. 点击“立即部署”
10. 部署完成后，访问返回的URL，使用MongoDB-exress

![](http://blog.daocloud.io/wp-content/uploads/2015/05/mongo-express-2.jpg)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/mongo-express-3.jpg)

> ***Mongo Express的使用方式，请参考 [www.npmjs.com](https://www.npmjs.com/package/mongo-express)***