{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">帐号聊天记录</li>
</ol>

<form method="get" action="/admin/UserMessage/list" class="form-inline" >
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
        <th style="width: 100px;">用户</th>
        <th style="width: 370px;">内容</th>
        <th style="width: 100px;">聊天对象</th>
        <th style="width: 100px;">详细</th>

    </tr>

    {foreach from=$user_messages item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td><img width="50" height="50" src="{$user_avatar}" class="img-rounded"  /> {$item.from}</td>
          <td></td>
            <td>{$item.to} <img width="50" height="50" src="{$item.to_avatar}" class="img-rounded"  />
            </td>
          <td>
              <span id="xiangxi_{$smarty.foreach.foo.index+1}" onclick="xianshi_juti({$smarty.foreach.foo.index+1});" style="cursor:pointer">详细内容</span>
              <span id="guanbi_{$smarty.foreach.foo.index+1}" onclick="xianshi_guanbi({$smarty.foreach.foo.index+1});" style="cursor:pointer; display: none;">关闭</span>
          </td>
        </tr>
        <tr class="t_c"  style="vertical-align: middle;">
            <td></td>
            <td colspan="3"><iframe src="/admin/UserMessageJt/list?uid={$item.from}&touid={$item.to}" width="100%"
                        height="470" runat="server"
                        name="iframedoc" id="jutixinxi_{$smarty.foreach.foo.index+1}" style="display: none;"></iframe></td>
            <td></td>
        </tr>
    {/foreach}
</table>
<script type="text/javascript">
    function xianshi_juti(id) {
         document.getElementById("jutixinxi_"+id).style.display = "block";
        document.getElementById("xiangxi_"+id).style.display = "none";
        document.getElementById("guanbi_"+id).style.display = "block";
    }
    function xianshi_guanbi(id) {
        document.getElementById("jutixinxi_"+id).style.display = "none";
        document.getElementById("xiangxi_"+id).style.display = "block";
        document.getElementById("guanbi_"+id).style.display = "none";
    }
</script>
{include "pager.tpl"}
{include 'footer.tpl'}
