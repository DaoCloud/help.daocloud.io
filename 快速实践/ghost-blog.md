![](http://blog.daocloud.io/wp-content/uploads/2015/05/ghost.png)

## Ghost博客是什么？

还在用WordPress做你的博客站点，你就OUT了！速度切换到Ghost，用MarkDown写出最有逼格的技术博客吧。 这个出自于WordPress前UX部门开发者/设计师John O’Nolan之手的博客系统，自2012年诞生之日起就被冠于类似“WordPress Killer” 、 the “new direction of blogging” 、 “the first exciting thing to happen to blogging in years”之类的头衔。

关于WordPress和Ghost的比较大家可以参见[WordPress VS Ghost](http://www.elegantthemes.com/blog/resources/wordpress-vs-ghost)（英文版）

如果你动心了的话，马上用1分钟在DaoCloud上部署一个属于你的高逼格Ghost博客吧！


## 如何部署Ghost博客？

> *提示：*

> *创建Ghost博客需要绑定MySQL数据库，如何创建MySQL数据库，请参考帮助文档**DaoCloud控制台**中的“创建和管理数据服务”。*
 
> *在创建Ghost博客之前，请在控制台的‘服务集成“中创建MySQL数据库实例，Ghost博客与数据库的绑定，需要使用mysql作为连接字符串的别名。*

### 在**镜像仓库**中选择**Ghost Blog**，点击**部署最新版本**

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-ghost-2.png)

### 给容器命名，此处命名为**ghost-blogger**，选择**服务&环境**绑定MySQL服务，切记此处需要使用mysql作为连接字符串的别名，然后点击**立即部署**

### 部署成功

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-ghost-4.png)

### 点击应用URL，现在您可以使用酷炫的Ghost博客系统开始您的博客之旅了！

![](http://blog.daocloud.io/wp-content/uploads/2015/05/app-ghost.png)