{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/GuanwangNews/list" style="margin-left:0px">秋千动态列表</a> | <a  href="/admin/GuanwangNews/add" style="margin-left:0px">秋千动态添加</a></li>
</ol>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 200px;">标题</th>
        <th style="width: 50px;">时间</th>
        <th style="width: 70px;">操作</th>

    </tr>

    {foreach from=$guanwang_news item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
          <td>{$item.title}</td>
          <td>{$item.riqi}</td>
          <td>
              <a href="/admin/GuanwangNews/list?shanchu_id={$item.id}">删除</a>
              <a href="/admin/GuanwangNews/update?id={$item.id}">编辑</a>
          </td>
        </tr>

    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
