<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>秋千交友</title>
    <link href="/www/css/dynamic.css?1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="top">
    <div class="top_bg"><img src="/www/images/dy_bg2.jpg" /></div>
    <div class="top_ct">
        <div class="header">
<span>
<img src="{$user["avatar"]}" />
</span>
        </div>
        <div  class="naem">
            <span class="fm_left">{$user["nickname"]}</span><span class="fm_w">{*<img src="/www/images/dy_fm.png" />*}{$user["age"]}</span>
        </div>
        <div class="xiaozi">秋千id：{$user["uid"]}</div>
    </div>
</div>
<div class="cc">
    <a href="#" >
        <div class="cc_tt">{$dy["content"]}</div>
        <div class="cc_tu">
            {if $pic_arr}
            <ul>
                {foreach from=$pic_arr item=item}
                    <li><img src="{$item}" /></li>
                {/foreach}
            </ul>
            {/if}
        </div>
        <div  class="cc_laction">{$dy["location"]}</div>
    </a>
</div>
<div class="xz">
    <img src="/www/images/dy_bg.jpg" />
    <span><a href="#" >立即下载秋千交友</a></span>
</div>

<div class="xiazai">
    <div class="xiazai_l"><img src="http://image1.yuanfenba.net/oss/other/logo.png" /></div>
    <div class="xiazai_c">
        <h1>秋千交友</h1>
        同城附近白领交友
    </div >
    <div class="xiazai_r">

        <a href="#" >下载</a>
    </div>
</div>
</body>
</html>
