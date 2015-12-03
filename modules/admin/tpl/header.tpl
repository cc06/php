<!doctype html>
<html class="no-js">
<head>
    <meta charset="UTF-8">
    <title>秋千后台</title>

    <!--IE Compatibility modes-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!--Mobile first-->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="/admin/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="/admin/css/font-awesome.min.css">

    <!-- Metis core stylesheet -->
    <link rel="stylesheet" href="/admin/css/main.min.css">

    <!-- metisMenu stylesheet -->
    <link rel="stylesheet" href="/admin/css/metisMenu.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--jQuery -->
    <script src="/admin/js/jquery.min.js"></script>
    <!--[if lt IE 9]>
    <script src="/admin/lib/html5shiv/html5shiv.js"></script>
    <script src="/admin/lib/respond/respond.min.js"></script>
    <![endif]-->

    <!--For Development Only. Not required -->
    <script>
        less = {
            env: "development",
            relativeUrls: false,
            rootpath: "../assets/"
        };
    </script>

    <link rel="stylesheet/less" type="text/css" href="/admin/less/theme.less">
    <script src="/admin/js/less.min.js"></script>

    <!--Modernizr-->
    {*<script src="/admin/js/modernizr.min.js"></script>*}



</head>

<body class="{$top_class}" style="padding-top: 54px;">
<div class="bg-dark dk" id="wrap">
    <div id="top">

        <!-- .navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">

                <!-- Brand and toggle get grouped for better mobile display -->
                <header class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse" style="font-size: 14px;margin: 4px;">
                        菜单
                    </button>
                    <a href="/" class="navbar-brand" style="line-height: 50px;margin-left: 5px;margin-right: 10px">
                        秋千后台
                    </a>
                </header>
                <div class="topnav">
                    <div class="btn-group">
                        {$_F['member']['username']}
                    </div>
                    <div class="btn-group">
                        <a href="/admin/auth/logout" data-toggle="tooltip" data-original-title="Logout" data-placement="bottom" class="btn btn-metis-1 btn-sm">
                            <i class="fa fa-power-off"></i>
                        </a>
                    </div>
                    <div class="btn-group">
                        <a data-placement="bottom" data-original-title="隐藏" data-toggle="tooltip" class="btn btn-primary btn-sm toggle-left" id="menu-toggle">
                            子菜单
                        </a>
                    </div>
                </div>
                <div class="collapse navbar-collapse navbar-ex1-collapse">

                    <!-- .nav -->
                    <ul class="nav navbar-nav">
                        {foreach from=$top_menus item=top_menu}
                            <li {if $top_menu.menu == $menu}class="active" {/if} > <a href="?menu={$top_menu.menu}">{$top_menu.name}</a>  </li>
                        {/foreach}
                    </ul><!-- /.nav -->
                </div>
            </div><!-- /.container-fluid -->
        </nav><!-- /.navbar -->
    </div><!-- /#top -->
    <div id="left">
        <div class="media user-media bg-dark dker">
            <div class="user-media-toggleHover">
                <span class="fa fa-user"></span>
            </div>
            <div class="user-wrapper bg-dark" style="height: 1px; font-size: 26px; font-weight: bold; text-align: center;">

            </div>
        </div>

        <!-- #menu -->
        <ul id="menu" class="bg-blue dker affix">
           {* <li class="nav-header" style="display: none">Menu</li>*}
            {*<li class="nav-divider"></li>*}
            {foreach from=$menuItems key=key item=item}
                <li {if $item.url_jian == $left}class="active" {/if}>
                    <a href="{$item.url}">
                        <i class="fa fa-dashboard"></i><span class="link-title">&nbsp;{$item.name}</span>
                    </a>
                </li>
            {/foreach}

        </ul><!-- /#menu -->
    </div><!-- /#left -->
    <div id="content">
        <div class="outer" style="padding: 5px">
            <div class="inner bg-light lter" style="min-height: 860px; padding-top: 10px;border: 5px solid #e4e4e4">