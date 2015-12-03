{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/FocusList/list?type={$type}" style="margin-left:0px">焦点图列表</a> | <a  href="/admin/FocusList/add?type={$type}" style="margin-left:0px">添加焦点图</a></li>
</ol>

<form method="get" action="/admin/FocusList/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label"> 类型：</label>
                <select class="form-control"  name="type" id="form-search-type">
                    <option value="main" {if $type == "main"}selected="selected" {/if}>广场</option>
                    <option value="loginPopup" {if $type == "loginPopup"}selected="selected"{/if}>登陆弹窗</option>
                </select>
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 100px;">图片</th>
        <th style="width: 100px;">类型</th>
        <th style="width: 50px;">顺序</th>
        <th style="width: 150px;">状态</th>
        <th style="width: 70px;">操作</th>

    </tr>

    {foreach from=$focus item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
          <td><img width="100" height="100" src="{$item.pic}" class="img-rounded"  /></td>
          <td>
              {if $item.type=="main"}广场{/if}
              {if $item.type=="loginPopup"}登陆弹窗{/if}
          </td>
          <td>{$item.position}</td>
          <td>
              {if $item.status==1}已上线,<a href="/admin/FocusList/list?xiaxian_id={$item.id}&type={$type}">点击下线</a>{/if}
              {if $item.status==0}<font color="#ff0000;">已下线</font>,<a href="/admin/FocusList/list?shangxian_id={$item.id}&type={$type}">点击上线</a>{/if}
          </td>
          <td>
              <a href="/admin/FocusList/list?shanchu_id={$item.id}&type={$type}">删除</a>
              <a href="/admin/FocusList/update?id={$item.id}&type={$type}">编辑</a>
          </td>
        </tr>
        <tr class="t_c"  style="vertical-align: middle">
            <td></td>
            <td colspan="7" style="text-align: left;">
                <strong>内容说明：</strong>{$item.text}
            </td>
        </tr>
        <tr class="t_c"  style="vertical-align: middle">
            <td></td>
            <td colspan="7" style="text-align: left;">
                {if $item.action->cmd=="cmd_open_web"} <strong>操作：</strong>打开网页，<strong>链接地址：</strong>{$item.action->data->url}{/if}
                {if $item.action->cmd=="cmd_entry_game"} <strong>操作：</strong>打开游戏，<strong>游戏ID：</strong>{$item.action->data->gid} <strong>战区ID：</strong>{$item.action->data->area_id}{/if}
              </td>
        </tr>
    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
