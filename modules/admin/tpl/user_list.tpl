{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active">所有秋千帐号</li>
</ol>

<form method="get" action="/admin/User/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">UID：</label>
                <input class="form-control" type="text" name="uid" value="{if $uid >0}{$uid}{/if}">
            </td>
            <td>
                <label for="form-w" class="control-label"> 昵称：</label>
                <input class="form-control" type="text" name="nickname" value="{if $nickname neq ""}{$nickname}{/if}">

            </td>
            <td>
                <label for="form-w" class="control-label"> 打招呼：</label>
                <input class="form-control" type="text" style="width: 50px;" name="sayhello" value="{if $sayhello neq ""}{$sayhello}{/if}"> 次以上
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 50px;">头像</th>
        <th style="width: 20px;">UID</th>
        <th style="width: 70px;">用户昵称</th>
        <th style="width: 30px;">性别</th>
        <th style="width: 30px;">年龄</th>
        <th style="width: 50px;">身高</th>
        <th style="width: 50px;">添加时间</th>
        <th style="width: 70px;">所在地</th>
        <th style="width: 50px;">状态</th>
        <th style="width: 50px;">操作</th>
    </tr>

    {foreach from=$users item=item name=foo}
      <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td><img width="50" height="50" src="{$item.avatar}" class="img-rounded"  /></td>
            <td>{$item.uid}</td>
            <td>{$item.nickname}</td>
            <td>{if $item.gender == 1}男 {else}女 {/if}</td>
            <td>{$item.age}</td>
            <td>{$item.height}</td>
            <td>{$item.reg_time}</td>
            <td>{$item.province}{$item.city}</td>
            <td id="stat{$item.uid}">
                {if $item.stat=="0"}正常{/if}
                {if $item.stat=="5"}<span style="color: #ff0000;">已封号</span>{/if}
            </td>
            <td>
                <a href="/admin/User/xiangxi?uid={$item.uid}">详细信息</a>
                {if $item.stat=="0"}<button  class="btn btn-primary" style="float:right;" onclick ="shenhe({$item.uid});">封闭此用户</button>{/if}
                {if $item.stat=="5"}<button  class="btn btn-primary" style="float:right;" onclick ="shenhe_che({$item.uid});">撤销封闭</button>{/if}</td>
        </tr>
    {/foreach}
</table>
<script>

    function shenhe(uid){
        a = confirm("确定封闭此用户吗？")
        if(!a){
            return

        }
        //
        var URL = "/admin/UserReport/shenhe?uid="+uid;
        $.get(URL,function(res){
            if (res="ok") {
                zhuangtai("stat"+uid+"");
            }else {
                alert("封闭失败");
            }
        });
        //
    }
    function shenhe_che(uid){
        a = confirm("确定撤销封闭此吗？")
        if(!a){
            return

        }
        //
        var URL = "/admin/UserReport/shenhe_che?uid="+uid;
        $.get(URL,function(res){
            if (res="ok") {
                zhuangtai_che("stat"+uid+"");
            } else {
                alert("撤销失败");
            }
        });
        //
    }

    //修改个人显示状态
    function zhuangtai(id){

        document.getElementById(id).innerHTML ='<span style="color: #ff0000;">已封号</span>';

    }
    //修改个人显示状态
    function zhuangtai_che(id){

        document.getElementById(id).innerHTML ='正常';

    }

</script>
{include "pager.tpl"}
{include 'footer.tpl'}
