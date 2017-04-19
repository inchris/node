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

## 打包

```shell
tar -zcvf /xiaowu/backup/wuzhuti.cn_20150101.tar.gz /xiaowu/wwwroot/wuzhuti
```

## 备份MySql

```shell
mysqldump --opt wp_wuzhuti -uroot -pWs5zhuoa@db|gzip > /xiaowu/backup/db.wp_wuzhuti_20150604.tar.gz
```

## 硬盘使用情况

```shell
df -lh
```

## 创建目录

```shell
mkdir /xiaowu/aaa
```

## 防火墙关闭端口

### 创建防火墙规则

```shell
iptables -A INPUT -p tcp --dport 21 -j DROP
```

### 保存防火墙规则
 
```shell
service iptables save
```

### 编辑防火墙规则

```shell
vim /etc/sysconfig/iptables
service iptables restart #重启
```

### linux 防火墙配置命令

1) 永久性生效，重启后不会复原

开启： chkconfig iptables on
关闭： chkconfig iptables off

2) 即时生效，重启后复原
开启： service iptables start
关闭： service iptables stop


### 查看日志

```shell 
tail  -n 20000 /var/log/messages |grep ER
```

**日志文件说明**

`/var/log/message`     系统启动后的信息和错误日志，是Red Hat Linux中最常用的日志之一
`/var/log/secure`     与安全相关的日志信息
`/var/log/maillog`     与邮件相关的日志信息
`/var/log/cron`     与定时任务相关的日志信息
`/var/log/spooler`     与UUCP和news设备相关的日志信息
`/var/log/boot.log`     守护进程启动和停止相关的日志消息 

## 任务计划

```shell
crontab -l  #列出任务计划列表
```

## FTP

###连接 

```shell
lftp user:password@127.0.0.1 
```

### 上传

```shell
put /root/a.txt

## 拷贝

复制文件夹内容

```shell
cp -rf /xiaowu/a/* /xiaowu/b
```

## 删除

删除文件夹

```shell
rm -rf /xiaowu/a
```

## 时间同步

date 查看时间命令

ntpdate 时间同步命令
ntpdate -u 授时服务器

ntp常用服务器：
中国国家授时中心：210.72.145.44
NTP服务器(上海) ：ntp.api.bz

美国：time.nist.gov 
复旦：ntp.fudan.edu.cn 
微软公司授时主机(美国) ：time.windows.com 
台警大授时中心(台湾)：asia.pool.ntp.org





