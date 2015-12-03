{*{include file="top_new.tpl"}*}
{include 'header.tpl'}

<form method="post" action="/admin/manager/list" class="form-inline" role="form">
    <div class="form-group">
		<input type="text" name="search" value="{$smarty.post.search}" class="form-control" placeholder="输入账号进行查找" required autofocus>
    </div>
    <button type="submit" class="btn btn-primary">查找</button>
    <button type="button" class="btn btn-sm" onclick="location='/admin/manager/edit';">添加管理员</button>
</form>



<table class="g_w table">
    <thead>
    <tr>
        <th width="80px">UID</th>
        <th width="">UserName</th>
        <th width="150px">操作</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$managerList item=item}
        <tr>
            <td>{$item.uid}</td>
            <td>{$item.username}</td>
            <td>
                <a href="/admin/manager/edit?uid={$item['uid']}">编辑</a>&nbsp;&nbsp;
                <a href="/admin/manager/delete?uid={$item['uid']}" class="btn-delete">删除</a>
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
{*{include 'footer_new.tpl'}*}
{include 'footer.tpl'}
