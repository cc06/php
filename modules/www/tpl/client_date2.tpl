<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>秋千，咖啡交友</title>
    <style type="text/css">
 body,div,p,ul,li,img,a,h1,h2,h3,h4,form,input,select,lable,table,tr,td,dl,dt,dd,ol{ 
     padding:0; margin:0;list-style:none;}
 body {
     font-family:"Microsoft yaHei"; 
}
 .clear {
    height:0; line-height:0; clear:both;
}
.blank10 {
	height:10px; line-height:0; overflow:hidden;
}
.coffee_bigimg img {
	width:100%;
}
.kf_info {
	width:69%; margin:auto; padding-left:21%; padding-top:3%; padding-bottom:3%; margin-top:15px;
	
}
.kf_info H3 {
	font-size:90%; font-weight:normal;margin-bottom:5px;
}
.kf_info p {
	font-size:75%; color:#999;
}
.kf_info p b {
	color:#fc615c;
}
.zongzhi {
	background:url('/www/images/kf_001.png') no-repeat scroll center center;  background-size:100%;
}
.didian {
	background:url('/www/images/kf_002.png') no-repeat scroll center center;  background-size:100%;
}
.go_map {
	text-align:center; margin:10% 0;
}
.go_map a {
	font-size:100%; color:#53aff4; text-decoration:none;
}
.coffee_shop {
	width:85%; margin:15% auto 7% auto;
}
.coffee_shop img {
	width:100%;
}
.warm {
	width:85%; margin:0 auto;
}
.warm h4  {
	
}
.warm h4 img {
	width:100%;
}
.warm p {
	font-size:75%; color:#333; margin:5% 0;
}

</style>

</head>

<body>
<div class="coffee_bigimg" >
  <a href="javascript:void(0);" onclick="info()"><img src="/www/images/coffee_bigimg.jpg"/></a>
 </div>
 <div class="kf_info zongzhi">
  <h3>咖啡交友宗旨</h3>
  <p>秋千为有意向见面的用户提供了官方推荐的咖啡厅。
      {$user["city"]}已有<b>{$date_num}</b>人见面</p>
 </div>
 <div class="kf_info didian">
  <h3>官方见面地点均为知名连锁店</h3>
  <p>安全、便捷、让陌生的人成为认识的人<br/>
{$user["city"]}共有<b>{$place_num}</b>个官方推荐见面地点</p>
 </div>
 <div class="go_map">
  <a href="javascript:void(0);" onclick="nav()">查看附近见面地点&gt&gt</a>
 </div>
 <div class="coffee_shop"><img src="/www/images/kft.jpg"/></div>
 
 <div class="warm">
  <h4><img src="/www/images/warm_title02.png"/></h4>
  <p>如果你也想与TA见面， 私聊成功后即可使用咖啡交友！</p>
 </div>
<script type="text/javascript">

    var base_url = "{$base_url}";
    {literal}
    function info() {
        but = new Object();
        but.def = false;
        but.tip = "";
        but.cmd = "client_date";
        but.data = {url: base_url+"/client/dateInfo"};
        json_s = JSON.stringify(but);
        console.info(json_s);
        mumu.command(json_s);
        window.location("devzeng://login?name=zengjing&password=123456");
    }

    function nav(id) {
        but = new Object();
        but.def = false;
        but.tip = "";
        but.cmd = "client_nav";
        but.data = {};
        json_s = JSON.stringify(but);
        console.info(json_s);
        mumu.command(json_s);
    }
    {/literal}
</script>

</body>

</html>
