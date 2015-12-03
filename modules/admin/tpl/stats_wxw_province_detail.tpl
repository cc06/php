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
        <label for="form-search-reg_type" >分类：</label>
        <select class="form-control"  name="sc_config" id="form-search-sc_config">
            {foreach from=$Config item=item}
            <option value="{$item.id}" {if $sc_config == $item.id}selected{/if}>{$item.name}</option>
            {/foreach}
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

<table class="table table-hover table-report" style="width:80%;margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 95px;">省</th>
        <th style="width: 150px;">总</th>
        <th style="width: 150px;"><span style="color: #0069b2;">男</span></th>
        <th style="width: 150px;"><span style=" color: #FF0000;">女</span></th>

    </tr>
    </thead>
    {foreach from=$Stat item=item}
        <tr title="{$item.stats_date}">
            <td>{if $item.province neq ""}{$item.province}{else}省为空值{/if}</td>
            <td>{$item[$sc_config_2]+$item[$sc_config_1]}</td>
            <td>{$item[$sc_config_1]}</td>
            <td>{$item[$sc_config_2]}</td>

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

{include "footer.tpl"}