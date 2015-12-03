<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
   <title>慕慕游戏</title>
    <link href="/css/www/weixin_css.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/www/png.js"></script>
</head>

<body>

<div id="main">
    <div class="main_cot">

        <div id="header_more"><a href="http://dwz.cn/ZsnnV"><img src="http://image2.yuanfenba.net/uploads/oss/photo/201507/16/21134387344.jpg" /></a></div>
        {foreach from=$mumu_youxi item=item name=foo}
        <a href="{$item.url}">
            <div class="member_li">
                <img src="{$item.pic}" >

                <p class="member_t1">{$item.title}</p>

                <p class="member_t2">{$item.text}</p>
                <div style=" height:2px; clear:both; font-size:0px;"> </div>
            </div>
        </a>
        {/foreach}
        <div style=" height:2px; clear:both; font-size:0px;"> </div>

    </div>
</div>

</body>
</html>
