<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=2.0" />
    <title>塔罗牌占卜爱情－慕慕</title>

    <link href="/css/www/css_zhanbu.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/js/www/png.js"></script>

    <link rel="stylesheet" type="text/css" href="/css/css_pipei/normalize.css" />
    <link rel="stylesheet" type="text/css" href="/css/css_pipei/demo.css" />

    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="/css/css_pipei/component.css" />

    <!--[if IE]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body >

<div id="main3">
    <div class="match_name"><span>{$user.nickname}</span>  是你最佳恋爱对象<br />
        想进一步联系吗</div>
    <div class="line"></div>

    <div class="pipei">
        <div id="pipei_left2" class="pipei_left" style="border-radius:50%;   overflow: hidden;  background-color: #aaaaaa; ">
            <div id="add3" style="position: relative;"></div>
        </div>
        <div class="pipei_t"><span>{rand(80,100)}</span>%缘份值<img src="/images/www/images_zhanbu/fate_line.png" /></div>
        <div id="pipei_right2"  class="pipei_right"><img src="{$user.avatar}" /></div>
        <div style=" height:2px; clear:both; font-size:0px;"> </div>
    </div>


    <div class="line"></div>
    <div class="match_contact" id="shijian2">不要错过缘分哦！<br />
        你还有<span>10</span>分<span>0</span>秒 来考虑是否和她进一步联系</div>
    <div class="btn"><a href="http://dwz.cn/ZsnnV"><img src="/images/www/images_zhanbu/btn004.png" /></a></div>
    <div class="match_data">他的资料<br />
        <span> 所在地：{$user.city}</span> <span> 年龄：{$user.age}</span>    <br />
        <span>身高：{$user.height}cm</span><span> 工作：{$user.job}</span> </div>

    <div class="line2"><img src="/images/www/images_zhanbu/fen_bg2.png" /></div>
</div>
<!--网站尾部-->
<div class="footer"><span><img src="/images/www/images_zhanbu/mumulogo.png" width="33" height="33" /></span><span>Copyright © 2015 版权所有 慕慕 <br />
京ICP备15023151号-1</span></div>

</body>
</html>