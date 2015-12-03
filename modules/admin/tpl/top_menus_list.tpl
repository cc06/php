{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">顶部栏目  <button  onclick="window.location.href='/admin/TopMenus/add'" class="btn btn-primary">添加新栏目</button></li>
</ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 50px;">名称</th>
        <th style="width: 90px;">标识</th>
        <th style="width: 50px;">操作</th>

    </tr>

    {foreach from=$top_menus item=item name=foo}
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.name}</td>
            <td>{$item.menu}</td>
            <td>
                <a href="/admin/TopMenus/update?topid={$item.id}">编辑</a>
                <a href="/admin/LeftMenus/list?topid={$item.id}">编辑子栏目</a>
                <a onclick="return confirm('是否真的删除此地址？');" href="/admin/TopMenus/delete?topid={$item.id}">删除</a>
            </td>
        </tr>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
