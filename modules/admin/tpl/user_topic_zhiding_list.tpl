{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active" style="width:100%; ">圈子置顶</li>
</ol>

<form method="get" action="/admin/TopicZhiding/list" class="form-inline" >
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
        <th style="width: 50px;">置顶等级</th>
        <th style="width: 50px;">操作</th>

    </tr>

    {foreach from=$topics item=item name=foo}
    <form rel="ajax" id="add_form" method="post" action="/admin/TopicZhiding/shenhe" class="form-horizontal" role="form">
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.title}</td>
            <td>{$item.nickname}</td>
            <td><div style="float: left;">{$photos=explode(',',$item.pics)}{foreach $photos as $photo}
                    {if $photo neq ""}<img width="100" style="margin: 5px" height="100" src="{$photo}"  class="img-rounded"/>{/if}
                {/foreach}</div></td>
            <td align="center"><input class="form-control" type="text" name="priority" id="priority_{$item.id}" value="{$item.priority}" style="width: 100px;"></td>
            <td align="center">
                <input type="hidden" name="tid" id="tid" value="{$item.id}"/>
                <button  class="btn btn-primary">提交</button><br>
                {if $item.priority>"0"}<a href="/admin/TopicZhiding/chexiao?tid={$item.id}" rel="ajax"><div  class="btn btn-primary">撤销置顶</div></a>{/if}

            </td>
        </tr>
    </form>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
