<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>慕慕</title>
    <link href="/css/www/ad20150720_css.css" rel="stylesheet" type="text/css"/>

    <script charset="utf-8" src="/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
    <style>
        form {
            background: url(http://s.tudai.com/static/wapimages/wei_pai.png)0 0 no-repeat;
            width: 120px;
            height: 128px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        form input {
            width: 300px;
            height: 22px;
            z-index: 9;
            filter: alpha(opacity=1,Style=1);
            opacity: 0.01;
        }
        .wei_pai01 {
    background: url(http://s.tudai.com/static/wapimages/wei_pai.png)0 0 no-repeat;
    width: 120px;
    height: 128px;
    display: block;
    margin-left: auto;
    margin-right: auto;
    }
    </style>
</head>

<body>
<div id="add">

    <form   method="post" enctype="multipart/form-data" id="upload_form" class="form-horizontal">
         <input class="wei_pai01" type="file" name="file_name" accept="image/*;capture=camera" onchange="doupload(this.value);">
    </form>

</div>
<div id="heikuang" style="position:absolute; text-align: center; padding-top: 200px;color: #ffffff; font-size: 16px; font-weight: bold; top:0; left:0; background-color: rgb(0, 0, 0); opacity: 0.5; " onClick="heikuang.style.display = 'none';" onMouseOver="this.style.cursor='hand'" >
    <img src="/images/www/images1/loading_d3.gif" /> 正在上传头像
</div>
<script type="text/javascript">

    document.getElementById('heikuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang').style.height=document.body.scrollHeight+"px";


function doupload(v){
    document.getElementById("heikuang").style.display = "block";
    var filepath=v;
    var extStart=filepath.lastIndexOf(".");
    var ext=filepath.substring(extStart,filepath.length).toUpperCase();
    if(ext!=".BMP" && ext!=".PNG" && ext!=".GIF" && ext!=".JPG" && ext!=".JPEG"){
        alert("图片限于png,gif,jpeg,jpg格式");
        return;
    }

$("#upload_form").ajaxSubmit({
type: 'post',
url: "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000" ,
success: function(data){
// alert(data.msg);

if(data.msg=="上传成功"){
    window.location.href="/Pipei2/default?url="+data.res.file_http_path;
}
},
error: function(XmlHttpRequest, textStatus, errorThrown){
alert( "error");
}
});
}

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

</body>
</html>
