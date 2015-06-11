## 代码构建

与用户在Github上的Repository一一对应。在创建项目时，用户需要通过OAuth授权DaoCloud应用访问Github，获得代码的读取权限，并根据需要设置Webhook。“代码构建”的主要目的是完成docker image的构建，“代码构建”的输入是Github Repository，和代码文件夹中预先编写好的Dockerfile；“代码构建”的输出是构建完成的docker image。在构建的过程中，可以根据设定，执行CI，检测代码是否通过集成测试。

## 镜像仓库

是docker image存储的场所，也是Docker化方式交付软件的“目的地”。在技术上，“镜像仓库”是一个Docker Registry，目前DaoCloud支持DaoCloud自带的镜像仓库，也计划支持Docker Hub和企业私有Registry。“镜像仓库”中的陈列的项目分为两类，一类是用户的私有项目，是在“代码构建“中配置完成docker image build后，image（包括历史版本）的存储库；另一类是公有示例项目，这些是我们预制的一些比较成熟的docker化打包软件，可以直接在云上以docker化的方式部署和运行。

## 服务集成

应用的运行离不开后台的服务，随着互联网应用复杂度的提升，应用对服务的需求，从单一的关系型数据库，逐渐过渡到多种类型、自建和SaaS化服务相结合的模式。在DaoCloud系统中，“服务集成”提供了用户配置和初始化各类后台服务的功能，服务市场汇集了一系列来自于DaoCloud以及其他第三方SaaS提供商的热门应用服务，用户可以按需配置。配置初始化完成后的服务，会列出在“我的服务”Tab中，供后续与应用绑定。”服务集成“包括了如下三个类别：

- Dao服务：由DaoCloud运维的数据服务，目前支持MongoDB、MySQL、Redis和InfluxDB

- 第三方”SaaS服务”，集成了New Relic等服务，可以很容易与应用绑定，快速扩充中

- 我的服务：由用户创建的服务实例

## 加速器

即DaoCloud Mirror服务，基于Docker registry的mirror机制，只需要在Docker Daemon的配置文件中加入Mirror参数，即可在全局范围内透明的访问官方的Docker Hub，避免了对Dockerfile Image引用来源的修改。“加速器”章节会对此进行详细说明。

DaoCloud官方于2015年3月19日宣布Docker Hub Mirror服务永久免费。


## 用户中心

用户可进行用户属性的更改、设置，以及关联第三方服务。