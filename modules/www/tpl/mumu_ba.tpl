<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
   <title>慕慕插画</title>
    <link rel="stylesheet" href="/css/www/mumuba_style.css" />
    <script language="javascript" src="/js/www/png.js"></script>
    <script src="/js/js_mumuba/islider.js"></script>
    <script src="/js/js_mumuba/islider_desktop.js"></script>
</head>

<body>
<div id="heikuang" style="display:none;position:absolute;  top:0; left:0; background-color: rgb(0, 0, 0); opacity: 0.5;z-index:1000; " >
</div>
<div id="heikuang2" style="display:none;position:absolute;text-align:center; display: table-cell;vertical-align:middle;  top:0; left:0;  z-index:1001;" onclick='guan();'>

</div>
<div id="iSlider-effect-wrapper">
    <div id="animation-effect" class="iSlider-effect"></div>
</div>

<div id="dian" style="position: absolute; bottom: 20px; left: 0px; text-align: center; width: 100%;">
    <img src="/images/www/images1/touming.png" width="10" height="10" />
    <img src="/images/www/images1/touming2.png" width="10" height="10" />
</div>
<script>

    document.getElementById('iSlider-effect-wrapper').style.height=document.body.scrollHeight+"px";
    var domList = {$domList};
    var mouseX1= 0,mouseX2= 0;
    //all animation effect
    var islider1 = new iSlider({
        data: domList,
        dom: document.getElementById("animation-effect"),
        type: 'dom',
        duration: 2000,
        animateType: 'default',
        isAutoplay: false,
        isLooping: false
        // isVertical: true, 是否垂直滚动
    });
    islider1.bindMouse();

    document.getElementById('heikuang').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang').style.height=document.body.scrollHeight+"px";
    document.getElementById('heikuang2').style.width=document.body.scrollWidth+"px";
    document.getElementById('heikuang2').style.height=document.body.scrollHeight+"px";
    document.getElementById('tu-x').style.width=document.body.scrollWidth*0.9+"px";
    document.getElementById('tu-x').style.height=document.body.scrollHeight*0.9+"px";


    function weizhi() {
        mouseX1=event.targetTouches[0].clientX;
//alert(mouseX1);
    }
    function tu(url) {

        //mouseX2=event.targetTouches[0].clientX;
        //alert(mouseX1+"gggg"+mouseX2);
       //if (mouseX2==mouseX1) {
           document.getElementById('heikuang2').innerHTML = '<img id="tu-x" style="margin: auto;margin-Top:10px;width:90%;display: table-cell;vertical-align:middle;"  src="' + url + '"  />';
           document.getElementById("heikuang").style.display = "block";
           document.getElementById("heikuang2").style.display = "block";
           // alert(parseFloat(document.getElementById('tu-x').height));
          // setTimeout("tijiao()", 50);
      // }
    }

    function tijiao(){
        document.getElementById('tu-x').style.marginTop=(parseFloat(document.body.scrollHeight)-parseFloat(document.getElementById('tu-x').height))/2 + "px";


    }
    function guan(){
        document.getElementById("heikuang").style.display = "none";
        document.getElementById("heikuang2").style.display = "none";
    }

</script>
</body>
</html>
