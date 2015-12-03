{include file="header.tpl"}
<script src="/js/jquery-1.7.1.min.js"></script>

<div class="g_w">
    <label class="sr-only" for="cat-id">分类</label>
    <form method="post" id="myform" action="/admin/manager/{$action}" class="form-inline" role="form" onSubmit="return docheck();">
        <input type="hidden" name="id" id="id" value="{$smarty.get.uid}">
        <div class="form-group">
            <table class="table">
                <tr><td>用户名：<input type="text" autocomplete="off" id="username" size="25" class="form-control" name="manager[username]" value="{$manager.username}" tip="用户名不能为空" /></td></tr>
                <tr><td>密 &nbsp;&nbsp;&nbsp;码：<input size="25" id="password" class="form-control" type="password" name="password" value="" {if $action == 'add'}reg="" tip="密码不能为空"{/if} /></td></tr>
                <tr><td>邮 &nbsp;&nbsp;&nbsp;箱：<input  size="25"  id="email" class="form-control" type="text" name="manager[email]" value="{$manager.email}" reg="" tip="邮箱地址，如yuanzhouwe@163.com" /></td></tr>
                <tr><td>性 &nbsp;&nbsp;&nbsp;别：<input type="radio" name="manager[sex]" value="1" {if $manager.sex=='1'}checked="checked"{/if}>男 <input type="radio" {if $manager.sex=='0'}checked="checked"{/if} name="manager[sex]" value="0">女</td></tr>
                <tr><td>状 &nbsp;&nbsp;&nbsp;态： {FUI::getSelector("manager[status]",$status,$manager.status)}</a></td></tr>
                <tr><td>工作组： {FUI::getSelector("manager[gid]",$group,$manager.gid)}</td></tr>
                <tr><td>权 &nbsp;&nbsp;&nbsp;限：</td></tr>
                <tr><td><table width="90%" align="center" border="0" cellspacing="0" cellpadding="0">
                            {foreach from=$top_menus item=top_menu key=i}
                            <tr> <td  height="25" bgcolor="#FFFFFF" align="left">
                                    <input type="checkbox" name="quanxianid[]" id="quanxianid_{$top_menu.id}"  onclick="quanxiancheck({$top_menu.id})" value="{$top_menu.id}" {$top_menu.checked}  >
                                    {$top_menu.name}</td>
                            </tr>
                            <tr>
                                <td   bgcolor="#FFFFFF" align="left" id="fenlei_{$top_menu.id}">
                                    <table width="98%" align="center" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="padding:10px;">
                                            <div  style="overflow:hidden;"><ul style="overflow:hidden;margin:0;padding:0;">
                                                    {foreach from=$top_menu.left_menus item=left_menu}
                                                    <li style="list-style-type:none;float: left;margin:0;padding:0; width:130px; height:25px; text-align:left; "><input wxw="quanxianidx_{$top_menu.id}" type="checkbox"  name="quanxianidx[]" value="{$left_menu.id}" {$left_menu.checked}  >{$left_menu.name}</li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                </table></td></tr>
                           {/foreach}
                        </table></td></tr>
                <tr><td>备 &nbsp;&nbsp;&nbsp;注： <textarea cols="180" rows="6" name="manager[comment]">{$manager.comment}</textarea></td></tr>
                <tr><td class="center-block"><button type="submit" name="ok" value="dosubmit" class="btn btn-primary">确定</button> &nbsp;<button type="reset" class="btn btn-primary">重置</button></td></tr>
            </table>
        </div>
    </form>
</div>
<script type="application/javascript">
    function docheck(form){
        if($("#username").val()===''){
            alert("用户名不能为空！");
            return false;
        }
        if($("#id").val()===''&&$("#password").val()===''){
            alert("密码不能为空！");
            return false;
        }
        if($("#email").val()===''){
            alert("邮箱不能为空！");
            return false;
        }
        return true;
    }
    function quanxiancheck(did){

        if(document.getElementById("quanxianid_"+did).checked){
            //alert(did);
            $("input[wxw='quanxianidx_"+did+"']").attr("checked", true);
        } else {
            $("input[wxw='quanxianidx_"+did+"']").attr("checked", false);
        }

    }
</script>
{include file="footer.tpl"}

