# SSH 免密码登陆
一、生成公钥和私钥
在客户端执行如下Shell代码

```
ssh-keygen -t rsa

```

默认在 `~/.ssh` 目录生成两个文件：
私钥：id_rsa
公钥：id_rsa.pub

二、导入公钥文件到服务器
1.复制公钥文件到服务器

```
scp ~/.ssh/id_rsa.pub user@host:~/id_rsa.pub
```

2.将公钥内容 追加到 authorized_keys 文件

```
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
```

3.修改权限（这个很重要）

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
4.测试免密登陆

```
ssh user@host
```
注意：第一次登陆可能需要yes确认。

完成以上操作，已经实现了ssh免密登陆，但是还不是最简单的办法。可以通过在客户端配置~/.ssh/config 文件实现更简单方便的登陆方式。

```
vi ~/.ssh/config
```
增加如下文本

```
Host  alias
        HostName 192.168.0.3
        Port 22
        User frank
        IdentityFile ~/.ssh/id_rsa
```

保存后我们可以直接通过别名(alias)登陆。

```
ssh alias
```

