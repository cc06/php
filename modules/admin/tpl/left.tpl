<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{$_F['header']['keywords']}</title>


    <style type="text/css">
        body { margin: 0; padding: 0; background-color: #f3f3f3; }
        #left_panel { background-color: #F3F3F3; width: 180px; height: 100%; padding-top: 20px; }
        #left_panel ul { margin: 0; padding: 0; }
        /*#left_panel ul li { padding:5px; }*/
        #left_panel a:hover { background: #eee; color: #000; }
        #left_panel .on { background: #ddd; color: #000; }
        a { text-decoration: none; color: #666; padding: 5px; display: block; }
        a:focus { outline: none }
    </style>
</head>
<body>

<div id="left_panel">
    <div class="col-sm-12">
        <div class="list-group">
            {foreach from=$menuItems key=key item=item}
                <a target="right_panel" class="list-group-item" href="{$item.url}" hidefocus="true">
                    {$item.name}
                </a>
            {/foreach}
        </div>
    </div>
</div>

<script type="text/javascript">
    $('.list-group-item').click(function () {
        $('.list-group-item').removeClass('active');
        $(this).addClass('active');
    });
</script>
</body>
</html>
