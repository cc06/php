<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=2.0" />
    <title>塔罗牌占卜爱情－慕慕</title>

    <link href="/css/www/css_zhanbu.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/js/www/png.js"></script>

    <script charset="utf-8" src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
    <style>
        form {
          /* background: url(/images/www/images_zhanbu/pai012.png) center 0 no-repeat ;*/
            width: 202px;
            height: 226px;
        }
        form input {
            width: 100%;
            height: auto;
            z-index: 9;
            filter: alpha(opacity=1,Style=1);
            opacity: 0.01;
        }
        .wei_pai01 {
            /*background: url(/images/www/images_zhanbu/pai012.png) center 0 no-repeat;*/
            width: 202px;
            height: 226px;
        }
        .cd-popup-container {
            position: relative;
            width: 90%;
            max-width: 400px;
            margin: 4em auto;
            background: #FFF;
            border-radius: .25em .25em .4em .4em;
            text-align: center;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            -webkit-transform: translateY(-40px);
            -moz-transform: translateY(-40px);
            -ms-transform: translateY(-40px);
            -o-transform: translateY(-40px);
            transform: translateY(-40px);
            /* Force Hardware Acceleration in WebKit */
            -webkit-backface-visibility: hidden;
            -webkit-transition-property: -webkit-transform;
            -moz-transition-property: -moz-transform;
            transition-property: transform;
            -webkit-transition-duration: 0.3s;
            -moz-transition-duration: 0.3s;
            transition-duration: 0.3s;
        }
        .cd-popup-container p {
            padding: 3em 1em;
        }
        .cd-popup-container .cd-buttons:after {
            content: "";
            display: table;
            clear: both;
        }
        .cd-popup-container .cd-buttons li {
            float: left;
            width: 50%;
        }
        .cd-popup-container .cd-buttons a {
            display: block;
            height: 60px;
            line-height: 60px;
            text-transform: uppercase;
            color: #FFF;
            -webkit-transition: background-color 0.2s;
            -moz-transition: background-color 0.2s;
            transition: background-color 0.2s;
        }
        .cd-popup-container .cd-buttons li:first-child a {
            background: #fc7169;
            border-radius: 0 0 0 .25em;
        }
        .no-touch .cd-popup-container .cd-buttons li:first-child a:hover {
            background-color: #fc8982;
        }
        .cd-popup-container .cd-buttons li:last-child a {
            background: #b6bece;
            border-radius: 0 0 .25em 0;
        }
        .cd-popup-container .cd-popup-close {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 30px;
            height: 30px;
        }
        .nan {
            margin: 0 15px;
            float: left;
            background: url(/images/www/images_zhanbu/nan02.png) center 0 no-repeat;
            width: 86px;
            height: 36px;
        }
        .nan2 {
            margin: 0 15px;
            float: left;
            background: url(/images/www/images_zhanbu/nan01.png) center 0 no-repeat;
            width: 86px;
            height: 35px;
        }
        .nv {
            margin: 0 15px;
            float: left;
            background: url(/images/www/images_zhanbu/nv02.png) center 0 no-repeat;
            width: 86px;
            height: 36px;
        }
        .nv2 {
            margin: 0 15px;
            float: left;
            background: url(/images/www/images_zhanbu/nv01.png) center 0 no-repeat;
            width: 86px;
            height: 35px;
        }
    </style>
</head>
<body >
<div id="main">

    <div class="header_more"><div class="pai01">
            <form   method="post" enctype="multipart/form-data" id="upload_form" class="form-horizontal" style="position: absolute; left: 0; top: 0;">
            <input id="file_name" class="wei_pai01" type="file" name="file_name" accept="image/*;capture=camera" onchange="doupload(this.value);">

    </form><div id="pai01"><img id="pai02" src="/images/www/images_zhanbu/pai01.png" /></div>
            <div id="pai03" style="position: absolute;left: 10px; top: 10px;"></div>
        </div><img src="/images/www/images_zhanbu/bj02.png"  /></div>


    <div class="count3">请选择您的性别？</div>
    <div class="magnify" style="text-align: center;">
       <div style="width: 232px; margin: auto;"><div id="nan" class="nan" onclick="xuanze('nan')"></div>
        <div id="nv" class="nv" onclick="xuanze('nv')"></div><input type="hidden" id="gender" name="gender"   value="" /></div>
    </div>

   <div class="love"><img src="/images/www/images_zhanbu/name.png" /></div>
    <div class="count">已有{rand(10000,50000)}人与最佳恋爱对象取得联系</div>

</div>
<div id="heikuang" style="display:none;position:absolute; text-align: center; padding-top: 200px;color: #ffffff; font-size: 16px; font-weight: bold; top:0; left:0; background-color: rgb(0, 0, 0); opacity: 0.5; " onClick="heikuang.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
    <img src="/images/www/images1/loading_d3.gif" /> 正在上传头像
