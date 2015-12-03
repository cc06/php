{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">栏目 {$top_menus_menu.name} 的子栏目  <button  onclick="window.location.href='/admin/LeftMenus/add?topid={$topid}'" class="btn btn-primary">添加新栏目</button></li>
</ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 50px;">名称</th>
        <th style="width: 180px;">具体地址</th>
        <th style="width: 50px;">操作</th>

    </tr>

    {foreach from=$left_menus item=item name=foo}
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.name}</td>
            <td>{$item.url}</td>
            <td>
                <a href="/admin/LeftMenus/update?topid={$topid}&leftid={$item.id}">编辑</a>
                <a onclick="return confirm('是否真的删除此地址？');" href="/admin/LeftMenus/delete?topid={$topid}&leftid={$item.id}">删除</a>
            </td>
        </tr>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
