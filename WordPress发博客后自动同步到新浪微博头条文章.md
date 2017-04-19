# WordPress发博客后自动同步到新浪微博头条文章

这篇文章我是来还债的，之前答应了几个网友会写一篇“Wordpress 同步新浪微博头条文章”的博客，下面进入正题。

申请接口权限和前期准备工作，这里不做过多描述，如有问题请留言或直接请参考博主之前发表的文章 [WordPress发博客后自动同步到新浪微博](https://wuzhuti.cn/1771.html)。

![](https://wuzhuti.cn/wp-content/uploads/2016/11/2016-11-28-11.58.37.png)

![](https://wuzhuti.cn/wp-content/uploads/2016/11/2016-11-2812.09.47.png)

不幸的是：由于种种原因，我的接口没有审核通过，所以最终没有测试成功，先给出代码，如果你有接口权限，那么请自行测试。文章结尾我会给出测试方法。

注意：文中代码没有经过测试，使用前请谨慎测试。

![](https://wuzhuti.cn/wp-content/uploads/2016/11/frank-2016-11-30-10.59.19.png)

## 实现原理
在发布文章时，调用微博头条文章接口，实现博客文章与头条文章同步

## 接口文档简单说明

接口文档地址：http://open.weibo.com/wiki/2/proxy/article/publish

文档中使用 oauth2 授权方式，通过access_token 获得权限调用接口，为了适应Wordpress和代码编写简单，我们采用BaseAuth 授权方式。如果你对授权方式感兴趣，可以查看[REST API 安全设计指南](https://wuzhuti.cn/2518.html) 这篇文章。

## 代码编写

以下代码增加到自己主题的functions.php文件中。

```php
/** 
 * WordPress 同步文章到新浪微博头条文章 By 无主题博客 
 * 原文地址: http://wuzhuti.cn/1771.html 
 */  
function post_to_sina_weibo_toutiao($post_ID) {  
  if (wp_is_post_revision($post_ID)) return;//修订版本(更新)不发微博  
  $get_post_info = get_post($post_ID);  
  $get_post_centent = get_post($post_ID)->post_content;  
  $get_post_title = get_post($post_ID)->post_title;  
  if ($get_post_info->post_status == 'publish' && $_POST['original_post_status'] != 'publish') {  
    $appkey='3838258703';  
    $username='微博用户名';  
    $userpassword='微博密码';  
    $request = new WP_Http;  
    $status = '【' . strip_tags($get_post_title) . '】 ' . mb_strimwidth(strip_tags(apply_filters('the_content', $get_post_centent)) , 0, 132, '...') . ' 全文地址:' . get_permalink($post_ID);  
    $api_url = 'https://api.weibo.com/2/statuses/update.json';  
    $body = array(
        'title' => strip_tags($get_post_title),
        'content'=>strip_tags(apply_filters('the_content', $get_post_centent)),
        'cover'=>'',
        'summary'=>mb_strimwidth(strip_tags(apply_filters('the_content', $get_post_centent)) , 0, 110, '...')
        'text'>mb_strimwidth(strip_tags(apply_filters('the_content', $get_post_centent)) , 0, 110, '...')
        'source' => $appkey
    );  
    $headers = array('Authorization' => 'Basic ' . base64_encode("$username:$userpassword"));  
    $result = $request->post($api_url, array('body' => $body,'headers' => $headers));  
  }  
}  
add_action('publish_post', 'post_to_sina_weibo_toutiao', 0);//给发布文章增加一个分享微博头条文章的动作  
```

以上代码没有经过测试，大家谨慎使用，修改前做好文件备份工作。

## 测试方法

首先在网站根目录创建 test-sync-sina.php 文件，文件内容如下

```php
<?php
require( dirname( __FILE__ ) . '/wp-blog-header.php' );
$appkey='3838258703';
$username='微博用户名';  
$userpassword='微博密码';  
$request = new WP_Http;  
$api_url = "https://api.weibo.com/proxy/article/publish.json";
$body = array(
        'title' => '这里是头条文章标题',
        'content'=>'这里是文章内容，支持一些html标签，详细请参考接口文档说明',
        'cover'=>'http://tc.sinaimg.cn/maxwidth.2048/tc.service.weibo.com/images_ifanr_cn/8ce1b0abab02ecbe4ee0a722bc89d918.jpg',//封面
        'summary'=>'文章导语，巴拉巴拉',
        'text'>'这个是自动生成的短微博',
        'source' => $appkey
    );  
$headers = array('Authorization' => 'Basic ' . base64_encode("$username:$userpassword"));  
$result = $request->post($api_url, array('body' => $body,'headers' => $headers));

echo $result['body'];
```

因为我没有接口权限，所以我测试的结果是：

```js
{"error":"Insufficient app permissions!","error_code":10014,"request":"/proxy/article/publish.json"}
```

如果大家在操作过程中遇到什么问题，欢迎大家留言讨论。


