<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <title>商品详情</title>
    <style type="text/css">
        body, div, p, ul, li, img, a, h1, h2, h3, h4, form, input, select, lable, table, tr, td, dl, dt, dd, ol
        {
            padding:0; margin:0;list-style:none;}
        body {
            font-family:"Microsoft yaHei"; }
        .clear {
            clear: both;
            line-height: 10px;
            height: 0;
            overflow: hidden;
        }

        .wap_center {
            width: 100%;
            max-width: 720px;
            min-width: 320px;
            margin: 0 auto;
            position: relative;
        }

        .sj_header img {
            width: 100%;
        }

        .yhq_buy {
            width: 92%;
            border-bottom: 1px #e5e5e5 solid;
            padding: 2% 4%;
        }

        .yhq_buy .buy_l {
            width: 35%;
            float: left;
            font-size: 160%;
            color: #fc615c;
        }

        .yhq_buy .buy_l i {
            width: 12%;
            display: inline-block;
            margin-left: 2%;
        }

        .yhq_buy .buy_l i img {
            width: 100%;
        }

        .yhq_buy .buy_r {
            width: 48%;
            float: right;
            color: #aaa;
            font-size: 14px;
        }

        .yhq_buy .buy_r span {
            padding-top: 2%;
            line-height: 35px;
        }

        .yhq_buy .buy_r a {
            display: inline-block;
            background-color: #fc615c;
            color: white;
            padding: 5% 14%;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            float: right;
        }

        .sp_info {
            padding: 4%;
        }

        .sp_info h3 {
            font-size: 14px;
            margin-bottom: 6px;
        }

        .sp_info h3 i {
            display: inline-block;
            float: left;
            background-color: #fc615c;
            width: 8px;
            height: 8px;
            border-radius: 3px;
            margin-top: 8px;
            margin-right: 5px;
        }

        .sp_info p {
            padding-left: 13px;
            line-height: 30px;
            color: #666;
            font-size: 14px;
        }

        .sp_info .info_box {
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="wap_center">
    <div class="sj_header"><img src="{$detail["pic"]}"/></div>
    <div class="yhq_buy">
        <div class="buy_l">{$goods_info["gold"]}<i><img src="/www/images/red_zuan.png"/></i></div>
        <div class="buy_r"><a href="javascript:void(0);" onclick="buy({$goods_info["id"]})">购买</a><span>库存 {$balance} 件</span></div>
        <div class="clear"></div>
    </div>

    <div class="sp_info">
        <div class="info_box">
            <h3><i></i>商品简介</h3>
                <p>{$detail["info"]}</p>
        </div>
        <div class="info_box">
            <h3><i></i>适用范围</h3>
            {foreach from=$detail["range"] item=item name=foo}
                <p>{$item}</p>
            {/foreach}
        </div>
        <div class="info_box">
            <h3><i></i>适用时间</h3>
            {foreach from=$detail["time"] item=item name=foo}
                <p>{$item}</p>
            {/foreach}
        </div>
        <div class="info_box">
            <h3><i></i>购买流程</h3>
            {foreach from=$detail["buy"] item=item name=foo}
                <p>{$item}</p>
            {/foreach}
        </div>
        <div class="info_box">
            <h3><i></i>使用流程</h3>
            {foreach from=$detail["user"] item=item name=foo}
                <p>{$item}</p>
            {/foreach}
        </div>
        <div class="info_box">
            <h3><i></i>说明</h3>
            {foreach from=$detail["tips"] item=item name=foo}
                <p>{$item}</p>
            {/foreach}
        </div>
    </div>
</div>
<script type="text/javascript" src="http://image1.yuanfenba.net/h5/browserType.js"></script>
<script type="text/javascript">
    var content = "你将消耗{$goods_info["gold"]}钻石购买“{$goods_info["title"]}”";
    var gold = {$goods_info["gold"]};
    {literal}
    function buy(id) {
        but = new Object();
        but.def = false;
        but.tip = "";
        but.cmd = "mall_buy";
        but.data = {id: id, content: content, glod: gold};
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
