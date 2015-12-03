<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <title>秋千拼图</title>
    <link href="/www/css/sharePuzzle.css" rel="stylesheet" type="text/css" />


</head>

<body>
<div class="box">
    <div class="dbg"><img src="/www/images/bg.jpg" /></div>
    <div class="box_mini">
        {*<h1>太难了！我在玩秋千拼图</h1>*}
        <div class="box_tu">
            <img src="{$dy["pic"]}"  width="100%"/>
            <ul id="photo"></ul>
        </div>
        <div class="box_han">
            {if $join}
                <div><span>耗时：{$tm}秒</span></div>
                打败了{$ratio}%的其他用户
            {else}
                这个拼图游戏太难了，谁帮我拼一下
            {/if}
        </div>
        <div class="box_bt">
            {if $join}
                <a href="javascript:void(0);" id="playBUt">我也想试试</a>
            {else}
                <a href="javascript:void(0);" id="playBUt">帮帮他吧</a>
            {/if}

        </div>
    </div>
</div>
</body>
</html>
