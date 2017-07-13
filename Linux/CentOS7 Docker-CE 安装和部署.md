本文中 Docker 使用的是 Docker-CE https://docs.docker.com/engine/installation/linux/docker-ce/centos/


### 安装 Docker

### 卸载旧版本

较旧版本的Docker被称为`docker`或`docker-engine`。 如果这些已安装，请卸载它们以及关联的依赖关系。

```
$ sudo yum remove docker \
                  docker-common \
                  docker-selinux \
                  docker-engine
```

### 使用存储库进行安装

在新主机上首次安装Docker CE之前，需要设置Docker存储库。 之后，您可以从存储库安装和更新Docker。

#### 设置 Docker CE 库

1.安装所需的软件包。 `yum-utils` 提供 `yum-config-manager` 实用程序, `devicemapper` 存储驱动程序需要`device-mapper-persistent-data` 和 `lvm2`。

```
$ sudo yum install -y yum-utils device-mapper-persistent-data lvm2
```

2.使用以下命令设置 **stable** 存储库。

```
$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

#### 安装 DOCKER CE

1.更新 yum 包索引。

```
$ sudo yum makecache fast
```

如果这是您添加Docker存储库后第一次刷新包索引，系统将提示您接受GPG密钥，并显示密钥的指纹。 验证指纹是否正确，如果是，请接受密钥。 指纹应符合`060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35`。

2.安装最新版本的Docker CE，或者转到下一步安装特定版本。

```
sudo yum install docker-ce
```

** 目前 Docker CE 只能在 centos7 上安装，而我的系统是 Centos6.8， 所以到这一步时，出现安装错误，报错信息如下：

````
Loaded plugins: security
Setting up Install Process
Resolving Dependencies
--> Running transaction check
---> Package docker-ce.x86_64 0:17.06.0.ce-1.el7.centos will be installed
--> Processing Dependency: container-selinux >= 2.9 for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libsystemd.so.0(LIBSYSTEMD_209)(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: systemd-units for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libc.so.6(GLIBC_2.17)(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libcgroup for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libseccomp.so.2()(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libsystemd.so.0()(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Running transaction check
---> Package docker-ce.x86_64 0:17.06.0.ce-1.el7.centos will be installed
--> Processing Dependency: container-selinux >= 2.9 for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libsystemd.so.0(LIBSYSTEMD_209)(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: systemd-units for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libc.so.6(GLIBC_2.17)(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libseccomp.so.2()(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
--> Processing Dependency: libsystemd.so.0()(64bit) for package: docker-ce-17.06.0.ce-1.el7.centos.x86_64
---> Package libcgroup.x86_64 0:0.40.rc1-23.el6 will be installed
--> Finished Dependency Resolution
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: libseccomp.so.2()(64bit)
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: libc.so.6(GLIBC_2.17)(64bit)
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: systemd-units
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: container-selinux >= 2.9
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: libsystemd.so.0(LIBSYSTEMD_209)(64bit)
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: libsystemd.so.0()(64bit)
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest
```
