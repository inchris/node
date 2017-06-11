```
ping: unknown host www.baidu.com

```

## 解决方案：

如果某台Linux服务器ping不通域名, 如下提示:

> [root@localhost ~]# ping www.baidu.com
> ping: unknown host www.baidu.com

首先确定已经连接上路由器，并且路由器能够访问外网，可以通过访问网关进行确定

```
[root@localhost ~]# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=2.96 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=1.75 ms
```

如果确定网络没问题的情况下, 可以通过如下步骤寻找解决办法:

1) 确定设置了域名服务器, 没有的话, 建议设置Google的公共DNS服务, 它应该不会出问题的

```
[root@localhost ~]# cat /etc/resolv.conf

search localdomain
```

因为我的DNS没有设置所以导致了ping外网ping不通。将dns添加到该文件中

```
[root@localhost ~]# vi /etc/resolv.conf

search localdomain
nameserver 202.98.96.68
nameserver 61.139.2.69

```

2) 确保网关已设置

```
# grep GATEWAY /etc/sysconfig/network-scripts/ifcfg*
-------------------------------------------------------------------
/etc/sysconfig/network-scripts/ifcfg-eth0:GATEWAY=192.168.40.1
-------------------------------------------------------------------
```

如果未设置, 则通过如下方式增加网关:

```
route add default gw 192.168.40.1
```

或者手工编写/etc/sysconfig/network-scripts/ifcfg*文件后, 重启network服务:

service network restart

3) 确保可用dns解析

```
grep hosts /etc/nsswitch.conf
-------------------------------------------------------------------
hosts:      files dns
-------------------------------------------------------------------
```

如果以上哪个有问题, 修正后, 再测试, 应该就没问题了:

ping -c 3 www.baidu.com
PING www.a.shifen.com (220.181.6.175) 56(84) bytes of data.
64 bytes from 220.181.6.175: icmp_seq=0 ttl=50 time=9.51 ms
64 bytes from 220.181.6.175: icmp_seq=1 ttl=50 time=8.45 ms
64 bytes from 220.181.6.175: icmp_seq=2 ttl=50 time=8.97 ms
--- www.a.shifen.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 8.450/8.977/9.511/0.446 ms, pipe 2
