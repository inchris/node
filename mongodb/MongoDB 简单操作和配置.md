# MongoDB 简单操作和配置

## 启动参数

```shell
mongod  	: 启动程序命令
--dbpath 	: 的数据库存放路径
--logpath 	: 的日志文件路径
--logappend : 以追加方式，写日志文件
--auth      : 是否进行用户认证，加上后,MongoDB会使用用户认证方式登录。
--port      : 端口号，可以自定义，默认 27017
--fork      : 服务是否以后台运行的方式运行
```

例：

```
# 后台启动

mongod --fork --syslog

```