</div>

<div id="xingbie_kuang" style="display:none;position:absolute; text-align: center; padding-top: 200px;color: #ffffff; font-size: 16px; font-weight: bold; top:0; left:0;  " onClick="xingbie_kuang.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
    <div class="cd-popup-container">
        <p style="color: #8f9cb5; font-weight: bold;">请选择性别</p>
        <a href="#" class="cd-popup-close img-replace" onClick="xingbie_kuang.style.display = 'none';" style="font-size: 12px;">关闭</a>
    </div>
</div>
<script type="text/javascript">

    document.getElementById('heikuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang').style.height=document.body.scrollHeight+"px";

    document.getElementById('xingbie_kuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('xingbie_kuang').style.height=document.body.scrollHeight+"px";

    var loadImageFile = (function () {
        if (window.FileReader) {
            var oPreviewImg = null, oFReader = new window.FileReader(),
                    rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;


            oFReader.onload = function (oFREvent) {
                if (!oPreviewImg) {
                    var newPreview = document.getElementById("pai03");
                    oPreviewImg = new Image();
                    oPreviewImg.style.width = (newPreview.offsetWidth).toString() + "px";
                    oPreviewImg.style.height = (newPreview.offsetHeight).toString() + "px";
                    //oPreviewImg.style.height = (newPreview.offsetWidth).toString() + "px";
                    newPreview.appendChild(oPreviewImg);
                }
                oPreviewImg.src = oFREvent.target.result;
            };


            return function () {
                var aFiles = document.getElementById("file_name").files;
                if (aFiles.length === 0) { return; }
               // if (!rFilter.test(aFiles[0].type)) { alert("You must select a valid image file!"); return; }
                oFReader.readAsDataURL(aFiles[0]);
            }


        }
        if (navigator.appName === "Microsoft Internet Explorer") {
            return function () {
               // alert(document.getElementById("file_name").value);
                document.getElementById("pai03").filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = document.getElementById("file_name").value;


            }
        }
    })();

    function doupload(v){
        document.getElementById("heikuang").style.display = "block";
        //alert(chu_height);
        //document.getElementById("pai02").style.display = "none";
        var filepath=v;
        var extStart=filepath.lastIndexOf(".");
        var ext=filepath.substring(extStart,filepath.length).toUpperCase();
       if (ext == "" ) {
          // alert("请添加照片");
           document.getElementById("heikuang").style.display = "none";
           return;
       } else {
           chu_width=document.getElementById('pai01').offsetWidth;
           chu_height=document.getElementById('pai01').offsetHeight;
           document.getElementById("pai03").style.width=parseFloat(chu_width)-20+"px";
           //document.getElementById("pai03").style.height=parseFloat(chu_height)-20+"px";
           document.getElementById("pai03").style.height=parseFloat(chu_width*9/8)-20+"px";
           loadImageFile();

           if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
              // alert("图片限于png,gif,jpeg,jpg格式");
             //  document.getElementById("heikuang").style.display = "none";
             //  return;
           }
       }
        if (document.getElementById('gender').value=="") {
            document.getElementById("xingbie_kuang").style.display = "block";
            //alert("请选择性别");
            document.getElementById("heikuang").style.display = "none";
            return;
        }
        $("#upload_form").ajaxSubmit({
            type: 'post',
            url: "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000" ,
            success: function(data){
// alert(data.msg);

                if(data.msg=="上传成功"){
                    window.location.href="/Pipei2/default?gender="+document.getElementById('gender').value+"&url="+data.res.file_http_path;
                }
            },
            error: function(XmlHttpRequest, textStatus, errorThrown){
                alert( "error");
            }
        });
    }
    function getSex(){
        var value="";
        var radio=document.getElementsByName("gender");
        for(var i=0;i < radio.length;i++){
            if(radio[i].checked==true){
                value=radio[i].value;
                break;
            }
        }
        return value;
    }
    function xuanze(xiebie){
        if (xiebie=="nan") {
            document.getElementById("nan").className= "nan2";
            document.getElementById("nv").className= "nv";
            document.getElementById('gender').value="2";
            doupload(document.getElementById('file_name').value);
        }
        if (xiebie=="nv") {
            document.getElementById("nan").className= "nan";
            document.getElementById("nv").className= "nv2";
            document.getElementById('gender').value="1";
            doupload(document.getElementById('file_name').value);
        }
    }
</script>

<!--网站尾部-->
<div class="footer"><span><img src="/images/www/images_zhanbu/mumulogo.png" width="33" height="33" /></span><span>Copyright © 2015 版权所有 慕慕 <br />
京ICP备15023151号-1</span><script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?c83598bb52c14a12d781e478ec016b38";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script></div>


</body>
</html>