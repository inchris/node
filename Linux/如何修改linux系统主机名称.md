## 完成目标：

　　修改centos 7系统的主机名称

## 使用命令：

　　hostnamectl

```
[root@ossec-server ~]# hostnamectl --help
hostnamectl [OPTIONS...] COMMAND ...

Query or change system hostname.

  -h --help              Show this help
     --version           Show package version
     --no-ask-password   Do not prompt for password
  -H --host=[USER@]HOST  Operate on remote host
  -M --machine=CONTAINER Operate on local container
     --transient         Only set transient hostname
     --static            Only set static hostname
     --pretty            Only set pretty hostname

Commands:
  status                 Show current hostname settings
  set-hostname NAME      Set system hostname
  set-icon-name NAME     Set icon name for host
  set-chassis NAME       Set chassis type for host
  set-deployment NAME    Set deployment environment for host
  set-location NAME      Set location for host
```

要永久修改主机名，需要修改静态主机名：

```
[root@localhost ~]# hostnamectl --static set-hostname ossec-server
```

或者执行命令
```
[root@localhost ~]# hostnamectl set-hostname ossec-server
```

最后`reboot`一下即可。
