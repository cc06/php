{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">圈子聊天记录</li>
</ol>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 100px;">时间</th>
        <th style="width: 370px;">内容</th>

    </tr>

    {foreach from=$user_messages item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.content->tm}</td>
            <td style="text-align: left;">
               {if $item.type=="pic"}{if $item.content->img neq ""}<img width="100" style="margin: 5px" height="100" src="{$item.content->img}"  class="img-rounded"/>{/if}{/if}
                {if $item.content->content neq ""}{$item.content->content}{/if}
            </td>
        </tr>
    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
