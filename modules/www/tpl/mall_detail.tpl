<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <title>商品信息</title>
    <style type="text/css">
        body,div,p,ul,li,img,a,h1,h2,h3,h4,form,input,select,lable,table,tr,td,dl,dt,dd,ol{
            padding:0; margin:0;list-style:none;}
        body {
            font-family:"Microsoft yaHei"; }
        .clear{ clear:both; line-height:10px; height:0; overflow:hidden;}
        .wap_center {
            width:100%;max-width:720px;min-width: 320px;margin: 0 auto;position: relative;
        }
        .sp_con {
            border-bottom:1px #e5e5e5 solid; padding:3%;
        }
        .sp_con .sp_img {
            width:20%; float:left; margin-right:2%;
        }
        .sp_con h2 {
            font-size:16px; line-height:30px;
        }
        .sp_con p{
            font-size:14px; color:#ccc; line-height:35px;
        }
        .sp_con .sp_img img {
            width:100%; border-radius:3px;
        }
        .sp_con  span {
            float:right; margin-top:7%; padding-right:6%; display:inline-block; background: url('/www/images/go_img.png') no-repeat scroll right center; background-size:20%;
        }
        .sp_con  span a {
            text-decoration:none; color:#aaa;
        }
        .sp_cs {
            padding:4% 3%;  font-size:110%;
        }
        .sp_cs ul li {
            margin-bottom:35px;
        }
        .sp_cs ul li label {
            width:25%; color:#aaa;display:inline-block; float:left; clear:both;
        }
        .sp_cs ul li span {
            margin-right:15px;
        }
        .sp_cs ul li img {
            width:60%;
        }
    </style>
</head>

<body>
<div class="wap_center">
    <div class="sp_con" onclick="openInfo({$buy_info["goods_id"]})">
        <span><a href="javascript:void(0);" disabled="disabled">详情</a></span>
        <div class="sp_img"><img src="{$buy_info["pic"]}"/></div>
        <h2>{$buy_info["title"]}</h2>
        <p>{$buy["tm"]}</p>
        <div class="clear"></div>
    </div>

    <div class="sp_cs">
        <ul>
            {if $secrete["cardno"]}
                <li><label>序列号</label>{$secrete["cardno"]}</li>
            {/if}
            {if $secrete["password"]}
                <li><label>密码</label>{$secrete["password"]}</li>
            {/if}
            {if $secrete["barcode"]}
                <li><label>二维码</label><img src="{$secrete['barcode']}"/></li>
            {/if}
        </ul>
    </div>
</div>
<script type="text/javascript" src="http://image1.yuanfenba.net/h5/browserType.js"></script>
<script type="text/javascript">
    var base_url = "{$base_url}";
    {literal}
    function openInfo(id) {
        but = new Object();
        but.def = false;
        but.tip = "";
        but.cmd = "mall_info";
        but.data = {url: base_url + "?id=" + id};
        json_s = JSON.stringify(but);
        if (isIosDev()) {
            window.location.href = "devzeng://login?parm=" + json_s;
        }
        mumu.command(json_s);
    }
    {/literal}
</script>
</body>
</html>

