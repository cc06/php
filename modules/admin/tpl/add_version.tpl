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
    .add_tables td{
        width: 300px;
    }
</style>
<ol class="breadcrumb">
    <li class="active" style="width:100%; "><a href="/admin/app/appList" style="margin-left:10px;text-decoration: underline">版本列表</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="/admin/app/editAppVersion" style="">添加新版本</a></li>
</ol>
<table class="table table-hover">
    <thead>
    <tr>
        <th style="width: 100px;">版本号</th>
        <th style="width: 200px;">显示版本</th>
        <th style="width: 100px;">升级类型</th>
        <th style="">描述</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td>{$app_version.ver}</td>
            <input id="app_ver" type="hidden" value="{$app_version.ver}"/>
            <td>
                {$app_version.title}
            </td>
            <td>
                {if $app_version.is_force ==1}
                    强制升级
                {else}
                    非强制升级
                {/if}
            </td>
            <td>
                {foreach from = $app_version.summary item="item" name="foo"}
                    <p style="margin: 0 0 0 0">{$item}</p>
                {/foreach}
            </td>
        </tr>
    </tbody>
    <tfoot>
    </tfoot>
</table>

<h2 style="font-size: 13px;margin-top: 0px;" >已发布渠道</h2>
<table class="table table-hover">
    <thead>
    <tr>
        <th style="width: 100px;">主渠道</th>
        <th style="width: 100px;">子渠道</th>
        <th style="width: 300px;">时间</th>
        <th style="width: 100px;">操作</th>
    </tr>
    </thead>
    <tbody>
    {foreach $update_data as $v}
    <tr>
        <td>{if $v.c_uid==0}全部渠道{else}{$v.c_uid}{/if}</td>
        <td>
            {if $v.c_sid==0}全部渠道{else}{$v.c_sid}{/if}
        </td>
        <td>
            {$v.tm}
        </td>
        <td>
            {if $v.status==0}
                <a href="javascript:void();" onclick="update({$v.ver},{$v.c_uid},{$v.c_sid},1)">打开</a>
            {else}
                <a href="javascript:void();" onclick="update({$v.ver},{$v.c_uid},{$v.c_sid},0)">关闭</a>
            {/if}

        </td>
    </tr>
    {/foreach}
    </tbody>
    <tfoot>
    </tfoot>
</table>
<hr style="color: #DFD8D8;border: 2px solid;"/>
    <h2 style="font-size: 18px;">添加单个升级渠道 </h2>
    <table class="add_tables" id="add_table" >
        <tr class="app_tr" style="width: 600px">
            <td>主渠道：
                <select  name="c_uid" id="form-search-cuid" onchange="setSpm()">
                    <option value="2">测试渠道（2-999）</option>
                    {foreach from=$spmList key=c_uid item=c_name}
                        <option value="{$c_uid}">{$c_uid}({$c_name})</option>
                    {/foreach}
                </select>
            </td>
            <td>子渠道：
                <select  name="c_sid" id="form-search-csid">
                    <option value="999">测试子渠道（2-999）</option>
                </select>
            </td>
            <td>
                <input type="button" value="添加" onclick="add(1)" style="margin-right: 50px"/>
            </td>
        </tr>
    </table>
<hr style="color: #DFD8D8;border: 2px solid;"/>

<h2 style="font-size: 18px;"> 全部渠道：  <input type="button"  value="升级所有渠道" onclick="add(2)" /> </h2><span style="color: red">谨慎操作，所有渠道升级</span>

<div>



</div>

<script type="text/javascript">
    function setSpm(){
        var cuid = $("#form-search-cuid").find('option:selected').val();
        var items = eval('({$spmarr})');
        var tag_obj = $("#form-search-csid");

        var arr = new Array();
        arr[arr.length] = '<option value="999">测试渠道（2-999)</option>';
        var len = items.length;
        for(var i = 0; i<len;i++){
            if(items[i].c_uid == cuid && items[i].c_sid != ""){
                arr[arr.length] = '<option value="'+items[i].c_sid+'">'+items[i].c_sid+'</option>';
            }
        }
        tag_obj.html(arr.join(""));
    }

    function add(flag){
        var c_uid = "-1";
        var c_sid = "-1";
        if(flag ==1 ){
             c_uid = $("#form-search-cuid").find('option:selected').val();
             c_sid = $("#form-search-csid").find('option:selected').val();
             if(c_uid==""||c_sid == ""){
                 alert("请选择渠道");
                 return false;
             }
        }else if(flag == 2){
            c_uid= "0";
            c_sid= "0";
            if(!confirm("该操作会升级所有渠道，请慎重操作？")){
                return;
            }
        }
        if(c_uid=="-1"||c_sid =="-1"){
            alert("请选择渠道");
            return false;
        }
        var ver = $("#app_ver").val();
        var URL = "/admin/app/doAdd?ver="+ver+"&c_uid="+c_uid+"&c_sid="+c_sid;

        $.get(URL,function(res){
            var names = "";
            //var data = eval('('+res+')');
            if(res.code=="200") {
                alert("操作成功");
            }else{
                alert("操作失败");
            }
            location.reload();
        });


    }

    function update(ver,c_uid,c_sid,status){
        var t = "";
        if(status==0){
            t= "该操作会关闭该渠道升级，是否确定？";
        }else if(status==1){
            t= "该操作会打开该渠道升级，是否确定？";
        }
        if(!confirm(t)){
            return;
        }
        var URL = "/admin/app/update?ver="+ver+"&c_uid="+c_uid+"&c_sid="+c_sid+"&status="+status;
        $.get(URL,function(res){
            var names = "";
            //var data = eval('('+res+')');
            if(res.code=="200") {
              //  alert("操作成功");
            }else{
                alert("操作失败");
            }
            location.reload();
        });
    }

</script>
{include 'footer.tpl'}