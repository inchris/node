# 让Linux系统执行sudo时不用输密码

启用 sudo命令并让执行 sudo时不需要输入密码：
打开终端，先以 root 身份登录：

```
su root
```

然后执行：

```
visudo
```

在打开的文件中，找到下面这一行：

```
root ALL=(ALL) ALL
```

并紧帖其下面，添上自己，如我的用户名是： frank，则添上 ：

```
frank     ALL=(ALL)  ALL
```

![](http://ww2.sinaimg.cn/large/801b780ajw1f9kpxuk31uj20qm0c2wgg.jpg)

如果只做到这一步，然后保存，那么就能使用 sudo 命令了。要让执行时不需要输入密码，再找到下面这一句：

```
#%wheel  ALL=(ALL)         NOPASSWD: ALL
```
将光标移至“ # ”上面，按下X键，其实也就是把这句话的注释去掉，让这句话生效。

![](http://ww3.sinaimg.cn/large/801b780ajw1f9kq09qdxqj20ie03iq36.jpg)

最后按住“Shift+ ：”键（也就是Shift上档输入一个冒号），进入 vi的命令模式，输入“wq”两个字母（Write and quit）保存并退出编辑。
退出 vi 后，再执行：

```
gpasswd -a frank wheel
```

将你的用户（普通用户）调整至“ wheel ”用户组里面。这以后，就可以每次执行 sudo 命令时不再输入密码了。


