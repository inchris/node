# Bad owner or permissions on .ssh:config的解决

执行 `ssh -T git@github.com` 时，提示如下错误

```
Bad owner or permissions on /home/[user]/.ssh/config
fatal: The remote end hung up unexpectedly
```

是因为ssh config文件权限的问题，修改config文件权限即可。
在.ssh目录下，执行下面的命令：

```shell
sudo chmod 600 config
```
