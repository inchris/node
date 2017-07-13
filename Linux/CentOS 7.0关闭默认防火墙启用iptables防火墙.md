# CentOS 7.0关闭默认防火墙启用iptables防火墙

## 1、关闭firewall：

停止firewall

```shell
systemctl stop firewalld.service
```

禁止firewall开机启动

```shell
systemctl disable firewalld.service
```

查看默认防火墙状态（关闭后显示notrunning，开启后显示running）

```shell
firewall-cmd --state 
```

## 2、iptables防火墙（这里iptables已经安装，下面进行配置）

编辑防火墙配置文件

```shell
vi/etc/sysconfig/iptables
```

```
# sampleconfiguration for iptables service
# you can edit thismanually or use system-config-firewall
# please do not askus to add additional ports/services to this default configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT[0:0]
:OUTPUT ACCEPT[0:0]
-A INPUT -m state--state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -jACCEPT
-A INPUT -i lo -jACCEPT
-A INPUT -p tcp -mstate --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -jACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 8080-j ACCEPT
-A INPUT -j REJECT--reject-with icmp-host-prohibited
-A FORWARD -jREJECT --reject-with icmp-host-prohibited
COMMIT
```
`:wq!` #保存退出

备注：这里使用80和8080端口为例。***部分一般添加到“-A INPUT -p tcp -m state --state NEW -m tcp--dport 22 -j ACCEPT”行的上面或者下面，切记不要添加到最后一行，否则防火墙重启后不生效。

重启防火墙使配置生效

```shell
systemctlrestart iptables.service 
```

设置防火墙开机启动

```shell
systemctlenable iptables.service
```

