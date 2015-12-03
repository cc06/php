{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">帐号聊天记录</li>
</ol>

<form method="get" action="/admin/UserMessageJD/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">UID：</label>
                <input class="form-control" type="text" name="uid" value="{if $uid >0}{$uid}{/if}">
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

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
                {if $item.content->img neq ""}<img width="100" style="margin: 5px" height="100" src="{$item.content->img}"  class="img-rounded"/>{/if}
                {if $item.content->content neq ""}{$item.content->content}{/if}
            </td>
        </tr>
    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
