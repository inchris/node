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
docker imr image_id
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
docker start container
```


