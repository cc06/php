<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>慕慕交友</title>

    <link href="/css/h5/reset.css" rel="stylesheet" type="text/css" />
    <link href="/css/h5/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/js/www/png.js"></script>
    <link href="{$user.avatar_xiao}" rel="shortcut icon">
    <!--[if IE]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body >
<div class="top" style="display: none;">
    <a class="download_btn" href="http://dwz.cn/ZsnnV">下载APP</a>
    <a class="logo" href="http://dwz.cn/ZsnnV"><img src="/images/h5/ico_96.png"/></a>
</div>
<div class="user-box">
    <div class="head"><a href="http://dwz.cn/ZsnnV"><img src="{$user.avatar}"/></a></div>
    <h2>{$user.nickname}<span class="{if $user.gender==2}nv{else}nan{/if}">{if $user.gender==2}♀{else}♂{/if} {$user.age}</span></h2>
    <p>（慕慕号：{$user.uid}）</p>
    <div class="btn01"><a href="http://dwz.cn/ZsnnV">加为好友</a></div>
</div>
<div class="adci"><a href="http://dwz.cn/ZsnnV"><img src="/images/h5/adci.png"/></a></div>
<div class="user"><a href="http://dwz.cn/ZsnnV"><img src="/images/h5/user.jpg"/></a></div>
<div class="adci02">
    <h3>还有更多附近精彩</h3>
    <p>全在慕慕等你体验</p>
    <div class="xiazai"><a href="http://dwz.cn/ZsnnV">下载慕慕，立即体验</a></div>
</div>
</body>
</html>