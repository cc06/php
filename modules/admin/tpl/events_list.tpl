{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">活动列表</li>
</ol>

<form method="get" action="/admin/EventsList/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label"> 名称：</label>
                <input class="form-control" type="text" name="title" value="{if $title neq ""}{$title}{/if}">
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 50px;">编号</th>
        <th style="width: 50px;">ID</th>
        <th style="width: 50px;">小图</th>
        <th style="width: 100px;">大图</th>
        <th style="width: 200px;">标题</th>
        <th style="width: 50px;">时间</th>
        <th style="width: 50px;">风格</th>
        <th style="width: 70px;">操作</th>

    </tr>

    {foreach from=$events item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
          <td>{$item.id}</td>
          <td><img width="100" height="100" src="{$item.pic}" class="img-rounded"  /></td>
          <td>{if $item.content->pic  neq ""}<img width="200" height="100" src="{$item.content->pic}" class="img-rounded"  />{/if}</td>
          <td style="text-align: left;">
              {$item.title}
          </td>
            <td>{$item.tm}</td>
          <td>{if $item.style==2}有大图{else}无大图{/if}</td>
          <td>
              <a href="/admin/EventsList/list?shanchu_id={$item.id}">删除</a>
              <a href="/admin/EventsList/update?id={$item.id}">编辑</a>
          </td>
        </tr>
        <tr class="t_c"  style="vertical-align: middle">
            <td></td>
            <td colspan="6" style="text-align: left;">
                <strong>内容：</strong>{$item.content->text}
            </td>
        </tr>
        <tr class="t_c"  style="vertical-align: middle">
            <td></td>
            <td colspan="6" style="text-align: left;">
                <strong>按钮文字：</strong>{$item.content->buts[1]->tip}
                {if $item.content->buts[1]->cmd=="cmd_open_web"} <strong>操作：</strong>打开网页，<strong>链接地址：</strong>{$item.content->buts[1]->data->url}{/if}
                {if $item.content->buts[1]->cmd=="cmd_open_topic"} <strong>操作：</strong>打开圈子，<strong>圈子话题ID：</strong>{$item.content->buts[1]->data->id}{/if}
                {if $item.content->buts[1]->cmd=="cmd_entry_game"} <strong>操作：</strong>打开游戏，<strong>游戏ID：</strong>{$item.content->buts[1]->data->gid} <strong>战区ID：</strong>{$item.content->buts[1]->data->area_id}{/if}
            </td>
        </tr>
    {/foreach}
</table>
{include "pager.tpl"}
{include 'footer.tpl'}
