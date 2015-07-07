## 代码构建

开启您的 DaoCloud 之旅，从「代码构建」中点击「创建新项目」开始，这个动作包含了三个环节。

1. 设置代码源。
2. 添加持续集成服务。
3. 选择应用镜像发布位置。

我们采用一个 Sample App 来演示完整的项目创建和配置过程。这是一个使用 Golang + MongoDB 的小程序，大家可以从 GitHub 获得 [代码](https://github.com/DaoCloud/golang-mongo-sample) 并 Fork 到自己的 GitHub 仓库，然后我们就可以开始配置了。

### 具体步骤：

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-1.png)

1. 在 Dashboard 控制台点击「代码构建」。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-2.png)

2. 在「代码构建」右上角点击「创建新项目」。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-3.png)

3. 输入「项目名称」，项目名称只能包含英文数字、下划线 `_`、小数点 `.`、和减号 `-`，并且不能与现有项目重名。

4. 点击「设置代码源」，如果还未绑定 GitHub 账号登录，此时会跳出 GitHub 的 OAuth 登陆和授权界面，请根据要求完成授权。

5. DaoCloud 需要获取必要的 GitHub 读写权限，这是国际上绝大多数与 GitHub 对接的应用的通用做法，DaoCloud 将保证您代码的安全。

6. 授权完成后，界面会出现您在 GitHub 加入的所有组织，通过下拉菜单可以选择具体的代码仓库，在这个例子中，我们点击选择「golang-mongo-sample」。

7. 「持续集成」，如果您希望使用 DaoCloud 提供的 CI 服务，请将持续集成设置为已开启。（CI 的配置将在「配置持续集成」章节中详述）。

8. 设定「发布应用镜像」的目标位置，默认选择是镜像仓库，这是由 DaoCloud 提供的 Docker 镜像存储库，我们今后会支持 DockerHub 和第三方私有 Registry。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-4.png)

9. 点击「开始创建」，系统将自动根据您代码仓库主分支的最新代码启动第一次应用构建过程（标签为 dao_init_master）。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-6.png)

10. 完成以上的步骤，您已经成功关联了代码库，并开始了第一次 Docker 镜像的构建。

---

在项目清单列表中，您可以看到您的项目的构建状态，同时也会显示出代码来源、编程语言、CI 服务、构建时间和应用名称。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-7.png)

> 注意：我们强烈建议您在关联 GitHub 项目之前，确保您的 Dockerfile 可以在本地正常构建，Docker 镜像内的程序可以正常执行，以免增加在云端排错的难度。

---

点击项目名称，您可以进入项目的「持续集成」、「镜像构建」和「设置」选项卡。

* 持续集成页面提供了使用和触发 DaoCloud 持续集成的详细信息。
* 镜像构建，可以查看 Docker 镜像在构建过程中产生的实时日志，及时了解镜像构建时候出错的原因。
* 设置界面中，可以重新配置 CI 服务和镜像输出的位置，或删除该项目。

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-8.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-9.png)

![](http://blog.daocloud.io/wp-content/uploads/2015/05/code-10.png)

我们很容易注意到，在 DaoCloud 做 Docker 镜像的构建比在本地电脑要快很多，这得益于我们在网络拓扑、镜像存取加速等方面做的大量优化工作。这对于国内程序员来说，是非常有价值的用户体验提升，再也不用因为网络的原因，在屏幕前苦苦等待 Docker 镜像的构建了。

经过短暂的等待，项目的首次构建已经完成。DaoCloud 可以根据在 GitHub 代码库上的设置，完成由规则触发的自动构建 Docker 镜像。目前，DaoCloud 根据推送新的标签（Tag）来触发。如果在提交代码时，打了标签，DaoCloud 就认为这是一次发布需要自动构建镜像。我们也可以通过手工启动构建的方式以触发镜像的重新构建。

如下图，我们对「golang-mongo-sample」项目做了一些代码修改并提交后，在 Git 客户端推送了名为「v1release」的标签。这时 DaoCloud 会自动从 GitHub 获取代码，完成 docker 镜像的构建操作。这样的自动化触发，是通过 WebHook 机制完成的。我们可以在「golang-mongo-sample」项目的 GitHub 设置页中，看到这个 WebHook 回调的 URL。

> 警告：为了成功回调触发 CI 和构建，请勿修改这个 URL。

![](http://blog.daocloud.io/wp-content/uploads/2015/03/22222222.jpg)

至此，我们完成了项目的创建和构建触发设置。
