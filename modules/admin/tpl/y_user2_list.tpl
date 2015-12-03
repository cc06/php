{include 'header.tpl'}
<style type="text/css">
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
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>待审核用户</h5> <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="dataTables_length" id="dataTable_length">
                                <form method="get" action="/admin/YUser2/list" class="form-inline" >
                                <label style="line-height: 50px;">UID： <input class="form-control input-sm" type="text" name="uid" value="{if $uid >0}{$uid}{/if}"><button type="submit" class="btn btn-primary">查找</button></label>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="mytable" class="table table-bordered table-striped table-fixed-header" role="grid" aria-describedby="dataTable_info">
                                <thead class="header">
                                <tr role="row">
                                    <th style="line-height: 35px; width: 20%;">UID</th>
                                    <th style="line-height: 35px; width: 20%;">头像</th>
                                    <th style="line-height: 35px; width: 30%;">用户昵称</th>
                                    <th style="line-height: 35px; width: 15%;">性别</th>
                                    <th style="line-height: 35px; width: 15%;">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach from=$users item=item name=foo}
                                <tr role="row" class="{if ($smarty.foreach.foo.index+1%2)}odd{else}even{/if}">
                                    <td class="sorting_1" style="line-height: 50px;">{$item.uid}</td>
                                    <td style="line-height: 50px;"><img width="50" height="50" src="{$item.avatar}" class="img-rounded"  /></td>
                                    <td style="line-height: 50px;">{$item.nickname}</td>
                                    <td style="line-height: 50px;">{if $item.gender == 1}男 {else}女 {/if}</td>
                                    <td style="line-height: 50px;"><a href="/admin/YUser2/update?uid={$item.uid}">审核</a></td>
                                </tr>
                                {/foreach}</tbody>
                            </table>
                        </div></div>
                    <div class="row">
                        <div class="col-sm-6">
                            {include "pager.tpl"}
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


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
