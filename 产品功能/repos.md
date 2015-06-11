镜像仓库是保存docker image的一个内部registry。点击镜像仓库后，可以看到两类应用：“我的镜像”和“DaoCloud镜像”。

![](http://blog.daocloud.io/wp-content/uploads/2015/06/repos.png)

**我的应用**是用户在“代码构建”中构建的docker image的集合。我的应用以项目为单位，采用不同颜色的图标排列。点击图标，可以进入详细信息的查看页面。

![](http://blog.daocloud.io/wp-content/uploads/2015/06/repos-2.png)

**DaoCloud应用**是DaoCloud预置在商店中的一些sample app。目前我们已经上架了许多非常有趣的应用。示例应用是只读的，点击图标进入后，我们可以查看应用的概览，和应用的版本信息。点击“部署”按钮，可以把应用的docker image推送到云平台部署运行。

![](http://blog.daocloud.io/wp-content/uploads/2015/06/repos-daocloud.png)

**我们还可以在“设置”Tab中修改应用的名字。**

![](http://blog.daocloud.io/wp-content/uploads/2015/05/repo-change-name.png)

镜像仓库这个页面虽然比较简单，但是它体现了我们对Docker化应用的一个重要理念：**容器（或多个容器的组合）是互联网软件的标准交付件**。应用商店中的这些docker image，是随时可以一键执行的“交付件”，这极大的缩短了应用（或阶段性release）到客户交付的周期，可以更快的从客户获取反馈，快速迭代。