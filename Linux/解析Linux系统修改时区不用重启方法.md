# 解析Linux系统修改时区不用重启方法

时区的配置文件是/etc/sysconfig/clock。用tzselect命令就可以修改这个配置文件，根据命令的提示进行修改就好了。
 
但是在实际工作中，发现这种方式是不能够使得服务器上的时间设置马上生效的，而且使用ntpdate去同步时间服务器也不能够更改时间。即使你使用了 date命令手工设置了时间的话，如果使用ntpdate去进行时间同步的话，时间又会被改动到原来的错误时区的时间。而生产的机器往往是非常重要的，不能够进行重启等操作。
 
如果要修改时区并且马上生效，可以更换/etc/localtime 文件来实现。比如修改时区为中国上海，那么就可以使用如下的命令来使得时区的更改生效。

```shell 
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
 
然后最好使用下面的命令将更改写入bios。
 
```shell
hwclock
```

具体操作：

``` 
[root@localhost ~]# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
 
cp: overwrite `/etc/localtime'? y
 
[root@localhost ~]# date
 
Sat Feb 20 16:04:43 CST 2010
 
[root@localhost ~]# hwclock
 
Sat 20 Feb 2010 04:05:12 PM CST -0.474966 seconds
```


