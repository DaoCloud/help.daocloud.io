DaoCloud支持持续集成（CI）服务

DaoCloud CI是我们自主研发的CI执行引擎，目前支持如下语言和服务：

- 语言：Golang、Python、Java
- 服务：MySQL、MongoDB、Redis

## 参照下面两步立刻触发第一次持续集成：

1. 配置脚本
2. Push代码

### 1. 准备持续集成需要的配置文件 

您可以通过在代码根目录放置一个daocloud.yml文件来配置您的测试任务，请参考[`daocloud.yml`的格式](daocloud-yml.html)以及我们维护在github上的[示例程序](https://github.com/DaoCloud?utf8=%E2%9C%93&query=sample)。

下面是一个配置文件示例：


```
＃which build image you want to use, you can select one from daocloud support list
image: daocloud/ci-golang:1.4
 
＃specify list of services you want to use during your test
services:
  - mysql
  - mongodb
 
＃specify environment variables 
env:
  - GOPATH = /go
  - MY_ENV = abc
 
＃which scripts you want to run for test
script:
  - sudo apt-get update
  - sudo apt-get -y install bzr
  - go get -t ./...
  - go test your-code
```

### 2. Push代码

对代码源的push操作将自动触发持续集成，例如：

```
git push
```

当push的最近一次commit信息中带有`[CI SKIP]`或者`[SKIP CI]`字段时，将略过此次push，不触发持续集成，例如：

```
git commit -m 'your message [CI SKIP]'
git push
```

注意：`[CI SKIP]`和`[SKIP CI]`不区分大小写，以下形式都是合法的：
```
[ci skip]
[CI SKIP]
[Ci Skip]
[ ci sKip ]
[CI SKIp ]
[Skip Ci]
[skip ci ]
```
