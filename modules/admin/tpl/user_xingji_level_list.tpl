{include 'header.tpl'}

<style>
    .table th { text-align:center; }
    .t_c td { text-align:center; }
    #show_table td{ line-height: 10px;}
    ul {
        margin:0;
        padding:0;
        list-style-type:none;
        font-size:0;
    }
    LI {
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
    <li class="active" style="width:100%;font-size: 14px; "><a href="/admin/UserXingji/list">秋千优秀用户星级评定</a>|<a href="/admin/UserXingji/level">星级用户</a></li>

 </ol>

<form method="get" action="/admin/UserXingji/level" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">UID：</label>
                <input class="form-control" type="text" name="uid" value="{if $uid >0}{$uid}{/if}">
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>
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
                          <tr id="user{$item.uid}">
                                <th style="width: 10px;">{$smarty.foreach.foo.index+1}</th>
                                <th style="width: 20px;">{$item.uid}</th>
                                <th style="width: 100px;text-align: left "><span>昵称：{$item.nickname}<br/>
                                        性别：{if $item.gender==2}女{/if}{if $item.gender==1}男{/if}
                                        </span></th>
                                <th style="width: 50px;"><img width="100" height="100" src="{$item.avatar}" class="img-rounded"  /></th>
                                <th style="width: 330px;">{foreach $item.photo_arr as $photo}
                                        {if $photo neq ""}<div style="float: left; width: 120px; height: 120px;"><img width="100" style="margin: 5px;float: left;" height="100" src="{$photo}"  class="img-rounded" /></div>{/if}
                                    {/foreach}</th>
                                <th style="width: 100px;">
                                    {if $item.level==0}放弃用户{/if}
                                    {if $item.level==1}一星用户{/if}
                                    {if $item.level==2}二星用户{/if}
                                    {if $item.level==3}三星用户{/if}
                                </th>
                            </tr>

                     {/foreach}

</table>


{include "pager.tpl"}
{include 'footer.tpl'}
