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


<ol class="breadcrumb">
    <li class="active" style="width:100%; "><a href="/admin/app/appList" style="margin-left:10px">版本列表</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/admin/app/editAppVersion" style="text-decoration: underline">添加新版本</a></li>
</ol>
<form method="post" action="/admin/app/editAppVersion" rel="ajax" id="app_form">
    <h2 style="font-size: 18px;">添加新版本</h2>
    <table class="g_w" cellspacing="1" cellpadding="3">
        {*如果bid = 430 ,那么这个需要特殊处理*}
        <tr class="app_tr">
            <th>显示版本：</th>
            <td>
                <input  name="title" id="title" value="{$app_version.title}"/> <span style="font-size: 12px;color: #838181;">例：v1.013 </span>
            </td>
        </tr>
        <tr class="app_tr" >
            <th>版本号：</th>
            <td>
                <input type="number" name="ver" value="{$app_version.ver}"/> <span style="font-size: 12px;color: #838181;">例：版本号：13 </span>
            </td>
        </tr>
        <tr class="app_tr" >
            <th>升级方式：</th>
            <td>
                <input type="radio" name="is_force"  id="is_f" {if $app_version.is_force==1} checked {/if} value="1"/> <label for="is_f" style="margin-right: 20px">强制升级</label>
                <input type="radio" name="is_force"  id="is_n_f" {if $app_version.is_force==0} checked {/if} value="0"  /> <label for="is_n_f">非强制升级</label>
            </td>
        </tr>

        <tr style="height: 20px"><td>&nbsp;</td></tr>

        <tr class="app_tr" >
            <th>版本描述：</th>
            <td>
                <textarea name="summary" style="width: 500px;height: 200px">{$app_version.summary}</textarea>
            </td>
        </tr>

        <tr class="app_tr" style="height: 80px">
            <th></th>
            <td>
                <input type="button" style="width: 79px;height: 31px;" onclick="checkAppVerInput();" name="" value="提交"/>
                <a href="/admin/app/appList" style="width: 79px;height: 31px; margin-left: 20px" >返回</a>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    function checkAppVerInput(){
        var title = $.trim($("#app_form input[name='title']").val());
        var ver = $.trim($("#app_form input[name='ver']").val());
        var summary = $.trim($("#app_form textarea[name='summary']").val());
        var is_force = $.trim($("#app_form input[name='is_force']:checked").val());
        if(title!=""){
            if(ver!=""){
                if(summary!=""){
                    $("#app_form").submit();
                }else{
                    alert("请填写描述");
                    return false;
                }
            }else{
                alert("请填写版本号");
                return false;
            }
        }else{
            alert("请填写显示版本");
            return false;
        }
    }
    /*$(function() {
        create_editor('summary');
    });*/
</script>
{include 'footer.tpl'}