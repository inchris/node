# Linux Tomcat 开机启动

**1.创建软链接文件**

```shell
ln –s /usr/local/tomcat/bin/startup.sh /etc/init.d/tomcat
```

**2.修改权限**

```shell
chmod +x tomcat
```

**3.修改链接文件**

添加到下面两句到 `#!/bin/bash` 后

```shell
# chkconfig: 2345 10 90
# description: myservice ....
```

其中：

`2345` 是默认启动级别，级别有0-6共7个级别。

* 等级0表示：表示关机
* 等级1表示：单用户模式
* 等级2表示：无网络连接的多用户命令行模式 　　
* 等级3表示：有网络连接的多用户命令行模式 　　
* 等级4表示：不可用 　　
* 等级5表示：带图形界面的多用户模式 　　
* 等级6表示：重新启动

`10` 是启动优先级，`90` 是停止优先级，优先级范围是0－100，数字越大，优先级越低。

**4.添加启动**

```shell
chkconfig --add tomcat
chkconfig tomcat on
```

**5.检查**

```shell
service tomcat start
```

或者

```shell
reboot
```

