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

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">性感动态，涉黄动态，文字未通过</li>
</ol>

<table id="mytable" class="table table-bordered table-striped table-fixed-header">
    <thead class="header">
        <th width="10%">编号</th>
        <th width="45%">照片</th>
        <th width="45%">文字</th>
    </thead

    {foreach from=$dynamics item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$photos=explode(',',$item.pic)}{foreach $photos as $photo}
                    {if $photo neq ""}<div style="float: left; width: 120px; height: 120px;"><div style="position: relative;"><div style="position: absolute;top: 0px; left: 0px;"><img width="100" style="margin: 5px;float: left;" height="100" src="{$photo}"  class="img-rounded" /></div></div></div>{/if}
                {/foreach}</td>
            <td>{$item.text}</td>

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


{include 'footer.tpl'}
