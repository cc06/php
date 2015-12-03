{include 'header.tpl'}

<style>
    table .header-fixed {
        position: fixed;
        /* 10 less than .navbar-fixed to prevent any overlap */

        top: 0px;
        z-index: 1020;
        border-bottom: 1px solid #d5d5d5;
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 0;
        -webkit-box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        -moz-box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        /* IE6-9 */

        box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    }
</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">所有秋千帐号</li>
</ol>

<table id="mytable" class="table table-bordered table-striped table-fixed-header">
    <thead class="header">
        <th style="width: 10px;">编号</th>
        <th style="width: 50px;">头像</th>
        <th style="width: 20px;">UID</th>
        <th style="width: 70px;">用户昵称</th>
        <th style="width: 30px;">性别</th>
        <th style="width: 30px;">年龄</th>
        <th style="width: 50px;">身高</th>
        <th style="width: 50px;">添加时间</th>
        <th style="width: 70px;">所在地</th>
        <th style="width: 50px;">状态</th>
        <th style="width: 50px;">操作</th>
    </thead

    {foreach from=$users item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td><img width="50" height="50" src="{$item.avatar}" class="img-rounded"  /></td>
            <td>{$item.uid}</td>
            <td>{$item.nickname}</td>
            <td>{if $item.gender == 1}男 {else}女 {/if}</td>
            <td>{$item.age}</td>
            <td>{$item.height}</td>
            <td>{$item.reg_time}</td>
            <td>{$item.province}{$item.city}</td>
            <td id="stat{$item.uid}">
                {if $item.stat=="0"}正常{/if}
                {if $item.stat=="5"}<span style="color: #ff0000;">已封号</span>{/if}
            </td>
            <td>
                <a href="/admin/User/xiangxi?uid={$item.uid}">详细信息</a></td>
        </tr>
    {/foreach}
</table>

<script type="text/javascript">
    (function () {
        (function ($) {
            return $.fn.fixedHeader = function (options) {
                var config;
                config = {
                    topOffset: 40,
                    bgColor: "#EEEEEE"
                };
                if (options) {
                    $.extend(config, options);
                }
                return this.each(function () {
                    var $head, $win, headTop, isFixed, o, processScroll, ww;
                    processScroll = function () {
                        var headTop, i, isFixed, scrollTop, t;
                        if (!o.is(":visible")) {
                            return;
                        }
                        i = void 0;
                        scrollTop = $win.scrollTop();
                        t = $head.length && $head.offset().top - config.topOffset;
                        if (!isFixed && headTop !== t) {
                            headTop = t;
                        }
                        if (scrollTop >= headTop && !isFixed) {
                            isFixed = 1;
                        } else {
                            if (scrollTop <= headTop && isFixed) {
                                isFixed = 0;
                            }
                        }
                        if (isFixed) {
                            return $("thead.header-copy", o).removeClass("hide");
                        } else {
                            return $("thead.header-copy", o).addClass("hide");
                        }
                    };
                    o = $(this);
                    $win = $(window);
                    $head = $("thead.header", o);
                    isFixed = 0;
                    headTop = $head.length && $head.offset().top - config.topOffset;
                    $win.on("scroll", processScroll);
                    $head.on("click", function () {
                        if (!isFixed) {
                            return setTimeout((function () {
                                return $win.scrollTop($win.scrollTop() - 47);
                            }), 10);
                        }
                    });
                    $head.clone().removeClass("header").addClass("header-copy header-fixed").appendTo(o);
                    ww = [];
                    o.find("thead.header > tr:first > th").each(function (i, h) {
                        //return ww.push($(h).width());
                        return ww.push($(h).width()*2);
                    });
                    $.each(ww, function (i, w) {
                        return o.find("thead.header > tr > th:eq(" + i + "), thead.header-copy > tr > th:eq(" + i + ")").css({
                            width: w
                        });
                    });
                    o.find("thead.header-copy").css({
                        margin: "0 auto",
                        //width: o.width()+20,
                        width: o.width(),
                        "background-color": config.bgColor,
                        "top":"54px"
                    });
                    return processScroll();
                });
            };
        })(jQuery);

    }).call(this);


    $(document).ready(function () {
        // add 30 more rows to the table
        /* var row = $('table#mytable > tbody > tr:first');
         var row2 = $('table#mytable2 > tbody > tr:first');
         for (i = 0; i < 30; i++) {
         $('table#mytable > tbody').append(row.clone());
         $('table#mytable2 > tbody').append(row2.clone());
         }
         */
        // make the header fixed on scroll
        $('.table-fixed-header').fixedHeader();
        //$("#test").html("333333333 ");
    });

</script>

{include "pager.tpl"}
{include 'footer.tpl'}
