
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
        html { -ms-touch-action: none;}
        html,body,header,section,footer,div,h1,h2,dl,dt,dd,ul,li,p,a,b,i{ margin: 0;padding: 0;box-sizing:border-box;-webkit-user-select:none;color: #fff;}
        html,body{ width:100%;height:100%;background: #000000;}
        body{ font-family: \5FAE\8F6F\96C5\9ED1,"Helvetica Neue", Helvetica, Arial, sans-serif;font-size:13px;}
        ul{ list-style: none;}
        a{ text-decoration: none;}
        .splice{ position: relative;left: -5px;line-height: 25px;}
        .btn-up{
            /*border-top: 3px solid #fff;border-right: 3px solid #fff;*/
            width: 10px;height: 10px;position: absolute;left:48%;
            left: -webkit-calc(50% - 5px);
            left: -moz-calc(50% - 5px);
            left: -ms-calc(50% - 5px);
            left: calc(50% - 5px);
            bottom: 15px;
            color:#fff;
            font-size: 16px;
            /*opacity:0;*/
            /*transform:;*/
            /*-webkit-transform:;*/
            -webkit-animation:'up' 1.8s ease 0s infinite normal;
            -ms-animation:up 1.8s ease 0s infinite normal;
            animation:up 1.8s ease 0s infinite normal;}
        .btn-blue{
            /*border-top: 3px solid #1375ea;*/
            /*border-right: 3px solid #1375ea;*/
            color:#1375ea;
        }
        /*向上滑动的标识*/
        @-webkit-keyframes up {
            0% {
                opacity: 0;
                -webkit-transform: translate3d(0, 8px, 0);}
            50% {
                opacity: 1;
                -webkit-transform: translate3d(0, 0, 0);}
            100% {
                opacity: 0;
                -webkit-transform: translate3d(0, -8px, 0);}
        }
        @-ms-keyframes up{
            0% {
                opacity: 0;
                -ms-transform: translate3d(0, 8px, 0);}
            50% {
                opacity: 1;
                -ms-transform: translate3d(0, 0, 0);}
            100% {
                opacity: 0;
                -ms-transform: translate3d(0, -8px, 0);}
        }
        @keyframes up{
            0% {
                opacity: 0;
                transform: translate3d(0, 8px, 0);}
            50% {
                opacity: 1;
                transform: translate3d(0, 0, 0);}
            100% {
                opacity: 0;
                transform: translate3d(0, -8px, 0);}
        }
        /*parts*/
        .parts{ position: absolute;width: 100%;height: 100%;overflow: hidden;}
        .part{ -webkit-transition: -webkit-transform 0.3s ease-out;
            -o-transition: -webkit-transform 0.3s ease-out;
            transition: -webkit-transform 0.3s ease-out;
            -webkit-transform: translate3d(0px, 100%, 0px);
            transform: translate3d(0px, 100%, 0px);
            width: 100%;height: 100%;position: absolute;top:0;left:0;overflow: hidden;background: #fff;}
        /*animation*/
        .moving {
            -webkit-transition: none 0 step-start;
            -o-transition: none 0 step-start;
            transition: none 0 step-start; }
        .part1{ }
        .part1 p,
        .part1 a{ color:#cddcf9;}
        .part1 a{ text-decoration: underline;}
        .bg-img{ width: 318px;height:218px;margin: 0 auto;}
        .bg-1{ margin-top:60px;background-size:320px; text-align: center;}
        .bg-1 img{ width: 30%;}
        .bg-2{ margin-top:50px;background-size:320px; text-align: center;}
        .bg-2 img{ width:100%;}
        .bg-3{ margin-top:50px;background-size:320px; text-align: center;}
        .bg-3 img{ width:100%;}
        .bg-3_1{ margin-top:50px;background-size:320px; text-align: center;}
        .bg-3_1 img{ width:100%;}
        .bg-4{ margin-top:60px;background-size:320px; text-align: center;}
        .bg-4 img{ width: 30%;}
        .p1-footer{ text-align: center;position: absolute;bottom: 0;width: 100%;}
        .part1 .p1-footer{ }
        .p1-footer a.btn{ width: 133px;
            height: 36px;
            background: #fff;
            color: #1e78e7;
            display: block;
            line-height: 36px;
            padding-left: 21px;
            margin: 18px auto 22px;
            position: relative;
            text-decoration: none;
        }
        .p1-footer a.btn2{ width: 133px;
            height: 36px;
            background: #1375ea;
            color: #fff;
            display: block;
            line-height: 36px;
            padding-left: 21px;
            margin: 18px auto 22px;
            position: relative;
            text-decoration: none;
        }
        .p1-footer a.btn span{ width: 22px;height: 22px;background-size:22px;display: block;position: absolute;top: 6px;left: 9px;}
        .p1-footer a.btn2 span{ width: 22px;height: 22px;background-size:22px;display: block;position: absolute;top: 6px;left: 9px;}

        .tit{ font-size: 200%;
            color: #9877ff;
            margin-top: 25px;
            padding-left: 11px;
            padding-right: 22px}
        .des{ color: #9d9d9d;
            font-size: 120%;
            padding:0 11px;
            margin-top: 5px;}
        .tit_d { font-size: 220%;
            color: #9877ff;
            margin-top: 25px;
            text-align: center;
        }
        .des_d { color: #9d9d9d;
            font-size: 180%;
            padding:0 11px;
            margin-top: 5px;
            text-align: center;
        }
        .pd20{ padding-bottom: 20px;}
        @media screen and (max-device-height:560px) {
            .tit{
                font-size: 20px;
                margin-top: 6px;
            }
            .des{
                font-size: 10px;
                margin-top: 4px;
            }
            .bg-1{ margin-top:10px;}
            .bg-2{ margin-top:5px;}
            .bg-3{ margin-top:5px;}
            .bg-4{ margin-top:5px;}
            .part1 .p1-footer{ height: 145px;}
        }
        .addci {
            position: absolute; bottom: 200px;
        }
        .addci img {
            width: 100%;
        }
        .down_btn {
            margin-top:30px;
        }
        .down_btn a {
            display:block; background-color:white; color:#9877ff; width:48%; height:50px; margin:0 auto; font-size:140%; padding:0 2%; line-height:50px;
        }
        .down_btn a i {
            display:inline-block; float:left; height:38px; margin-top:6px; margin-right:5%; margin-left:2%;
        }
        .down_btn a i img {
            width:38px;
        }
        .top-up {
            text-align:center;
        }
        .top-up a {
            color:white; font-size:130%; text-decoration:underline; line-height:45px;
        }
        .down_btn02 {
            margin-bottom: 48px;
        }
        .down_btn02 a {
            display:block; background-color:#9877ff; color:white; width:48%; height:50px; margin:0 auto; font-size:140%; padding:0 2%; line-height:50px;
        }
        .down_btn02 a i {
            display:inline-block; float:left; height:38px; margin-top:6px; margin-right:5%; margin-left:2%;}
        .down_btn02 a i img {
            width:38px;
        }

        .footer_btn a {
            display:block; background-color:#9877ff; color:white; font-size:150%; width:60%; margin:0 auto; padding:4% 0; margin-bottom:40px;
        }
    </style>
</head>

<body>
<div class="parts">
    <!--part1-->
    <section class="part part1">
        <div><img src="/images/h5/qixi/1bj.gif" style="width: 100%; height: 100%;" /></div>
        <div class="p1-footer">
            <div><img src="/images/h5/qixi/1-1.gif" style="width: 100%;" onclick="wxw_ceshi();" /></div>
          </div>
    </section>

    <!--part2-->
    <section class="part part2">

        <div class="p1-footer">

            <div class="btn-up btn-blue">∧</div>
        </div>
    </section>
    <section class="part part2">

        <div class="p1-footer">

            <div class="btn-up btn-blue">∧</div>
        </div>
    </section>

</div>
<script type="text/javascript" src="/images/m/ddt2.js"></script>
<script>
    var type = 'ios';
    var o = {
        ios:{
            c:'ios',
            p:'首页',
            pos:'底部',
            name:'iphone版下载'
        },
        wp:{
            c:'windowsphone',
            p:'首页',
            pos:'底部',
            name:'windowsphone版下载'
        },
        android:{
            c:'Android',
            p:'首页',
            pos:'底部',
            name:'Android版下载'
        }
    }
    window.onload = function() {
        pages = new PageSlide($('.parts'), 'Y');
        resize();
    }
    function wxw_ceshi(){

    }

    function handle(){
        window._CiQ10052 = window._CiQ10052 || [];
        window._CiQ10052.push(['_trackEvent', {
            type: 1,
            labels:[
                { '客户端':o[type].c},
                { '页面':o[type].p},
                { '位置':o[type].pos},
                { '按钮名称':o[type].name}
            ],
            values: [
                { '数量':1}
            ]
        }]);
        window.CClickiV3 && window.CClickiV3[10052] && window.CClickiV3[10052]._flushObserver(function(){});
    };
    document.querySelector('.btn').onclick = handle;
    document.querySelector('.btn2').onclick = handle;
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?c83598bb52c14a12d781e478ec016b38";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script>
    document.body.scrollHeight-"px";
</script>
</body>
</html>