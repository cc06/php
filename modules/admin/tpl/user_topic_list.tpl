{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active" style="width:100%; ">圈子列表</li>
</ol>

<form method="get" action="/admin/Topic/list" class="form-inline" >
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
        <th style="width: 90px;">名称</th>
        <th style="width: 50px;">创建人</th>
        <th style="width: 180px;">图片</th>
        <th style="width: 150px;">操作</th>

    </tr>

    {foreach from=$topics item=item name=foo}
    <form rel="ajax" id="add_form" method="post" action="/admin/Topic/shenhe" class="form-horizontal" role="form">
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.title}</td>
            <td>{$item.nickname}</td>
            <td><div style="float: left;">{$photos=explode(',',$item.pics)}{foreach $photos as $photo}
                    {if $photo neq ""}<img width="100" style="margin: 5px" height="100" src="{$photo}"  class="img-rounded"/>{/if}
                {/foreach}</div></td>
            <td id="guanbi_{$item.id}">
                <input type="hidden" name="tid" id="tid" value="{$item.id}"/>
                {if $item.status==1}<button  class="btn btn-primary">关闭圈子</button>{/if}
                {if $item.status==2}已关闭{/if}
                <a href="/admin/Topic/message?tid={$item.id}">聊天记录</a>
            </td>
        </tr>
    </form>
    {/foreach}
</table>
<script type="text/javascript">

    function guanbi(guanbi){

        document.getElementById(guanbi).innerHTML='已关闭';

    }

</script>

{include "pager.tpl"}
{include 'footer.tpl'}
