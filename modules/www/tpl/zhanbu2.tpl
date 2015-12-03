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
<div id="main">

    <div class="header_more">
        <div class="pai02">
             <img id="shang_img" class="resize-image" src="{$url}" width="500" height="500" alt="image for resizing" style="border-radius:50%;">

            {*<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
            <script type="text/javascript" src="/js/component.js"></script>*}
        </div>
        <div class="pai03"><img src="/images/www/images_zhanbu/zhezhao2.png" /></div>
        <img src="/images/www/images_zhanbu/bj02.png"  />
    </div>


    <div class="count3" style="display: none;">放大图片往右拉</div>

    <div class="magnify" style="display: none;">
        <a href="#" class="magnify_left"  onclick="jianclick()"></a>
        <div id="bar0" class="magnify_h">
            <input type="range" id="trackBar" min="1" max="10" step="1" value="1" onchange="tuodong(this.value)"  />
            </div>
        <a  href="#" class="magnify_right"  onclick="jiaclick()"></a>
        <div style=" height:2px; clear:both; font-size:0px;"> </div>
    </div>

    <div class="btn"><img src="/images/www/images_zhanbu/btn001.png"  onclick="tijiao2()" /><a href="/Pipei/default"><img src="/images/www/images_zhanbu/btn002.png"  /></a></div>
    <div class="love"><img src="/images/www/images_zhanbu/name.png" /></div>
    <div class="count">已有{rand(10000,50000)}人与最佳恋爱对象取得联系</div>


</div>

<div id="main2" style="display: none;">
    <div class="match_name"><span>{$user.nickname}</span>  是你最佳恋爱对象<br />
        想进一步联系吗</div>
    <div class="line"></div>

    <div class="pipei">
        <div id="pipei_left1" class="pipei_left" style="border-radius:50%;   overflow: hidden;  background-color: #aaaaaa; ">
            <div id="add2" style="position: relative;"></div>
        </div>
        <div class="pipei_t"><span>{rand(80,100)}</span>%缘份值<img src="/images/www/images_zhanbu/fate_line.png" /></div>
        <div id="pipei_right1" class="pipei_right"><img src="{$user.avatar}" /></div>
        <div style=" height:2px; clear:both; font-size:0px;"> </div>
    </div>


    <div class="line"></div>

    <div class="match_contact" id="shijian1">不要错过缘分哦！<br />
        你还有<span>10</span>分<span>0</span>秒 来考虑是否和她进一步联系</div>
    <div class="btn"><a href="http://dwz.cn/ZsnnV"><img src="/images/www/images_zhanbu/btn003.png" /></a></div>
    <div class="count2">新用户注册就送100金币哦</div>

    <div class="match_data">她的资料<br />
        <span> 所在地：{$user.city}</span> <span> 年龄：{$user.age}</span>    <br />
        <br />
        <span>身高：{$user.height}cm</span>   <span> 工作：{$user.job}</span> </div>

    <div class="line2"><img src="/images/www/images_zhanbu/fen_bg2.png" /></div>
</div>

<div id="main3" style="display: none;">
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

<div id="heikuang" style=" display:none;z-index:1001;position:absolute; text-align: center; padding-top: 200px;color: #ffffff; font-size: 16px; font-weight: bold; top:0; left:0; background-color: rgb(0, 0, 0); opacity: 0.5; " onClick="heikuang.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
    <img src="/images/www/images1/loading_d3.gif" /> 正在加速匹配。。。
