{include file="header.tpl"}

<div class="g_w">

    <form method="post" id="myform" action="/admin/group/{$action}" rel="ajax" class="form-inline" role="form">
        <input type="hidden" name="gid" value="{$smarty.get.gid}">
        <div class="form-group">
            <table class="table">
                <tr><td>组名：<input type="text" autocomplete="off" id="username" size="25" class="form-control" name="group[name]" value="{$group_info.name}" /></td></tr>
                  <tr><td class="center-block"><button type="submit" name="ok" value="dosubmit" class="btn btn-primary">确定</button> &nbsp;<button type="reset" class="btn btn-primary">重置</button></td></tr>
            </table>
        </div>
    </form>
</div>
{include file="footer.tpl"}


