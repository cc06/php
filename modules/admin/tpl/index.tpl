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
<div class="container" style="width: 100%">
   {* <h2 id="mynav">| my navigation bar | my navigation bar | my navigation bar | my navigation bar |</h2>

    <h1>Table Fixed Header</h1>
    <table id="mytable" class="table table-bordered table-striped table-fixed-header">
        <thead class="header">
        <tr>
            <th>Column 1</th>
            <th>Column 2</th>
            <th>Column 3</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td>Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        <tr>
            <td id="test">Data Column 1</td>
            <td>Data Column 2</td>
            <td>Data Column 3</td>
        </tr>
        </tbody>
    </table>*}
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