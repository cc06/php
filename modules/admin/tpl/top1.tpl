<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{$_F['header']['keywords']}</title>
    <style type="text/css">
        body { background-color: #1C86D1; padding: 0; margin: 0; }
        .top_bar { color: #fff; height: 40px;; }
        .top_bar a { color: #fff; text-decoration: none; }
        .u_info { position: absolute; right: 0; top: 0; height: 40px; line-height: 40px; padding: 0 10px; }
        #top-menus { position: absolute; left: 200px; top: 0; width: 600px; }
        #top-menus a { background: transparent; display: block; float: left; height: 40px; line-height: 40px; padding: 0 10px; text-decoration: none; /*border: red 1px solid;*/ }
        #top-menus a.current { background: #fff; color: #000; }
        .logo { cursor: pointer; position: relative; padding-left: 10px; height: 40px; font: 25px/30px Arial, Helvetica, sans-serif; line-height: 40px; }
    </style>
    <script src="/js/jquery-1.7.1.min.js"></script>
    <script src="/js/flib.js"></script>
</head>

<body>

<div class="top_bar">
    <div class="logo" onclick="top.location = '/admin';">
        秋千后台
    </div>
    <div id="top-menus">
        {foreach from=$top_menus item=top_menu}
        &nbsp; <a href="/admin?c=Main&a=left&menu={$top_menu.menu}" target="left_frame">{$top_menu.name}</a>
        {/foreach}
    </div>
    <div class="u_info">
        {$_F['member']['username']}，
        <a target="_top" href="/admin/auth/logout">退出</a>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        var top_menu_a = $('#top-menus').find('a');
        top_menu_a.click(function () {

//            var url_link = $(this).attr('href');

            top_menu_a.removeClass();
            $(this).addClass('current');

            var main_frame = parent.document.getElementById("main_frame");
            if (main_frame) {
                var main_frame_col = main_frame.cols;
                if (main_frame_col.substr(0, main_frame_col.indexOf(',')) == 0) {
                    parent.toggle_left_panel();
                }

//                parent.document.getElementById("left_frame").location = url_link;
            }

            return true;
        });

//        setTimeout(top_menu_a.eq(0).trigger('click'), 1000);
    });
</script>
</body>
</html>