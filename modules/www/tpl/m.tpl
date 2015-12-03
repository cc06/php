<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>秋千官网</title>
    <style type="text/css">
        body,div,p,ul,li,img,a,h1,h2,h3,h4,form,input,select,lable,table,tr,td,dl,dt,dd,ol {
            padding:0; margin:0;list-style:none;
        }
        body {
            font-family:"Microsoft yaHei";  background-color:#f9fafe;
        }
        .qq_xxt {
            position: absolute; bottom: 0;
        }
        .clear{
            clear:both; line-height:10px; height:0; overflow:hidden;
        }
        .wap_box {
            width:100%;max-width:750px;min-width: 320px;margin: 0 auto;
        }
        .box {
            height:auto; border-bottom:1px #e5e5e5 solid;
        }
        .wap_box .box001,.wap_box .box004 {
            width:100%; position:relative; height:auto;
        }
        .wap_box .box001 .down_btn {
            width:92%; position:absolute; bottom:5%; margin-left:4%;
        }
        .wap_box .box004 .down_btn {
            width:92%; position:absolute; bottom:40%; margin-left:4%;
        }

        .down_btn a.down_iphone {
            width:48%; float:left; margin-right:2%;
        }
        .down_btn a.down_android {
            width:48%; float:right;
        }
        .down_btn a img {
            width:100%;
        }
        .box img {
            width:100%;
        }
        .qq_info {
            width:60%; margin:0 auto 0 auto; padding-top: 6%; z-index: 1000; position: absolute; margin-left: 18%;
        }

        .wap_box .box004 {
            padding:8% 0;
        }
        .footetr_slg {
            width:70%; margin:0 auto;
        }
        .wap_box .box004 p {
            margin-top:28%; font-size:70%; color:#d4d4d4; text-align:center;
        }
    </style>
    <script src="http://image1.yuanfenba.net/h5/jquery.min.js"></script>
    <script src="http://image1.yuanfenba.net/h5/WebStat.js?4.js"></script>
</head>

<body>
<div class="wap_box">
    <div id="box001" class="box001 box">
        <div class="qq_info"><img src="/www/img/qq_info.png"/></div>
        <div class="qq_xxt"><img src="/www/img/qq_xx.jpg"/></div>
        <div class="down_btn">
            <a class="down_iphone" href="#"><img src="/www/img/iphone_btn.png"/></a>
            <a class="down_android" href="{$xiazai}" target="_blank"><img src="/www/img/android_btn.png" onclick='WebStat("{$c_uid}","{$c_sid}",1);'/></a>
        </div>
    </div>

    <div class="box002 box">
        <img src="/www/img/con01.jpg"/>
        <img  src="/www/img/con02.jpg"/>
    </div>

    <div class="box003 box">
        <img src="/www/img/con03.jpg"/>
        <img  src="/www/img/con04.jpg"/>
    </div>

    <div class="box004 box">
        <div class="footetr_slg"><img src="/www/img/footer_sgn.png"/></div>
        <div class="down_btn">
            <a class="down_iphone" href="#"><img src="/www/img/iphone_btn.png"/></a>
            <a class="down_android" href="{$xiazai}" target="_blank"><img src="/www/img/android_btn.png" onclick='WebStat("{$c_uid}","{$c_sid}",1);'/></a>
        </div>
        <p>京公网安备11010802018189号 北京炬鑫网络科技有限公司 </p>
    </div>

</div>
<SCRIPT LANGUAGE="JavaScript">
//alert($(window).height());
    document.getElementById('box001').style.height=$(window).height()+'px';
WebStat("{$c_uid}","{$c_sid}",11);

</SCRIPT>
</body>

</html>
