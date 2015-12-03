
<!DOCTYPE html>
<html>
<head>
    <title>慕慕七夕</title>
    <meta name="keywords"
          content="慕慕,炬鑫科技,im,mumu,交友,婚恋,单身,android,app"/>
    <meta name="description"
          content="慕慕（mumu），是一款场景模式的社交APP，是单身朋友的聚集地，能让单身的你找到归宿，发现与你同城的单身朋友！"/>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, minimal-ui" />
    <style>
        /*全局控制*/
        body{ margin:0;padding:0;font-size:12px;font-family:"微软雅黑";-webkit-text-size-adjust:none;}
        html,body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td,p{ margin:0;padding:0;}
        html,body{ width:100%;height:100%;background: #000000;}
        input,select,textarea{ font-size:12px;line-height:16px;}img{ border:0;}ul,li{ list-style-type:none;}
        a{ color:#333;text-decoration:none;}
        a:hover{ text-decoration:underline;}
	/*显示样式*/
	.tab_type li { background-color: #DDDEDC;width: 100%;height: 200px;text-align: center;margin-bottom: 1px;}
        .tab_type li a{ display: block; font-weight: bold;}
        .tab_type li a:hover{ text-decoration: none;background-color:#D3B92A;}
        .tab_type li span{ margin:0 2px;}
        .t_f{ position: relative;top: -9px;font-size: 14px;}
        .t_n{ font-size: 18px;}
	/*重要样式*/
    #scrollDiv{ width: 100%;height: 400px;min-height: 25px;overflow: hidden;}

        .p1-footer{ text-align: center;position: absolute;bottom: 0;width: 100%;z-index:1003;}
    </style>
    <script src="http://libs.baidu.com/jquery/1.7.2/jquery.js" type="text/javascript"></script>
    <script src="/js/jquery-audioPlay.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>

<body>
<div class="tab_type">
    <!--核心代码 开始-->
    <div id="scrollDiv">
        <ul>
            <li id="ping1">
                <div style="position: relative;width: 100%; height: 100%;">
                <div><img src="http://image1.yuanfenba.net/h5/qixi/1bj.gif" style="width: 100%; height: 100%;" /></div>
                <div class="p1-footer">
                    <div><img src="http://image1.yuanfenba.net/h5/qixi/1-1.gif" style="width: 100%;" id="xiangxia1" /></div>
                </div>
                </div>
            </li>
            <li id="ping2">
                <div style="position: relative;width: 100%; height: 100%;">
                    <div><img src="http://image1.yuanfenba.net/h5/qixi/2bj.gif" style="width: 100%; height: 100%;" /></div>
                    <div style="position: absolute;top: 50px;width: 100%;z-index:1001;">
                        <div><img src="http://image1.yuanfenba.net/h5/qixi/2-1-0.gif" style="width: 85%; " /></div>
                        <div id="ping2_s1"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-1.gif" style="width: 85%; " onclick="xuaze(2,1);" /></div>
                        <div id="yin2_s1" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-1x.gif" style="width: 85%; "  /></div>
                        <div id="ping2_s2"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-2.gif" style="width: 85%; " onclick="xuaze(2,2);" /></div>
                        <div id="yin2_s2" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-2x.gif" style="width: 85%; "  /></div>
                        <div id="ping2_s3"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-3.gif" style="width: 85%; " onclick="xuaze(2,3);" /></div>
                        <div id="yin2_s3" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-1-3x.gif" style="width: 85%; "  /></div>
                        <input type="hidden" name="text2" id="text2" value="" />
                    </div>
                    <div class="p1-footer">
                        <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_1.gif" style="width: 100%;" id="xiangshang2" /></div>
                        <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_2.gif" style="width: 100%;" id="xiangxia2" /></div>
                    </div>
                </div>
            </li>
            <li id="ping3">
                    <div style="position: relative;width: 100%; height: 100%;">
                        <div><img src="http://image1.yuanfenba.net/h5/qixi/2bj.gif" style="width: 100%; height: 100%;" /></div>
                        <div style="position: absolute;top: 50px;width: 100%;z-index:1001;">
                            <div><img src="http://image1.yuanfenba.net/h5/qixi/2-2-0.gif" style="width: 85%; " /></div>
                            <div id="ping3_s1"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-1.gif" style="width: 85%; " onclick="xuaze(3,1);" /></div>
                            <div id="yin3_s1" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-1x.gif" style="width: 85%; "  /></div>
                            <div id="ping3_s2"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-2.gif" style="width: 85%; " onclick="xuaze(3,2);" /></div>
                            <div id="yin3_s2" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-2x.gif" style="width: 85%; "  /></div>
                            <div id="ping3_s3"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-3.gif" style="width: 85%; " onclick="xuaze(3,3);" /></div>
                            <div id="yin3_s3" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-2-3x.gif" style="width: 85%; "  /></div>
                            <input type="hidden" name="text3" id="text3" value="" />
                        </div>
                        <div class="p1-footer">
                            <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_1.gif" style="width: 100%;" id="xiangshang3" /></div>
                            <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_2.gif" style="width: 100%;" id="xiangxia3" /></div>
                        </div>
                    </div></li>
            <li id="ping4">
                   <div style="position: relative;width: 100%; height: 100%;">
                        <div><img src="http://image1.yuanfenba.net/h5/qixi/2bj.gif" style="width: 100%; height: 100%;" /></div>
                       <div style="position: absolute;top: 50px;width: 100%;z-index:1001;">
                           <div><img src="http://image1.yuanfenba.net/h5/qixi/2-3-0.gif" style="width: 85%; " /></div>
                           <div id="ping4_s1"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-1.gif" style="width: 85%; " onclick="xuaze(4,1);" /></div>
                           <div id="yin4_s1" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-1x.gif" style="width: 85%; "  /></div>
                           <div id="ping4_s2"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-2.gif" style="width: 85%; " onclick="xuaze(4,2);" /></div>
                           <div id="yin4_s2" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-2x.gif" style="width: 85%; "  /></div>
                           <div id="ping4_s3"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-3.gif" style="width: 85%; " onclick="xuaze(4,3);" /></div>
                           <div id="yin4_s3" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-3-3x.gif" style="width: 85%; "  /></div>
                           <input type="hidden" name="text4" id="text4" value="" />
                       </div>
                        <div class="p1-footer">
                            <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_1.gif" style="width: 100%;" id="xiangshang4" /></div>
                            <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_2.gif" style="width: 100%;" id="xiangxia4" /></div>
                        </div>
                    </div>
            </li>
            <li id="ping5">
                <div style="position: relative;width: 100%; height: 100%;">
                    <div><img src="http://image1.yuanfenba.net/h5/qixi/2bj.gif" style="width: 100%; height: 100%;" /></div>
                    <div style="position: absolute;top: 50px;width: 100%;z-index:1001;">
                        <div><img src="http://image1.yuanfenba.net/h5/qixi/2-4-0.gif" style="width: 85%; " /></div>
                        <div id="ping5_s1"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-1.gif" style="width: 85%; " onclick="xuaze(5,1);" /></div>
                        <div id="yin5_s1" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-1x.gif" style="width: 85%; "  /></div>
                        <div id="ping5_s2"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-2.gif" style="width: 85%; " onclick="xuaze(5,2);" /></div>
                        <div id="yin5_s2" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-2x.gif" style="width: 85%; "  /></div>
                        <div id="ping5_s3"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-3.gif" style="width: 85%; " onclick="xuaze(5,3);" /></div>
                        <div id="yin5_s3" style="display: none;"><img src="http://image1.yuanfenba.net/h5/qixi/2-4-3x.gif" style="width: 85%; "  /></div>
                        <input type="hidden" name="text5" id="text5" value="" />
                    </div>
                    <div class="p1-footer">
                        <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_1.gif" style="width: 100%;" id="xiangshang5" /></div>
                        <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/2_2.gif" style="width: 100%;" id="xiangxia5" /></div>
                    </div>
                </div>
            </li>
            <li id="ping6">
                <div style="position: relative;width: 100%; height: 100%;">
                    <div><img src="http://image1.yuanfenba.net/h5/qixi/2bj.gif" style="width: 100%; height: 100%;" /></div>
                    <div style="position: absolute;top: 30px;width: 100%;z-index:999;">
                        <div><img src="http://image1.yuanfenba.net/h5/qixi/3.gif" style="width: 80%; " onclick="window.location.href='http://dwz.cn/ZsnnV';" /></div>
                    </div>
                    <div class="p1-footer" style="bottom: 20px;z-index:1000;">
                       <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/3-2.gif" style="width: 50%;" onclick='location.reload();' /></div>
                        <div style="float: left; width: 50%;"><img src="http://image1.yuanfenba.net/h5/qixi/3-3.gif" style="width: 50%;" onclick='share();' /></div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <!--核心代码 结束-->
</div>
<audio id="anniu" style="display: none;"  controls="controls" src="images/h5/qixi/an.m4a"></audio>
<div id="heikuang" style="display:none;z-index: 1005;position:absolute; color: #ffffff; font-size: 16px; font-weight: bold; top:0; left:0; background-color: rgb(0, 0, 0); opacity: 0.8; " onClick="heikuang.style.display = 'none';heikuang2.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
</div>
<div id="heikuang2" style="display:none;z-index: 1006;position:absolute; text-align: center; padding-top: 200px;font-size: 16px; font-weight: bold; top:0; left:0;"  onClick="heikuang.style.display = 'none';heikuang2.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
    <img src="http://image1.yuanfenba.net/h5/qixi/4-1.gif" style="width: 80%;" />
</div>
<div id="fenxiang" style="display:none; position: absolute; top: 0; width: 100%;z-index: 1012;" onclick="document.getElementById('logo').style.display = 'none';document.getElementById('fenxiang').style.display = 'none';"><img src="http://image1.yuanfenba.net/yx/cs/20150810004/share_tip_2.png" alt="分享" style="width: 100%;" /></div>
<div id="logo" style="z-index: 1011;display:none;position:absolute; text-align: center; padding-top: 100px;color: #ffffff; width: 100%; font-size: 16px; font-weight: bold; top:0; left:0; background-color: #444444; opacity: 0.8;  " onclick="document.getElementById('logo').style.display = 'none';document.getElementById('fenxiang').style.display = 'none';" >
    <script>
        document.getElementById('logo').style.width=document.body.scrollWidth+"px";
        document.getElementById('logo').style.height=document.body.scrollHeight+"px";
        function share(){
            document.getElementById('logo').style.display = 'block';
            document.getElementById('fenxiang').style.display = 'block';
        }
    function xuaze(ping,num) {
        document.getElementById("ping"+ping+"_s1").style.display = "block";
        document.getElementById("ping"+ping+"_s2").style.display = "block";
        document.getElementById("ping"+ping+"_s3").style.display = "block";
        document.getElementById("yin"+ping+"_s1").style.display = "none";
        document.getElementById("yin"+ping+"_s2").style.display = "none";
        document.getElementById("yin"+ping+"_s3").style.display = "none";
        document.getElementById("ping"+ping+"_s"+num).style.display = "none";
        document.getElementById("yin"+ping+"_s"+num).style.display = "block";
        document.getElementById('text'+ping).value=num;

    }
</script>
<script>


    document.getElementById('heikuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang').style.height=document.body.scrollHeight+"px"
    document.getElementById('heikuang2').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang2').style.height=document.body.scrollHeight+"px"
    document.getElementById('scrollDiv').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping1').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping2').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping3').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping4').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping5').style.height=document.body.scrollHeight+"px";
    document.getElementById('ping6').style.height=document.body.scrollHeight+"px";
    /*重要脚本*/
    (function ($) {
        $.fn.extend({
            Scroll: function (opt, callback) {
                if (!opt) var opt = {};
                var _btnUp = $("#" + opt.up); //Shawphy:向上按钮
                var _btnDown = $("#" + opt.down); //Shawphy:向下按钮
                var _btnDown1 = $("#xiangxia1"); //Shawphy:向上按钮
                var _btnUp2 = $("#xiangshang2");
                var _btnDown2 = $("#xiangxia2");
                var _btnUp3 = $("#xiangshang3");
                var _btnDown3 = $("#xiangxia3");
                var _btnUp4 = $("#xiangshang4");
                var _btnDown4 = $("#xiangxia4");
                var _btnUp5 = $("#xiangshang5");
                var _btnDown5 = $("#xiangxia5");

                var _this = this.eq(0).find("ul:first");
                var lineH = _this.find("li:first").height()+1; //获取行高  此处我加了1 因为样式中用到了margin-bottom:1px 这个根据自己情况修改
                var line = opt.line ? parseInt(opt.line, 10) : parseInt(this.height() / lineH, 10); //每次滚动的行数，默认为一屏，即父容器高度
                var speed = opt.speed ? parseInt(opt.speed, 10) : 600; //卷动速度，数值越大，速度越慢（毫秒）
                var m = 0;  //用于计算的变量
                var count = _this.find("li").length; //总共的<li>元素的个数
                var upHeight = line * lineH;
                var showline = opt.showline;//显示多少行
                function scrollUp() {
                    if (!_this.is(":animated")) {  //判断元素是否正处于动画，如果不处于动画状态，则追加动画。
                        if (m < count) {  //判断 m 是否小于总的个数
                            var go_count = count-m-showline;
                            if((count-m)>showline){
                                if(go_count<line){
                                    m += go_count;
                                    upHeight =  go_count * lineH;
                                    _this.animate({ marginTop: "-=" + upHeight + "px" }, speed);
                                }else{
                                    m += line;
                                    upHeight =  line * lineH;
                                    _this.animate({ marginTop: "-=" + upHeight + "px" }, speed);
                                }
                            }else{


                            }
                        }
                    }
                }
                function scrollDown() {
                    if (!_this.is(":animated")) {
                        if(m>0){
                            if (m > line) { //判断m 是否大于一屏个数
                                m -= line;
                                upHeight =  line * lineH;
                                _this.animate({ marginTop: "+=" + upHeight + "px" }, speed);
                            }else{
                                upHeight =  m * lineH;
                                m -= m;
                                _this.animate({ marginTop: "+=" + upHeight + "px" }, speed);
                            }
                        }
                    }
                }
                _btnUp.bind("click", scrollUp);
                _btnDown.bind("click", scrollDown);

                _btnDown1.bind("click", function(){
                    document.getElementById("anniu").play();
                      scrollUp();
                });
                _btnUp2.bind("click", scrollDown);
                _btnDown2.bind("click", function(){
                        if (document.getElementById('text2').value) {
                            scrollUp();
                        } else {
                            document.getElementById("heikuang").style.display = "block";
                            document.getElementById("heikuang2").style.display = "block";
                        }
                    });

                _btnUp3.bind("click", scrollDown);
                _btnDown3.bind("click", function(){
                    if (document.getElementById('text3').value) {
                        scrollUp();
                    } else {
                        document.getElementById("heikuang").style.display = "block";
                        document.getElementById("heikuang2").style.display = "block";
                    }
                });
                _btnUp4.bind("click", scrollDown);
                _btnDown4.bind("click", function(){
                    if (document.getElementById('text4').value) {
                        scrollUp();
                    } else {
                        document.getElementById("heikuang").style.display = "block";
                        document.getElementById("heikuang2").style.display = "block";
                    }
                });
                _btnUp5.bind("click", scrollDown);
                _btnDown5.bind("click", function(){
                    if (document.getElementById('text5').value) {
                        scrollUp();
                    } else {
                        document.getElementById("heikuang").style.display = "block";
                        document.getElementById("heikuang2").style.display = "block";
                    }
                });

            }
        });
    })(jQuery);
    $(function () {
        $("#scrollDiv").Scroll({ line: 1, speed: 500,up: "btn1", down: "btn2",showline:1 });
    });
</script>

    <script>

        wx.config({
            debug: false,
            appId: '{$appId}',
            timestamp: {$timestamp},
            nonceStr: '{$nonceStr}',
            signature: '{$signature}',
            jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareAppMessage',
                'onMenuShareQQ',
                'onMenuShareWeibo'
            ]
        });

        wx.ready(function () {
            var shareData1 = {
                title: "七夕约TA！",
                desc: "七夕节上慕慕领取约会红包！！！",
                link: window.location.href,
                imgUrl: "http://image1.yuanfenba.net/h5/qixi/fm.gif"
            };
            wx.onMenuShareAppMessage(shareData1);
            var shareData2 = {
                title: "七夕约TA！七夕节上慕慕领取约会红包！！！",
                desc: "七夕节上慕慕领取约会红包！",
                link: window.location.href,
                imgUrl: "http://image1.yuanfenba.net/h5/qixi/fm.gif"
            };
            wx.onMenuShareTimeline(shareData2);
        });

        wx.error(function (res) {
            // alert(res.errMsg);
        });

        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?c83598bb52c14a12d781e478ec016b38";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
</body>
</html>