开启您的DaoCloud之旅，从“代码构建”中点击“创建新项目”开始，这个动作包含了三个环节

- 设置代码源
- 添加持续集成服务
- 选择应用镜像发布位置

我们采用一个Sample App，来演示完整的项目创建和配置过程。这是一个使用Golang+MongoDB的小程序，大家可以从Github获得[代码](https://github.com/DaoCloud/golang-mongo-sample)，Fork到自己的Github Repo后，我们就可以开始配置了。

## 具体步骤：

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-1.png)

1. 在Dashboard控制台点击“代码构建”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-2.png)

2. 在“代码构建”右上角点击“创建新项目”

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-3.png)

3. 输入“项目名称”，项目名称只能包含英文字母，数字，中划线 -，下划线 _以及点，并且不能与已有项目重名

4. 点击“设置代码源”，如果不是使用Github账号登录，此时会跳出Github的OAuth登陆和授权界面，请根据要求完成授权

5. DaoCloud需要获取必要的Github读写权限，这是国际上绝大多数与Github对接的应用的通用做法，DaoCloud将保证您代码的安全

6. 授权完成后，界面会出现您的Github所有组织（Organizations），通过下拉菜单可以选择具体的Repository，在这个例子中，我们点击选择“golang-mongo-sample”

7. “持续集成”，如果希望使用DaoCloud提供的 CI服务，请将持续集成设置为已开启。（CI的配置将在“配置持续集成”章节中详述）

8. 设定“发布应用镜像”的目标位置，默认选择是镜像仓库，这是由DaoCloud提供的docker image存储库，我们今后会支持DockerHub和第三方私有Registry

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-4.png)

9. 点击“开始创建”，系统将自动根据您代码仓库的最新代码（Master分支）启动第一次应用构建过程（标签为dao_init_master）

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-6.png)

10. 完成以上的步骤，您已经成功关联了代码库，并执行了第一次docker image构建

---

在项目清单列表中，您可以看到您的项目的构建状态，同时也会显示出代码来源、编程语言、CI服务、构建时间和应用名称。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-7.png)

> 注意事项：

> 我们强烈建议您在关联Github项目之前，确保您的Dockerfile可以在本地正常build，docker image内的程序可以正常执行，以免增加在云端排错的难度

--- 

点击项目名称，您可以进入项目的“持续集成”、‘镜像构建“和设置Tab

- 持续集成页面提供了使用和触发DaoCloud持续集成的详细信息
- 镜像构建，可以查看docker image build过程中产生的实时logo，及时了解image build的出错原因
- 设置界面中，可以重新配置CI服务和镜像输出的位置，或删除该项目

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-8.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-9.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-10.png)

我们很容易注意到，在DaoCloud做docker image build，比在本地电脑要快很多，这得益于我们在网络拓扑、Docker Hub Mirror等方面做的大量优化工作。这对于国内程序员来说，是非常有价值的用户体验提升，再也不用因为网络的原因，在屏幕前苦苦等待docker image build了。

经过短暂的等待，项目的首次构建已经完成。DaoCloud可以根据在Github代码库上的设置，完成由规则触发的自动docker image build。目前，我们根据commit时的tag来触发。如果在commit 提交代码时，打了tag，我们就认为这是一次需要做docker image build的提交。我们也可以通过手工的方式，手动触发镜像的重新构建。

如下图，我们对“golang-mongo-sample”项目做了一些代码修改后，在Git客户端commit code时，加上了名为“v1release”的tag。这时，DaoCloud会自动从Github获取代码，完成docker image的build操作。这样的自动化触发，是通过webhook机制完成的。我们可以在“golang-mongo-sample”项目的Github setting页中，看到这个webhook回调的URL。*请勿修改这个URL*。

![](http://blog.daocloud.io/wp-content/uploads/2015/03/22222222.jpg)

至此，我们完成了项目的创建和构建触发设置。