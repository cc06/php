<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <title>秋千</title>
    <link href="/css/www/ad20150720_css.css" rel="stylesheet" type="text/css"/>

    <link rel="stylesheet" type="text/css" href="/css/css_pipei/normalize.css" />
    <link rel="stylesheet" type="text/css" href="/css/css_pipei/demo.css" />

    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="/css/css_pipei/component.css" />

    <!--[if IE]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>

<body>
<div id="add2">
    <div class="content">

        <div class="component">

            <div class="overlay">
                <div class="overlay-inner"></div>
            </div>

            <img id="shang_img" class="resize-image" src="{$url}" alt="image for resizing">

            <button class="btn-crop js-crop">截图<img class="icon-crop" src="img/crop.svg"></button>
            <button class="btn1"> - </button>
            <button class="btn2"> + </button>
        </div>
    </div>

    <script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="/js/component.js"></script>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".btn1").click(function(){
           #("shang_img").animate({width:"50%"});
            #("shang_img").animate({height:"50%"});
        });
        $(".btn2").click(function(){
            #("shang_img").animate({width:"100%"});
            #("shang_img").animate({height:"100%"});
        });
    });
</script>

</body>
</html>
