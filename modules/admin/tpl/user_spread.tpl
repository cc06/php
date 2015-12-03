{include "header.tpl"}
<link rel="stylesheet" type="text/css" href="/css/jquery.datetimepicker.css"/ >
<script src="/js/jquery.datetimepicker.js"></script>
<script src="/js/Chart.min.js"></script>
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
    .breadcrumb a{
        margin-right: 5px;
        margin-left:5px;
    }
</style>
<ol class="breadcrumb">
    <li class="active" style="width:100%; "><a href="/admin/report/spread" style="margin-left:0px">区域分布</a>|<a href="/admin/report/ageSpread">年龄分布</a></li>
</ol>
<form role="form" class="form-inline" action="?" method="get">
    <div class="form-group ">
        <label for="form-search-cuid" >主渠道：</label>
        <select class="form-control" name="c_uid" id="form-search-cuid" onchange="setSpm()">
            <option value="" id="all">全部</option>
            {foreach from=$spmList key=c_uid item=c_name}
                <option value="{$c_uid}">{$c_name}</option>
            {/foreach}
        </select>
        <label for="form-search-csid" >子渠道：</label>
        <select class="form-control" name="c_sid" id="form-search-csid">
        </select>
    </div>
    <label for="date">时间</label>
    <input style="border: 1px solid"  id="datetimepicker" name="stats_date" value="{$stats_date}"/>
    <script>
        $(function () {
            $('#form-search-reg_type').find("option[value='{$user_type}']").attr("selected",true);
            $('#form-search-cuid').find("option[value='{$sc_uid}']").attr("selected",true);
            setSpm();
            $('#form-search-csid').find("option[value='{$sc_sid}']").attr("selected",true);
            {literal}
            $('#datetimepicker').datetimepicker({lang:'ch',timepicker:false,
                format:'Y-m-d'
            });
            {/literal}
        });
    </script>
    <button class="btn btn-primary" type="submit">查找</button>
</form>
<div style="height: 20px">  </div>
<div style="height: 20px">备注：<span style="background-color: rgba(220,220,220,0.5);padding: 0px 20px;margin: 0 20px;">男</span><span style="background-color: rgba(151,187,205,0.5);padding: 0px 20px">女</span></div>
    <div style="width: 140%;max-width: 200%">
        <canvas id="canvas"  style="margin-left: 10px"></canvas>
    </div>

<script type="text/javascript">

    var data_1 =  eval('({$data_1})');
    var data_2 =  eval('({$data_2})');
    var province =  eval('({$province})');

    var barChartData = {
        labels : province,
        datasets : [
            {
                fillColor : "rgba(220,220,220,0.5)",
                strokeColor : "rgba(220,220,220,0.8)",
                highlightFill: "rgba(220,220,220,0.75)",
                highlightStroke: "rgba(220,220,220,1)",
                data : data_1
            },
            {
                fillColor : "rgba(151,187,205,0.5)",
                strokeColor : "rgba(151,187,205,0.8)",
                highlightFill : "rgba(151,187,205,0.75)",
                highlightStroke : "rgba(151,187,205,1)",
                data : data_2
            }
        ]

    }
    window.onload = function(){
        var ctx = document.getElementById("canvas").getContext("2d");
        window.myBar = new Chart(ctx).Bar(barChartData, {
            responsive : true
        });
    }

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
{include "pager.tpl"}
{include "footer.tpl"}