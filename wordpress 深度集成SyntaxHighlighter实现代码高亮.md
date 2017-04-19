# wordpress 深度集成SyntaxHighlighter实现代码高亮

作为软件开发类技术博客，不可缺少的功能就是代码高亮功能。网上也有很多插件可以实现代码高亮功能，如：[CodeColorer](http://wordpress.org/extend/plugins/codecolorer/) 、[WP-Syntax](http://wordpress.org/extend/plugins/wp-syntax/)、[WP-Code](http://wordpress.org/extend/plugins/wp-code/) 、[Crayon Syntax Highlighter](http://wordpress.org/extend/plugins/crayon-syntax-highlighter/)、[WP Code Highlight](http://wordpress.org/extend/plugins/wp-code-highlight)。这里不做过多评价。本文主要讲述深度集成 SyntaxHighlighter 实现代码高亮功能，而非插件形式。

本文使用的 SyntaxHighlighter 基础代码为早期版本，并非最新版（PS：github上当前最新已经是4.x版本，我使用的是早期1.x版本，并且代码经过精简处理）。没有使用最新代码的原因是早起代码功能精炼，功能已经可以满足日常需求。

## SyntaxHighlighter
SyntaxHighlighter是一个使用JavaScript编写的功能齐全的代码语法高亮的软件。
官网地址：http://alexgorbatchev.com/SyntaxHighlighter/
Github地址：https://github.com/syntaxhighlighter/syntaxhighlighter

![SyntaxHighlighter](http://wuzhuti.cn/wp-content/uploads/2016/12/frank-2016-12-05-19.22.13.png)

## 实现功能
1.在不破坏 TinyMCE 编写的标签结构前提下，实现代码高亮功能。

2.为 TinyMCE 增加格式类型，以便在 TinyMCE 可视化编辑器状态下快速设置格式。

3.前端代码高亮支持快速预览功能。

4.前端代码高亮展示，支持语言显示。

## 代码编写

### 前端高亮功能
目录结构如下

```
|--主题根目录
|--js
   |--SyntaxHighlighter.js
|--css
   |--SyntaxHighlighter.css
|--images
   |--ico_plain.gif
```

百度网盘打包下载链接: https://pan.baidu.com/s/1dF84pLf 密码: pief

下载后解压到主题根目录。

在主题js中增加如下代码

```js
$(function() { 
  dp.SyntaxHighlighter.HighlightAll('code');
  $('.highlighter').addClass('dp-highlighter');
});
```

### 后台 TinyMCE 扩展

主题 functions.php 中增加如下代码

```php
/* 
 * 增加TinyMCE增加功能-无主题博客提供
 * 文章链接：http://wuzhuti.cn/2729.html
 */
add_filter('tiny_mce_before_init', 'my_mce_before_init_insert_formats');
function my_mce_before_init_insert_formats($init_array) {
	$style_formats = array(
		array('title' => 'blank Link' ,
			'selector' => 'a' ,
			'classes' => 'blank-link'
		), 
		array('title' => 'code-java' ,
			'selector' => 'pre' ,
			'classes' => 'java' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'code-js' ,
			'selector' => 'pre' ,
			'classes' => 'js' ,
			'attributes' => array('title' => 'code')
		),
		array('title' => 'code-html' ,
			'selector' => 'pre' ,
			'classes' => 'html' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'code-jsp' ,
			'selector' => 'pre' ,
			'classes' => 'jsp' ,
			'attributes' => array('title' => 'code')
		),
		array('title' => 'code-xml' ,
			'selector' => 'pre' ,
			'classes' => 'xml' ,
			'attributes' => array('title' => 'code')
		),
		array('title' => 'code-sql' ,
			'selector' => 'pre' ,
			'classes' => 'sql' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'code-php' ,
			'selector' => 'pre' ,
			'classes' => 'php' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'ActionScript3' ,
			'selector' => 'pre' ,
			'classes' => 'as3' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Bash/shell' ,
			'selector' => 'pre' ,
			'classes' => 'shell' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'ColdFunsion' ,
			'selector' => 'pre' ,
			'classes' => 'cf' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'C#' ,
			'selector' => 'pre' ,
			'classes' => 'c-sharp' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'C++' ,
			'selector' => 'pre' ,
			'classes' => 'c' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Delphi' ,
			'selector' => 'pre' ,
			'classes' => 'delphi' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Diff' ,
			'selector' => 'pre' ,
			'classes' => 'diff' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Erlang' ,
			'selector' => 'pre' ,
			'classes' => 'erl' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Groovy' ,
			'selector' => 'pre' ,
			'classes' => 'groovy' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'JavaFX' ,
			'selector' => 'pre' ,
			'classes' => 'jfx' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Perl' ,
			'selector' => 'pre' ,
			'classes' => 'pl' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Plain Text' ,
			'selector' => 'pre' ,
			'classes' => 'text' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'PowerShell' ,
			'selector' => 'pre' ,
			'classes' => 'ps' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Python' ,
			'selector' => 'pre' ,
			'classes' => 'py' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Ruby' ,
			'selector' => 'pre' ,
			'classes' => 'ruby' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'Scala' ,
			'selector' => 'pre' ,
			'classes' => 'scala' ,
			'attributes' => array('title' => 'code')
		), 
		array('title' => 'VB' ,
			'selector' => 'pre' ,
			'classes' => 'vb' ,
			'attributes' => array('title' => 'code')
		));
	$init_array['style_formats'] = json_encode($style_formats);

	$init_array['theme_advanced_blockformats'] = "p,pre,address,div,h1,h2,h3,h4,h5,h6,blockquote,dt,dd,code,samp";

	return $init_array;
}
 
```
后台 TinyMCE 编辑器中出现快捷格式设置

![](http://wuzhuti.cn/wp-content/uploads/2016/12/frank-2016-12-05-21.00.47.png)

到此为止，代码高亮功能集成成功。如果在使用过程中遇到任何问题欢迎留言反馈，我会在第一时间帮助大家解决。


