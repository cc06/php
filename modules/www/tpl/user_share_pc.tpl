<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>慕慕交友</title>
    <link href="/css/h5/reset1.css" rel="stylesheet" type="text/css" />
    <link href="/css/h5/style1.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="box">
    <div class="blank50"></div>
    <div class="left_box">
        <div class="web_title">
            <div class="logo"><a href="http://down.mumu123.cn/mumu/MuMu_1617_1000_11_1.010.apk"><img src="/images/h5/logo1.png"/></a></div>
            <h2>来自慕慕的个人资料</h2>
        </div>
        <div class="ciad"><img src="/images/h5/ciimg.png"/></div>
        <div class="down_btn"><a href="http://down.mumu123.cn/mumu/MuMu_1617_1000_11_1.010.apk"><img src="/images/h5/download_btn.png"/></a></div>
        <div class="android_ico"><img src="/images/h5/android_ico.png"/></div>
        <div class="code"><img src="/images/h5/mumu_code.png"/></div>
    </div>
    <div class="right_box">
        <div class="head">
            <a href="http://down.mumu123.cn/mumu/MuMu_1617_1000_11_1.010.apk"><img src="{$user.avatar}" width="140" height="140" style=" border-radius:50%;"/></a>
            <span><img src="{$user.avatar}" width="140" height="140" style=" border-radius:50%;"/></span>
        </div>
        <h2>{$user.nickname}<span  style="{if $user.gender==2}background-color: #ff63d1;{/if}">{if $user.gender==2}♀{else}♂{/if} {$user.age}</span></h2>
        <p>(慕慕号：{$user.uid})</p>
        <ul>
            <li><span>{$user.province}，{$user.city}</span>所在地</li>
            <li><span>{$user.interest}</span>爱好</li>
        </ul>
        <div class="xuanyan">
            <h3>爱情宣言</h3>
            <p>{$user.looking}</p>
        </div>
    </div>
    <div class="blank20"></div>
    <div class="footer">
        <a href="http://www.inmumu.com/">首页</a> <a href="http://www.inmumu.com/about">关于慕慕</a> <a href="http://www.inmumu.com/news">慕慕动态</a> <a href="http://www.inmumu.com/contact">联系我们</a> <a href="http://www.inmumu.com/jobs">加入我们</a>
        <p>Copyright © 2015 版权所有 慕慕 京ICP备15023151号-2 <br/>
            北京炬鑫网络科技有限公司 地址：北京市海淀区清河嘉园东区甲1号楼12层1205 电话：010-82830723</p>
    </div>
</div>
</body>

</html>