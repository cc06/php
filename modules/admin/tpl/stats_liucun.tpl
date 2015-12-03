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
    .b1{  color: #4ba614;}
</style>

<form role="form" class="form-inline" action="/admin/ReportLiucun/report" method="get">
    <div class="form-group ">
        <label for="form-search-reg_type" >留存：</label>
        <select class="form-control"  name="stats_key" id="form-search-stats_key">
            <option value="online_award_users" {if $stats_key == "online_award_users"}selected="selected" {/if}>上线领奖人数留存</option>
            <option value="on_top_users" {if $stats_key == "on_top_users"}selected="selected" {/if}>切换到前台人数</option>
            <option value="topic_chat_users" {if $stats_key == "topic_chat_users"}selected="selected" {/if}>话题聊天消息人数</option>
            <option value="play_plane_users" {if $stats_key == "play_plane_users"}selected="selected" {/if}>玩游戏人数</option>
        </select>
        <label for="form-search-reg_type" >用户性别：</label>
        <select class="form-control"  name="user_gender" id="form-search-user_gender">
            <option value="-1" {if $user_gender == "-1"}selected="selected" {/if}>全部</option>
            <option value="1" {if $user_gender == "1"}selected="selected" {/if}>男</option>
            <option value="2" {if $user_gender == "2"}selected="selected"{/if}>女</option>
        </select>
        <label for="form-search-reg_type" >省分：</label>
        <select class="form-control"  name="province" id="form-search-province">
            <option value="" {if $province == ""}selected="selected" {/if}>全部</option>
            {foreach from=$user_province item=item}
            <option value="{$item.province}">{$item.province}</option>
            {/foreach}
        </select>

        <label for="form-search-cuid" >主渠道：</label>
        <select class="form-control" name="c_uid" id="form-search-cuid">
            <option value="" id="all">全部</option>
            {foreach from=$spmList key=wc_uid item=c_name}
                <option value="{$wc_uid}">{$c_name}</option>
            {/foreach}
        </select>
        <label for="form-search-banben" >版本：</label>
        <input class="form-control" type="text" name="ver" value="{if $ver  neq ""}{$ver}{/if}">
    </div>
    <script>
        $(function () {
            $('#form-search-reg_type').find("option[value='{$user_type}']").attr("selected",true);
            $('#form-search-cuid').find("option[value='{$sc_uid}']").attr("selected",true);
            $('#form-search-province').find("option[value='{$province}']").attr("selected",true);
        });
    </script>
    <button class="btn btn-primary" type="submit">查找</button>
</form>

<table class="table table-hover table-report" style="margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 100px;" nowrap="value">日期</th>
        <th style="width: 80px;" nowrap="value">新用户</th>
        <th style="width: 90px;" nowrap="value">当天</th>
        <th style="width: 90px;" nowrap="value">1日</th>
        <th style="width: 90px;" nowrap="value">2日</th>
        <th style="width: 90px;" nowrap="value">3日</th>
        <th style="width: 90px;" nowrap="value">4日</th>
        <th style="width: 90px;" nowrap="value">5日</th>
        <th style="width: 90px;" nowrap="value">6日</th>
        <th style="width: 90px;" nowrap="value">7日</th>
        <th style="width: 90px;" nowrap="value">15日</th>
        <th style="width: 90px;" nowrap="value">30日</th>
    </tr>
    </thead>

    {foreach from=$Stat item=item}
        <tr title="{$item.stats_date}">
            <td nowrap="value">{$item['tm']}</td>
            <th nowrap="value">{$item['register']}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_0">{if $item['register']>0}{round($item[$stats_key0]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_1">{if $item['register']>0}{round($item[$stats_key1]*10000/$item['register'])/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_2">{if $item['register']>0}{round($item[$stats_key2]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_3">{if $item['register']>0}{round($item[$stats_key3]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_4">{if $item['register']>0}{round($item[$stats_key4]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_5">{if $item['register']>0}{round($item[$stats_key5]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_6">{if $item['register']>0}{round($item[$stats_key6]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_7">{if $item['register']>0}{round($item[$stats_key7]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_15">{if $item['register']>0}{round($item[$stats_key15]*10000/$item.register)/100}%{/if}</th>
            <th nowrap="value" id="liucun_{$item['tm']}_30">{if $item['register']>0}{round($item[$stats_key30]*10000/$item.register)/100}%{/if}</th>
        </tr>
    <script type="text/javascript">
    {if $item[$stats_key30]>0}
    document.getElementById('liucun_{$item['tm']}_30').className="b1";
    {else}
       {if $item[$stats_key15]>0}
        document.getElementById('liucun_{$item['tm']}_15').className="b1";
       {else}
          {if $item[$stats_key7]>0}
           document.getElementById('liucun_{$item['tm']}_7').className="b1";
          {else}
             {if $item[$stats_key6]>0}
             document.getElementById('liucun_{$item['tm']}_6').className="b1";
             {else}
                {if $item[$stats_key5]>0}
                document.getElementById('liucun_{$item['tm']}_5').className="b1";
                {else}
                    {if $item[$stats_key4]>0}
                     document.getElementById('liucun_{$item['tm']}_4').className="b1";
                    {else}
                         {if $item[$stats_key3]>0}
                         document.getElementById('liucun_{$item['tm']}_3').className="b1";
                         {else}
                             {if $item[$stats_key2]>0}
                             document.getElementById('liucun_{$item['tm']}_2').className="b1";
                             {else}
                                 {if $item[$stats_key1]>0}
                                 document.getElementById('liucun_{$item['tm']}_1').className="b1";
                                   {else}
                                        {if $item[$stats_key0]>0}
                                         document.getElementById('liucun_{$item['tm']}_0').className="b1";
                                        {/if}
                                 {/if}
                            {/if}
                          {/if}
                     {/if}
               {/if}
             {/if}
          {/if}
       {/if}
    {/if}

    </script>

    {/foreach}
</table>

{include "pager.tpl"}
{include "footer.tpl"}