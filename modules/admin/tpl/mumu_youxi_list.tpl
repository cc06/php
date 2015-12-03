{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/MumuYouxi/list" style="margin-left:0px">秋千游戏列表</a> | <a  href="/admin/MumuYouxi/add" style="margin-left:0px">添加秋千游戏</a></li>
</ol>
<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 100px;">图片</th>
        <th style="width: 200px;">标题（说明，链接地址）</th>
        <th style="width: 50px;">顺序</th>
        <th style="width: 70px;">操作</th>

    </tr>

    {foreach from=$mumu_youxi item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
          <td><img width="100" height="100" src="{$item.pic}" class="img-rounded"  /></td>
          <td align="left" style="text-align:left; line-height: 35px;">
              标题：{$item.title}<br>
              说明：{$item.text}<br>
              链接地址：{$item.url}<br>
          </td>
          <td>{$item.position}</td>
          <td>
              <a href="/admin/MumuYouxi/list?shanchu_id={$item.id}">删除</a>
              <a href="/admin/MumuYouxi/update?id={$item.id}">编辑</a>
          </td>
        </tr>

    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
