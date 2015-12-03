{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/MumuBa/list" style="margin-left:0px">信息列表</a> | <a  href="/admin/MumuBa/add" style="margin-left:0px">添加信息</a></li>
</ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 100px;">图片</th>
        <th style="width: 250px;">标题（说明）</th>
        <th style="width: 50px;">日期</th>
        <th style="width: 70px;">操作</th>

    </tr>

    {foreach from=$mumu_ba item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
          <td><img width="120" height="135" src="{$item.pic}" class="img-rounded"  /></td>
          <td align="left" style="text-align:left; line-height: 35px;">
              标题：{$item.title}<br>
              说明：{$item.text}<br>
          </td>
          <td>{$item.riqi}</td>
          <td>
              <a href="/admin/MumuBa/list?shanchu_id={$item.id}">删除</a>
              <a href="/admin/MumuBa/update?id={$item.id}">编辑</a>
          </td>
        </tr>

    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
