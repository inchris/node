# CentOS服务器初始化设置

**1.配置网卡**

```shell
vi /etc/sysconfig/network-scripts/ifcfg-eth0
```

注：CentOS 7.x 文件名字有所不同

```
DEVICE=eth0
HWADDR=00:1C:25:BE:9E:83
TYPE=Ethernet
UUID=765cbf8a-b961-4e7c-9f2c-589ce81ca413
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
IPADDR=192.168.0.4
NETMASK=255.255.255.0
DNS1=192.168.0.1
GATEWAY=192.168.0.1
```

**2.更新操作系统**

```shell
yum update
```

**3.删除自带软件（如果存在）**

```shell
yum -y remove httpd* php* mysql-server mysql mysql-libs php-mysql
```

**4.必要依赖安装**

```shell
yum -y install wget vim git texinfo patch make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap diffutils
```

