<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <title>商品列表</title>
    <style type="text/css">
        body, div, p, ul, li, img, a, h1, h2, h3, h4, form, input, select, lable, table, tr, td, dl, dt, dd, ol {
            padding: 0;
            margin: 0;
            list-style: none;
        }

        body {
            font-family: "Microsoft yaHei";
            background-color: #2d3e58;
        }

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

        .ka_list {
            padding: 3% 2%;
        }

        .ka_list ul li {
            width: 100%;
            background: url('/www/images/ka_bg.png') no-repeat scroll left top;
            background-size: 100%;
            margin-bottom: 12px;
        }

        .ka_list ul li .ka_info {
            width: 66.2%;
            float: left;
            padding: 2.8%;
        }

        .ka_list ul li .ka_info .sj_logo {
            width: 22%;
            float: left;
            margin-right: 3%;
        }

        .ka_list ul li .ka_info .sj_logo img {
            width: 100%;
            border-radius: 3px;
        }

        .ka_list ul li .ka_info h2 {
            font-size: 84%;
            color: white;
            margin-bottom: 8px;
            font-family: "Microsoft yaHei", Arial, Helvetica, sans-serif;
        }

        .ka_list ul li .ka_info p {
            font-size: 12px;
            color: white;
        }

        .ka_list ul li .cost {
            width: 26%;
            float: right;
            padding-top: 6%;
            padding-left: 2%;
            font-size: 122%;
            color: white;
            font-family: Arial, Helvetica, sans-serif;
        }

        .ka_list ul li .cost i {
            display: inline-block;
            width: 25%;
            float: left;
            margin-right: 4%;
        }

        .ka_list ul li .cost i img {
            width: 100%;
        }

        .my_diamond {
            width: 100%;
            position: fixed;
            bottom: 0;
            left: 0;;
            background-color: rgba(25, 26, 31, 0.2);
            color: #fc0;
            font-size: 128%;
            padding: 2%;
        }

        .my_diamond i {
            display: inline-block;
            width: 8%;
            float: left;
            margin-right: 2%;
            margin-left: 2%;
        }

        .my_diamond i img {
            width: 100%;
        }
    </style>
</head>

<body>
<div class="wap_center">
    <div class="ka_list">
        <ul>
            {foreach from=$goods_list item=item}
                <li onclick="openInfo({$item["id"]})">
                    <div class="ka_info">
                        <div class="sj_logo"><img src="{$item["pic"]}"/></div>
                        <h2>{$item["title"]}</h2>

                        <p>{$item["tip"]}</p>
                    </div>
                    <div class="cost">
                        <i><img src="/www/images/bai_zuan.png"/></i><span>{$item["gold"]}</span>
                    </div>
                    <div class="clear"></div>
                </li>
            {/foreach}
        </ul>
    </div>
</div>

<div class="my_diamond">
    <span style="width: 50px" onclick="goCharge()">
    <i><img src="/www/images/huang_zuan.png"/></i>
        {$goldcoin}</span>
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

    function goCharge() {
        but = new Object();
        but.def = false;
        but.tip = "";
        but.cmd = "cmd_mycharge";
        but.data = {};
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
