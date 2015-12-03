{include 'header.tpl'}

<table class="tmain g_w">
    <button type="button" class="button primary" onclick="location='/admin/group/add';">添加用户组</button>
    <tr>
        <th style="width: 100px;">ID</th>
        <th style="width: 200px;">组名</th>
        <th style="width: auto">操作</th>
    </tr>
    <!-- {foreach from=$groupList item=item} -->
    <tr class="t_c">
        <td>{$item.gid}</td>
        <td>{$item.name}</td>

        <td>
            &nbsp;
            <a href="/admin/group/modify?gid={$item.gid}">修改</a>
            &nbsp;
            <a href="/admin/group/delete?gid={$item.gid}" rel="true">删除</a>
        </td>
    </tr>
    <!-- {/foreach} -->
</table>
{include 'footer.tpl'}
