{include 'header.tpl'}

<style>
    .table th { text-align:center; }
    .t_c td { text-align:center; }
    #show_table td{ line-height: 10px;}
    #show_table ul {
        margin:0;
        padding:0;
        list-style-type:none;
        font-size:0;
    }
    #show_table  LI {
        FLOAT:left;
        PADDING-BOTTOM:0px;
        MARGIN:0px;
        PADDING-LEFT:0px;
        PADDING-RIGHT:0px;
        FONT-SIZE:12px;
        PADDING-TOP:0px;
        margin-bottom: 10px;
    }
.shenhe {
    float: right;
    border: 0;
   margin-top: 5px;
    margin-right: 10px;
    color: #428bca;
    background-color: #fff;
    border: 1px solid #ddd;
    padding: 6px 7px;
    margin-left: -1px;
    line-height: 1.42857143;
}
    .shenhe:hover {
        color: #2a6496;
        background-color: #eee;
        border-color: #ddd;
    }
    .shenhe_dian {
        float: right;
        border: 0;
        margin-top: 5px;
        padding: 6px 7px;
        margin-left: -1px;
        line-height: 1.42857143;
        color: #fff;
        background-color: #428bca;
        border: 1px solid #ddd;
    }
    input:focus {
        outline:none;
    }
    .rot90{ -moz-transform:rotate(90deg); -webkit-transform:rotate(90deg); transform:rotate(90deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}
    .rot180{ -moz-transform:rotate(180deg); -webkit-transform:rotate(180deg); transform:rotate(180deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}
    .rot270{ -moz-transform:rotate(270deg); -webkit-transform:rotate(270deg); transform:rotate(270deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb" style="height: 50px;">
    <li class="active" style="width:100%;font-size: 14px; "><a href="/admin/UserXingji/list">秋千优秀用户星级评定</a>|<a href="/admin/UserXingji/level">星级用户</a>  <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button></li>

 </ol>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 20px;">UID</th>
        <th style="width: 100px;">用户昵称</th>
        <th style="width: 50px;">头像</th>
        <th style="width: 330px;">照片</th>
        <th style="width: 100px;">操作</th>
    </tr>
    {foreach from=$users item=item name=foo}
                        <form rel="ajax" id="add_form" method="post" action="/admin/UserXingji/shenhe" class="form-horizontal" role="form">
                            <tr id="user{$item.uid}">
                                <th style="width: 10px;">{$smarty.foreach.foo.index+1}</th>
                                <th style="width: 20px;">{$item.uid}</th>
                                <th style="width: 100px;text-align: left "><span>昵称：{$item.nickname}<br/>
                                        性别：{if $item.gender==2}女{/if}{if $item.gender==1}男{/if}<br/>
                                        手机认证：{if $item.phonestat==1}通过{else}未通过{/if}<br/>
                                        视频认证：{if $item.certify_video==1}通过{else}未通过{/if}<br/>
                                        身份证认证：{if $item.certify_idcard==1}通过{else}未通过{/if} </span></th>
                                <th style="width: 50px;"><img width="100" height="100" src="{$item.avatar}" class="img-rounded"  /></th>
                                <th style="width: 330px;">{foreach $item.photo_arr as $photo}
                                        {if $photo neq ""}<div style="float: left; width: 120px; height: 120px;"><img width="100" style="margin: 5px;float: left;" height="100" src="{$photo}"  class="img-rounded" /></div>{/if}
                                    {/foreach}</th>
                                <th style="width: 100px;"><input type="hidden" name="size" id="size" value="{$smarty.foreach.foo.index+1}"/>
                                    {if $item.status==0}
                                    <input type="hidden" name="avatarlevel{$smarty.foreach.foo.index+1}" id="avatarlevel{$smarty.foreach.foo.index+1}"  value="{$item.uid},{$item.gender},1"/>

                                    <button  onclick="shenhe({$item.uid},{$item.gender},'1',{$smarty.foreach.foo.index+1});" class="shenhe">一星</button>
                                    <button  onclick="shenhe({$item.uid},{$item.gender},'0',{$smarty.foreach.foo.index+1});" class="shenhe">放弃</button>
                                {/if}
                                </th>
                            </tr>
                     </form>

                     {/foreach}

</table>


<script>

    //选择审核状态
    function shenhe(id,gender,value,avatarlevel){

        document.getElementById('avatarlevel'+avatarlevel).value=id+","+gender+","+value;
        document.getElementById('user'+id).style.display='none';

    }


</script>
{include "pager.tpl"}
{include 'footer.tpl'}
