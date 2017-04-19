# Linux 常用命令

## SSH Key

### 生成

```shell
ssh-keygen -t rsa
```

### 测试

```shell
ssh -T git@github.com
```

## 文件数量查看

```shell
ls -l | grep "^-" | wc -l
```

## 远程拷贝 scp

```shell
scp <local_file> <remote_username>@<remote_ip>:<remotte_floder>
```


