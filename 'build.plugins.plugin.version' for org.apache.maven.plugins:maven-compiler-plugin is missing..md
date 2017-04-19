# 'build.plugins.plugin.version' for org.apache.maven.plugins:maven-compiler-plugin is missing.

又是一篇以异常信息为标题的文章，这个错误信息出现在：使用maven-compiler-plugin 时，mvn install 输出的 warnig。

出现该警告信息的原因是，缺少版本信息，或版本信息不正确。

POM.xml 文件内容为：

```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-compiler-plugin</artifactId>
	<configuration>
		<source>1.8</source>
		<target>1.8</target>
	</configuration>
</plugin>
```
警告信息如下：
```
[WARNING]
[WARNING] Some problems were encountered while building the effective model for cn.wuzhuti:XXXX:jar:0.0.1-SNAPSHOT
[WARNING] 'build.plugins.plugin.version' for org.apache.maven.plugins:maven-compiler-plugin is missing. @ line 101, column 12
[WARNING]
[WARNING] It is highly recommended to fix these problems because they threaten the stability of your build.
[WARNING]
[WARNING] For this reason, future Maven versions might no longer support building such malformed projects.
[WARNING]
```

对照官网用法：[http://maven.apache.org/plugins/maven-compiler-plugin/usage.html ](http://maven.apache.org/plugins/maven-compiler-plugin/usage.html )

需要增加一行版本信息

```
<version>3.6.0</version>
```

修改后如下：

```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-compiler-plugin</artifactId>
	<version>3.6.0</version>
	<configuration>
		<source>1.8</source>
		<target>1.8</target>
	</configuration>
</plugin>
```

