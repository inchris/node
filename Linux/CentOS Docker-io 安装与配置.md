# CentOS 7.x Docker 安装与配置

## yum 安装

```shell
yum -y install docker-io
```

## 配置

### 启动 

```shell
service docker startt
```

### 加入开机启动

```shell
chkconfig docker on
```

### 从 docker.io 下载 centos 镜像到本地

```shell
docker pull centos:latest
```

### 查看已下载镜像

```shell
docker images 
```

### 启动一个容器

```shell
docker run -i -t centos /bin/bash
```

### 删除镜像

```shell
docker imr <image_id>
```

**删除所有镜像**

``` shell
docker rmi $(docker images | grep none | awk'print $3' | sort -r)
```

### 查看所有镜像

```shell
docker ps -a
```

查看所有镜像，包括正在运行和停止的

### 开启一个容器

```shell
docker start <container_id>
```
### 查看容器日志

```shell
docker logs -f <容器名 or ID>
```

### 查看容器的root用户密码
 
```shell
docker logs <容器名 or ID> 2>&1 | grep '^User: ' | tail -n1
```

### 删除所有内容

```shell

docker rm $(docker ps -a -q)
```

### 删除单个容器

```shell
docker rm <容器名 or ID>
```

### 运行一个新容器，同时为它命名、端口映射、文件夹映射。以redmine镜像为例

```shell
docker run --name redmine -p 9003:80 -p 9023:22 -d -v /var/redmine/files:/redmine/files -v    /var/redmine/mysql:/var/lib/mysql sameersbn/redmine
```

### 一个容器连接到另一个容器&sonar容器连接到mmysql容器，并将mmysql容器重命名为db。这样，sonar容器就可以使用db的相关的环境变量了。
 
 ```shell
docker run -i -t --name sonar -d -link mmysql:db  tpires/sonar-server 
 ```


