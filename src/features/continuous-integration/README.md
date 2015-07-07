## 持续集成

DaoCloud CI 是我们自主研发的 CI 执行引擎，目前支持如下语言和服务：

* 语言：Golang、Python、Java
* 服务：MySQL、MongoDB、Redis

### 参照下面两步立刻触发第一次持续集成：

1. 配置脚本
2. 推送代码

#### 1. 准备持续集成需要的配置文件

您可以通过在代码根目录放置一个 `daocloud.yml` 文件来配置您的测试任务，请参考 [daocloud.yml 的格式](daocloud-yml.html) 以及我们维护在 GitHub 上的 [示例程序](https://github.com/DaoCloud?utf8=%E2%9C%93&query=sample)。

下面是一个配置文件示例：

<!-- TODO：和 YML 格式不一致，是否过期了？ -->

```
＃ The build image you want to use; you can select one from DaoCloud support list.
image: daocloud/ci-golang:1.4

＃ List of services you want to use during your test.
services:
  - mysql
  - mongodb

＃ Environment variables
env:
  - GOPATH = /go
  - MY_ENV = abc

＃ Scripts you want to run for the test
script:
  - sudo apt-get update
  - sudo apt-get -y install bzr
  - go get -t ./...
  - go test your-code
```

#### 2. 推送代码

对代码源的推送操作将自动触发持续集成，例如：

```shell
user$ git push
```

当所推送的最近一次提交信息中带有 `[CI SKIP]` 或者 `[SKIP CI]` 字段时，此次推送将不会触发持续集成，例如：

```shell
user$ git commit -m 'your message [CI SKIP]'
user$ git push
```

> 注意：`[CI SKIP]` 和 `[SKIP CI]` 不区分大小写，以下形式都是合法的：

```
[ci skip]
[CI SKIP]
[Ci Skip]
[ ci sKip ]
[CI SKIp ]
[Skip Ci]
[skip ci ]
```
