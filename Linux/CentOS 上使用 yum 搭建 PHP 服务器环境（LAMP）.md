# CentOS 上使用 yum 搭建 PHP 服务器环境（LAMP）

## Apache

### 安装

```shell
yum -y install httpd httpd-devel
```

### 启动

```shell
/etc/init.d/httpd start
```

此时输入服务器的IP地址，应该看到 apache 的服务页面，端口不输入，apache 默认就是使用 80 端口。

## MySQL

### 安装 

```shell
yum -y install mysql mysql-server
```

### 启动

```shell
/etc/init.d/mysqld start
```

## PHP

### 安装

```shell
yum -y install php php-devel
```

### 重启 Apache 使 php 生效

```shell
/etc/init.d/httpd restart
```

此时可在目录：`/var/www/html/` 下建立一个 PHP 文件

代码：

```php

<?php 
    phpinfo();
?>
```
然后访问这个文件，就能看到 PHP 的一些信息，`php.ini` 配置文件的路径可以在这个页面上找到。

### 安装 php 的扩展

```shell
yum install php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc
```

安装完成后需要再次重启 apache

```shell
/etc/init.d/httpd restart
```

测试 mysql 是否链接成功的 php 代码

```php
<?php
    $con = mysql_connect("10.0.@.@@","@@","@@");
    if (!$con) {
        die('Could not connect: ' . mysql_error());
    }
 
    mysql_select_db("mydb", $con);
 
    $result = mysql_query("SELECT * FROM sys_user");
 
    while($row = mysql_fetch_array($result)) {
        echo $row['UserName'] . " " . $row['PassWord'] . " " . $row['id'];
        echo "<br />";
    }
 
    mysql_close($con);
?>
```

把这段代码文件放到 `/var/www/html/` 目录就可以看到执行状况。