</div>
<script type="text/javascript">
    document.getElementById('heikuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang').style.height=document.body.scrollHeight+"px";

    chu_width=document.getElementById('shang_img').width;
    chu_height=document.getElementById('shang_img').height;

    function tuodong(num) {
        dangqian_width= chu_width*num;
        dangqian_height= chu_height*num;

        document.getElementById('shang_img').style.width=dangqian_width+"px";
        //document.getElementById('shang_img').style.height=dangqian_height+"px";
        document.getElementById('shang_img').style.height=dangqian_width+"px";
    }
    function jianclick() {
        dangqian_width= document.getElementById('shang_img').width-chu_width;
        dangqian_height= document.getElementById('shang_img').height-chu_height;

        if (dangqian_width>0) {
            document.getElementById('shang_img').style.width = dangqian_width + "px";
            document.getElementById('shang_img').style.height = dangqian_height + "px";
            document.getElementById('trackBar').value= parseFloat(document.getElementById('trackBar').value)-1;
        }
    }
    function jiaclick() {
        dangqian_width= document.getElementById('shang_img').width+chu_width;
        dangqian_height= document.getElementById('shang_img').height+chu_height;
        if (dangqian_width<=10*chu_width) {
            document.getElementById('shang_img').style.width = dangqian_width + "px";
            document.getElementById('shang_img').style.height = dangqian_height + "px";
            document.getElementById('trackBar').value= parseFloat(document.getElementById('trackBar').value) + 1;
        }
    }

    function tijiao2(){

        document.getElementById("heikuang").style.display = "block";
        setTimeout("tijiao()",5000);
    }

    function tijiao() {
        document.getElementById("heikuang").style.display = "none";
        /*dangqian_width= document.getElementById('shang_img').width/1.75;
        dangqian_height= document.getElementById('shang_img').height/1.75;
        dangqian_top= document.getElementById('resize-container').style.top;
        dangqian_left= document.getElementById('resize-container').style.left;
        dangqian_top=parseFloat(dangqian_top.substring(0,dangqian_top.length-2))/1.75;
        dangqian_left=parseFloat(dangqian_left.substring(0,dangqian_left.length-2))/1.75;*/

        dangqian_width= chu_width/1.75;
        dangqian_height= chu_width/1.75;
        dangqian_top=0;
        dangqian_left=0;

        document.getElementById('main').style.display="none";
        {if $gender == "2"}
        document.getElementById('main2').style.display="block";
        document.getElementById('add2').innerHTML='<img width="'+dangqian_width+'" style="margin: 0px" height="'+dangqian_height+'" src="{$url}"  class="img-rounded"/>';
        //alert(document.getElementById('pipei_right1').offsetWidth);
        document.getElementById('pipei_left1').style.height=document.getElementById('pipei_right1').offsetHeight+"px";

        document.getElementById('add2').style.top=dangqian_top+"px";
        document.getElementById('add2').style.left=dangqian_left+"px";
        window.setInterval(function(){ ShowCountDown("shijian1"); }, interval);
        {else}
        document.getElementById('main3').style.display="block";
        document.getElementById('add3').innerHTML='<img width="'+dangqian_width+'" style="margin: 0px" height="'+dangqian_height+'" src="{$url}"  class="img-rounded"/>';

        document.getElementById('pipei_left2').style.height=document.getElementById('pipei_right2').offsetHeight+"px";

        document.getElementById('add3').style.top=dangqian_top+"px";
        document.getElementById('add3').style.left=dangqian_left+"px";
        window.setInterval(function(){ ShowCountDown("shijian2"); }, interval);
        {/if}
    }

    var interval = 1000;
    function ShowCountDown(shijian)
    {
        var oCountDown = document.getElementById(shijian);
        var aSpan = oCountDown.getElementsByTagName("span");
        num=parseFloat(aSpan[0].innerHTML)*60+parseFloat(aSpan[1].innerHTML)-1;
        if (num>0) {
            aSpan[0].innerHTML = parseInt(num / 60);
            aSpan[1].innerHTML = num % 60;
        }
        //document.getElementById(shijian).innerHTML = "不要错过缘分哦！<br />你还有<span>08</span>分<span>09</span>秒 来考虑是否和她进一步联系";
    }
    //window.setInterval(function(){ ShowCountDown("shijian1"); }, interval);
</script>
</body>
</html>