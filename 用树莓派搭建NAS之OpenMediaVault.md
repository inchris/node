# 用树莓派搭建NAS之OpenMediaVault
## OpenMediaVault 简介

OpenMediaVault，由原 FreeNAS 核心开发成员 Volker Theile 发起的基于 Debian Linux 的开源 NAS 操作系统，主要面向家庭用户和小型办公环境，最近发布了针对树莓派的安装包。
官网地址：www.openmediavault.org

## 树莓派

本文中使用的树莓派为树莓派 3 代 B 型（Raspberry Pi 3）。

## 具体方法
本文主要介绍 Mac 系统的刷机方法，windows 方法之后可能会更新，敬请期待。。。

### 一、下载 OMV 系统包

官网下载地址：[Download | openmediavault](http://www.openmediavault.org/download.html) （可能需要翻墙下载）

我在百度网盘上传了几个版本，方便大家下载。
百度网盘下载地址：

### 二、img文件
下载完毕后得到压缩包，解压后得到img后缀的系统镜像文件。

```shell
gzip -d omv_3.0.41_rpi2_rpi3.img.gz
```

### 三、刷系统

插入树莓派SD卡，用df命令查看当前以挂载卷：

```shell
df -h

```

妈蛋写不下去了。。。

