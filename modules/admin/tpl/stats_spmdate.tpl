{include "header.tpl"}
<link rel="stylesheet" type="text/css" href="/css/jquery.datetimepicker.css"/ >
<script src="/js/jquery.datetimepicker.js"></script>
<style>
    .table-report th,
    .table-report td {
        text-align: center;
    }
    #report_table1 th, #report_table1 td {
        padding-right: 0px;
    }
    #report_table2 th, #report_table2 td {
        padding-right: 0px;
        padding-bottom: 5px;
        padding-top: 5px;
    }

    html { overflow-x: auto; overflow-y: auto; border:0;}
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

<form role="form" class="form-inline" action="?" method="get">

    <label for="date">时间</label>
    <input style="border: 1px solid"  id="datetimepicker" name="stats_date" value="{$stats_date}"/>
    <script>
        $(function () {
            $('#form-search-reg_type').find("option[value='{$user_type}']").attr("selected",true);

            {literal}
            $('#datetimepicker').datetimepicker({lang:'ch',timepicker:false,
                format:'Y-m-d'
            });
            {/literal}
        });
    </script>
    <button class="btn btn-primary" type="submit">查找</button>
</form>
<div class="container" style="width: 100%;padding-right: 3px;
    padding-left: 3px;
    margin-right: auto;
    margin-left: auto;">
{*<div style="position:fixed; left:0px; width: 110px;">
    <div style="line-height:30px; width: 110px; float: left;border-bottom: 2px solid #ddd;background-color: #ffffff; padding: 0 10px; "><strong>日期</strong></div>
{foreach from=$Stat item=item}
  <div style="line-height:30px; width: 110px; float: left;border-top: 1px solid #ddd;background-color: #ffffff; padding: 0 10px; "><a  href="/admin/ReportWxw/hoursDetail?flag=1&stats_date={$item['tm']}"><strong>{$item['tm']}</strong></a></div>
    {/foreach}
</div>*}
    <table id="mytable" class="table table-bordered table-striped table-fixed-header">
        <thead class="header">
        <tr>
            <th>渠道</th>
            <th>启动人数</th>
            <th>注册人数</th>
            <th>注册成功人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        </tr>
        </thead>

        <tbody>
        {foreach from=$c_names_key item=item}
        <tr>
            <td>{$item.key0}-{$item.key}({$item.spm_name})</td>
            <td>{$item.key_start}</td>
            <td>{$item.key_0+$item.key_1+$item.key_2}</td>
            <td>{$item.key_w_1+$item.key_w_2}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item.key_w_1}</span>,<span style=" color: #FF0000;">{$item.key_w_2}</span>)</span></td>
        </tr>
        {/foreach}

        <tr>
            <td>总计</td>
            <td>{$zong_key_start}</td>
            <td>{$zong_key}</td>
            <td>{$zong_key_w}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$zong_key_w_1}</span>,<span style=" color: #FF0000;">{$zong_key_w_2}</span>)</span></td>
        </tr>
        </tbody>
    </table>

</div>
<script type="text/javascript">

    function setSpm(){
        var cuid = $("#form-search-cuid").find('option:selected').val();
        var items = eval('({$spmarr})');
        var tag_obj = $("#form-search-csid");

        var arr = new Array();

        arr[arr.length] = '<option value="">全部</option>';
        var len = items.length;
        for(var i = 0; i<len;i++){
            if(items[i].c_uid == cuid && items[i].c_sid != ""){
                arr[arr.length] = '<option value="'+items[i].c_sid+'">'+items[i].c_sid+'</option>';
            }
        }
        tag_obj.html(arr.join(""));
    }
</script>

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
{include "footer.tpl"}