### 各个代码托管商的功能支持

|remote   |commit_push|pull_request|private_repo|set_commit_status|tag_build|
|---------|-----------|------------|------------|-----------------|---------|
|github   |true       | true       |true        |true             |true     |
|bitbucket|true       | false      |true        |false            |false    |
|coding   |true       | false      |true        |false            |true     |
|gitcafe  |true       | false      |true        |false            |true     |
|gitlab   |true       | false      |true        |false            |true     |

#### 说明：

0. true: 支持 false: 不支持
1. commit_push: push 时自动持续集成。
2. pull_request: 创建、更新 pull request 时自动持续集成。不能支持这个主要是因为没有 git 接口获得代码。
3. private_repo: 获得私有项目代码。
4. set_commit_status: 设置 remote 上 commit 的状态，如 failed, success, error 等，只有 github 支持。
5. tag_build: push 一个 tag 时触发 build image。