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
</style>

<form role="form" class="form-inline" action="?" method="get">
    <div class="form-group ">
        <label for="form-search-reg_type" >用户类型：</label>
        <select class="form-control"  name="user_type" id="form-search-reg_type">
            <option value="-1" {if $user_type == "-1"}selected="selected" {/if}>全部</option>
            <option value="1" {if $user_type == "1"}selected="selected" {/if}>web</option>
            <option value="2" {if $user_type == "2"}selected="selected"{/if}>android</option>
            <option value="3" {if $user_type == "3"}selected="selected"{/if}>ios</option>
        </select>

        {*用户客户端类型 1为web,2为android，3为iphone，4为PC端*}
        <label for="form-search-cuid" >主渠道：</label>
        <select class="form-control" name="c_uid" id="form-search-cuid" onchange="setSpm()">
            <option value="" id="all">全部</option>
            {foreach from=$spmList key=c_uid item=c_name}
                <option value="{$c_uid}">{$c_name}</option>
            {/foreach}
        </select>
        <label for="form-search-csid" >子渠道：</label>
        <select class="form-control" name="c_sid" id="form-search-csid">
            <option value="" id="all">全部</option>
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
    <input type="hidden" name="flag" value="{$flag}">
    <button class="btn btn-primary" type="submit">查找</button>
</form>

<table class="table table-hover table-report" style="width: 100%;max-width: 200%;margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 95px;">日期</th>
        <th style="width: 20px;">小时</th>
        {*<th style="width: 40px;">主渠道</th>*}
       {* {if $flag==2}
            <th style="width: 40px;">子渠道</th>
        {/if}*}

        <th style="width: 95px;">注册人数</th>
        <th style="width: 45px;">充值人数</th>
        <th style="width: 45px;">充值总额</th>
        <th style="width: 45px;">赠送金币</th>
    </tr>
    </thead>
    {foreach from=$logList item=item}
        <tr>
            <td>{$item.stats_date}</td>
            <td>{$item.hours}</td>
            {*<td><a target="_blank" href="/admin/report/hoursDetail?flag=2&c_uid={$item.c_uid}&stats_date={$item.stats_date}">{$item.c_name}({$item.c_uid})</a></td>
            {if $flag==2}
                <td>{$item.c_s_name}({$item.c_sid})</td>
            {/if}*}
            <td>{$item.reg_cnt}</td>
            <td>{$item.charge_user_cnt}</td>
            <td>{$item.charge_sum}</td>
            <td>{intval($item.gived_sum)}</td>
        </tr>
    {/foreach}
</table>
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
{include "pager.tpl"}
{include "footer.tpl"}