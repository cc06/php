{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">所有领奖记录</li>
</ol>

<form method="get" action="?" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">分类：</label>
                <select class="form-control"  name="type" id="type">
                    <option value="-1" {if $type == "-1"}selected="selected" {/if}>全部</option>
                    <option value="2" {if $type == "2"}selected="selected" {/if}>实物</option>
                    <option value="3" {if $type == "3"}selected="selected"{/if}>充值卡</option>
                    <option value="4" {if $type == "4"}selected="selected"{/if}>虚拟奖品</option>
                </select>
            </td>
            <td>
                <label for="form-w" class="control-label">状态：</label>
                <select class="form-control"  name="status" id="status">
                    <option value="-1" {if $status == "-1"}selected="selected" {/if}>全部</option>
                    <option value="0" {if $status == "0"}selected="selected" {/if}>待领取</option>
                    <option value="1" {if $status == "1"}selected="selected"{/if}>已领取</option>
                    <option value="2" {if $status == "2"}selected="selected" {/if}>等待充值（发货）</option>
                    <option value="3" {if $status == "3"}selected="selected"{/if}>已完成</option>
                </select>
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 20px;">编号</th>
        <th style="width: 40px;">UID</th>
        <th style="width: 40px;">用户昵称</th>
        <th style="width: 40px;">奖品名称</th>
        <th style="width: 40px;">分类</th>
        <th style="width: 50px;">创建时间</th>
        <th style="width: 50px;">领取时间</th>
        <th style="width: 40px;">状态</th>
        <th style="width: 100px;">说明</th>
        <th style="width: 50px;">操作</th>
    </tr>

    {foreach from=$award_record item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle;">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.uid}</td>
            <td>{$item.nickname}</td>
          <td>{$item.name}</td>
          <td>
              {if $item.type==2}实物{/if}
              {if $item.type==3}充值卡{/if}
              {if $item.type==4}虚拟奖品{/if}
          </td>
          <td>{$item.tm}</td>
          <td>{$item.oper_tm}</td>
          <td>
              {if $item.status==0}待领取{/if}
              {if $item.status==1}已领取{/if}
              {if $item.status==2}{if $item.type==2}等待发货{/if}{if $item.type==3}等待充值{/if}{/if}
              {if $item.status==3}已完成{/if}
          </td>
            <td>{if $item.type==3}充值电话号：{$item.charge_phone}{/if}
               </td>
          <td>
              {if $item.status==2}
                  {if $item.type==2}<a href="/admin/User/awardfahuo?id={$item.id}&log_id={$item.log_id}&status={$status}&type={$type}">发货</a>{/if}
                  {if $item.type==3}<a href="/admin/User/awardchongzhi?id={$item.id}&status={$status}&type={$type}"  onclick="if(confirm('确定已经充过值了吗?')==false)return false;">充值</a>{/if}
              {/if}
              {if $item.status==3}
                  {if $item.type==2}<a href="/admin/User/awardyifahuo?id={$item.id}&log_id={$item.log_id}&status={$status}&type={$type}">详细信息</a>{/if}
              {/if}
          </td>
        </tr>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
