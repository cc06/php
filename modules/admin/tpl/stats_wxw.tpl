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
            {foreach from=$spmList key=wc_uid item=c_name}
                <option value="{$wc_uid}">{$c_name}</option>
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
<div style="position: relative;">
{*<div style="position:fixed; left:0px; width: 110px;">
    <div style="line-height:30px; width: 110px; float: left;border-bottom: 2px solid #ddd;background-color: #ffffff; padding: 0 10px; "><strong>日期</strong></div>
{foreach from=$Stat item=item}
  <div style="line-height:30px; width: 110px; float: left;border-top: 1px solid #ddd;background-color: #ffffff; padding: 0 10px; "><a  href="/admin/ReportWxw/hoursDetail?flag=1&stats_date={$item['tm']}"><strong>{$item['tm']}</strong></a></div>
    {/foreach}
</div>*}
<table class="table table-hover table-report" style="margin-bottom: 5px" id="report_table2">

    <tr>
        <th style="padding: 0px; ">
             <div style="line-height: 40px;border: 2px solid #ddd; background-color: #ffffff;">统计项</div>
            {foreach from=$Config item=item name=foo}
              <div style="line-height: 40px;border: 1px solid #ddd;{if (($smarty.foreach.foo.index+1)%2)}background-color: #f9f9f9;{else}background-color: #ffffff;{/if}">{$item.name}<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></div>
            {/foreach}
        </th>
        {foreach from=$Stat item=item}
        <th style="padding: 0px; ">
            <div style="line-height: 40px;border: 2px solid #ddd; background-color: #ffffff;"><a  href="/admin/ReportWxw/hoursDetail?flag=1&stats_date={$item['tm']}"><strong>{$item['tm']}</strong></a></div>
            {foreach from=$Config item=item2 name=foo}
                <div style="line-height: 40px;border: 1px solid #ddd;{if (($smarty.foreach.foo.index+1)%2)}background-color: #f9f9f9;{else}background-color: #ffffff;{/if}"><a  href="/admin/ReportWxw/province?user_type={$user_type}&c_uid={$c_uid}&c_sid={$c_sid}&stats_date={$item['tm']}&sc_config={$item2.id}">{$item[$item2.id_0]+$item[$item2.id_1]+$item[$item2.id_2]}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item[$item2.id_1]}</span>,<span style=" color: #FF0000;">{$item[$item2.id_2]}</span>)</span></a></div>
            {/foreach}
        </th>
        {/foreach}
    </tr>
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
{include "pager.tpl"}
{include "footer.tpl"}