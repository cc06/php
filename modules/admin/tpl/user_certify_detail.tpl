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
</style>

<div style="position: relative;">
    <h2 style="font-size: 18px;margin-top: 0px;" >{$date}日注册用户</h2>
<table class="table table-hover table-report" style="margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 110px;" nowrap="value">日期</th>
        <th style="width: 110px;" nowrap="value">操作</th>
        <th style="width: 120px;" nowrap="value">人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
    </tr>
    </thead>
    {foreach $data as $tm=>$v}
        <tr >
            <th nowrap="value">{$tm}</th>
            <th nowrap="value">{if $item==2}上传照片{else}完善资料{/if}</th>
            <th nowrap="value">{$v['1']+$v["2"]}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$v['1']}</span>,<span style=" color: #FF0000;">{$v['2']}</span>)</span></th>
        </tr>
    {/foreach}


</table>
</div>

{include "pager.tpl"}
{include "footer.tpl"}