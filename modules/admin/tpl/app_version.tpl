{include 'header.tpl'}
<style type="text/css">
  .g_w .app_tr{
      height: 40px;
  }
    h2{
        font-size: 18px;
    }
</style>

<style>
    input{
        padding: 2px 5px;
        border:  1px solid;
    }
</style>
{*<h2 style="font-size: 18px;margin-top: 0px;" >版本列表</h2>*}

<ol class="breadcrumb">
    <li class="active" style="width:100%; "><a href="/admin/app/appList" style="margin-left:10px;text-decoration: underline">版本列表</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/admin/app/editAppVersion">添加新版本</a></li>
</ol>
<table class="table table-hover">
    <thead>
    <tr>
        <th style="width: 20px;">版本号</th>
        <th style="width: 30px;">显示版本</th>
        <th style="width: 50px;">升级类型</th>
        <th style="width: 180px;">描述</th>
        <th style="width: 50px;">操作</th>
    </tr>
    </thead>
    <tbody>
    {foreach $app_version as $v}
        <tr>
            <td>{$v.ver}</td>
            <td>
                {$v.title}
            </td>
            <td>
                {if $v.is_force ==1}
                    强制升级
                {else}
                    非强制升级
                {/if}
            </td>
            <td>
                {foreach from = $v.summary item="item" name="foo"}
                    <p style="margin: 0 0 0 0">{$item}</p>
                {/foreach}
            </td>
            <td>
                <a href="/admin/app/editAppVersion?ver={$v.ver}" style="margin-right: 10px">编辑</a>
                <a href="/admin/app/addUpdate?ver={$v.ver}">查看升级渠道</a>
            </td>
        </tr>
    {/foreach}
    </tbody>
    <tfoot>
    </tfoot>
</table>
<hr style="color: #DFD8D8;border: 2px solid;"/>
{include "pager.tpl"}
{include 'footer.tpl'}
