{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">用户 {$user_nickname} 的地址  <button  onclick="window.location.href='/admin/YUserAddress/add?uid={$uid}'" class="btn btn-primary">添加新地址</button></li>
</ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 50px;">联系人</th>
        <th style="width: 90px;">电话</th>
        <th style="width: 50px;">省</th>
        <th style="width: 50px;">市</th>
        <th style="width: 180px;">具体地址</th>
        <th style="width: 50px;">操作</th>

    </tr>

    {foreach from=$useradds item=item name=foo}
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.username}</td>
            <td>{$item.phone}</td>
            <td>{$item.province}</td>
            <td>{$item.city}</td>
            <td>{$item.address}</td>
            <td>
                <a href="/admin/YUserAddress/update?addrid={$item.addrid}">编辑</a>
                <a onclick="return confirm('是否真的删除此地址？');" href="/admin/YUserAddress/delete?addrid={$item.addrid}">删除</a>
            </td>
        </tr>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
