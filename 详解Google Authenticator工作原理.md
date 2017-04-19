#详解Google Authenticator工作原理

很多手机用户会使用 Google Authenticator（谷歌身份认证）来生成认证令牌，与传统单因子密码不同，其采用的是更安全的双因子（2FA two-factor authentication）认证。FA是指结合密码以及实物（信用卡、SMS手机、令牌或指纹等生物标志）两种条件对用户进行认证的方法。只需要在手机上安装如此高大上的密码生成应用程序，就可以生成一个随着时间变化的一次性密码，用于帐户验证，而且这个应用程序不需要连接网络即可工作。

实际上Google Authenticator采用的算法是TOTP（Time-Based One-Time Password基于时间的一次性密码），其核心内容包括以下三点：

* 一个共享密钥（一个比特序列）；
* 当前时间输入；
* 一个签署函数。

##共享密钥

共享密码用于在手机端上建立账户。密码内容可以是通过手机拍照二维码或者手工输入，并会被进行base32加密。

手工密码的输入格式如下：

``` 
xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx
```

包含该令牌的二维码的内容是一个URL：

```
 otpauth://totp/Google%3Ayourname@gmail.com?secret=xxxx&issuer=Googl
```

##时间输入(当前时间)

输入的时间值来自于手机本身，一旦我们获得密钥后，就无需与服务器再进行通信了。但是 ** 最重要一点是务必确保手机上的时间是正确的 ** ，因为往后的步骤服务器会多次重复使用之前得到的时间值，服务器只会认准这个值。进一步说，服务器会比对所有提交的令牌以确认哪一个是你输入并提交的。

##签署

签署所使用的方法是HMAC-SHA1。HMAC的全称是Hash-based message authentication code(哈希运算消息认证码)，以一个密钥和一个消息为输入，生成一个消息摘要作为输出，这里以SHA1作为消息输入。使用HMAC的原因是：只有用户本身知道正确的输入密钥，因此会得到唯一的输出。其算法可以简单表示为：

```
hmac = SHA1(secret + SHA1(secret + input))
```

事实上，TOTP是HMAC-OTP（基于HMAC的一次密码生成）的超集，区别是TOTP以当前时间作为输入，而HMAC-OTP以自增计算器作为输入，该计数器使用时需要进行同步。

##算法

首先，要进行密钥的base32加密。

虽然谷歌上的密钥格式是带空格的，不过base32拒绝空格输入，并只允许大写。所以要作如下处理：

``` 
original_secret = xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx

secret = BASE32_DECODE(TO_UPPERCASE(REMOVE_SPACES(original_secret))) 
```

第二步要获取当前时间值

这里使用的是UNIX time函数，或者可以用纪元秒。

``` 
input = CURRENT_UNIX_TIME()
```

在Google Authenticator中，input值拥有一个有效期。因为如果直接根据时间进行计算，结果将时刻发生改变，那么将很难进行复用。Google Authenticator默认使用30秒作为有效期(时间片)，最后input的取值为从Unix epoch（1970年1月1日 00:00:00）来经历的30秒的个数。

``` 
input = CURRENT_UNIX_TIME() / 30 
```

最后一步是进行HMAC-SHA1运算

```
original_secret = xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx  

secret = BASE32_DECODE(TO_UPPERCASE(REMOVE_SPACES(original_secret)))  

input = CURRENT_UNIX_TIME() / 30  

hmac = SHA1(secret + SHA1(secret + input))  
```

至此，2FA所需的两个因子都已准备就绪了。但是HMAC运算后的结果会是20字节即40位16进制数，应该没有人会愿意每次都输入这么长的密码。我们需要的是常规6位数字密码！

要实现这个愿望，首先要对20字节的SHA1进行瘦身。我们把SHA1的最后4个比特数（每个数的取值是0~15）用来做索引号，然后用另外的4个字节进行索引。因此，索引号的操作范围是15+4=19，加上是以零开始，所以能完整表示20字节的信息。4字节的获取方法是：

```
four_bytes = hmac[LAST_BYTE(hmac):LAST_BYTE(hmac) + 4] 
```

然后将它转化为标准的32bit无符号整数(4 bytes = 32 bit)：

```
large_integer = INT(four_bytes) 
```

最后再进行7位数(1百万)取整，就可得到6位数字了：

```
large_integer = INT(four_bytes)  

small_integer = large_integer % 1,000,000 
```

这也是我们最后要的目标结果，整个过程总结如下：

```
original_secret = xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx 

secret = BASE32_DECODE(TO_UPPERCASE(REMOVE_SPACES(original_secret))) 

input = CURRENT_UNIX_TIME() / 30 

hmac = SHA1(secret + SHA1(secret + input)) 

four_bytes = hmac[LAST_BYTE(hmac):LAST_BYTE(hmac) + 4] 

large_integer = INT(four_bytes) 

small_integer = large_integer % 1,000,000
```

原文链接：https://wuzhuti.cn/2488.html