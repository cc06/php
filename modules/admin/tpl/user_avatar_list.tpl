{include 'header.tpl'}

<style>
    .table th { text-align:center; }
    .t_c td { text-align:center; }
    #show_table td{ line-height: 10px;}
    #show_table  ul {
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
</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb" style="height: 100px;">
    <li class="active" style="width:100%;font-size: 14px; ">审核头像  <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button></li>
    <li class="active" style="width:100%;font-size: 14px; line-height: 20px; margin-top: 10px; ">
        <strong> 优秀</strong> - 推荐等级高(显示在附近和圈子)(长相好的);
        <strong>好</strong> - 推荐等级中等(显示在附近和圈子)(长相中等的);
        <strong>一般</strong> - 推荐等级低(显示在附近和圈子)(长相不好的)</li>
    <li class="active" style="width:100%;font-size: 14px; line-height: 20px; margin-top: 10px; ">
        <strong>不推荐</strong> - (不显示在附近和圈子中)(非真人头像);
     <strong>删除</strong> - 删除该用户头像,替换成默认头像(涉黄或反动的图片)</li>
 </ol>

<form method="get" action="/admin/UserAvatar/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">UID：</label>
                <input class="form-control" type="text" name="uid" value="{if $uid >0}{$uid}{/if}">
            </td>
            <td>
                <label for="form-w" class="control-label" style="padding-left: 5px;"> 昵称：</label>
                <input class="form-control" type="text" name="nickname" value="{if $nickname neq ""}{$nickname}{/if}">

            </td>
            <td>
                <label for="form-w" class="control-label" style="padding-left: 5px;"> 性别：</label>
                <select name="gender" id="form-select-cate-id">
                     <option value="" {if $gender==""} selected="selected" {/if} >全部</option>
                    <option value="2" {if $gender=="2"} selected="selected" {/if} >女</option>
                    <option value="1" {if $gender=="1"} selected="selected" {/if} >男</option>
                </select>

            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr><td><div style="float: left;"><ul>
                    {foreach from=$users item=item name=foo}
                    <li style="float: left; width:226px;" id="user{$item.uid}" >
                        <form rel="ajax" id="add_form" method="post" action="/admin/UserAvatar/shenhe" class="form-horizontal" role="form">
                        <div class="col-sm-10" style="float: left; width:226px; padding: 1px;" ><img id="img{$smarty.foreach.foo.index+1}" width="222" height=222" src="{$item.avatar}" class="img-rounded"  />
                        </div>
                            <span style="float: left; width:226px; font-size: 14px; margin-top: 5px; margin-left: 5px; line-height: 20px">
                                {if $item.gender == 1}男 {else}女 {/if}({$item.uid})
                               &nbsp;&nbsp;&nbsp;&nbsp; {if $item.uid_i > 1}<a href="/admin/User/list?uid={$item.uid_d}" target="_blank">共有{$item.uid_i}个用户使用</a> {/if}
                            </span>
                            <div style="float: left; width:226px; padding: 2px;">
                            <input type="hidden" name="size" id="size" value="{$smarty.foreach.foo.index+1}"/>
                            <input type="hidden" name="avatarlevel{$smarty.foreach.foo.index+1}" id="avatarlevel{$smarty.foreach.foo.index+1}"  value="{$item.uid},{$item.avatarlevel}"/>

                            <button id="button_{$smarty.foreach.foo.index+1}_1" onclick="shenhe({$item.uid},{$smarty.foreach.foo.index+1},1,'-1');" {if ($item.avatarlevel=='-1')}class="shenhe_dian"{else}class="shenhe"{/if} >审核不通过</button>
                            <button id="button_{$smarty.foreach.foo.index+1}_2" onclick="shenhe({$item.uid},{$smarty.foreach.foo.index+1},2,'0');" {if ($item.avatarlevel=='0')}class="shenhe_dian"{else}class="shenhe"{/if} >不推荐</button>
                            <button id="button_{$smarty.foreach.foo.index+1}_4" onclick="shenhe({$item.uid},{$smarty.foreach.foo.index+1},4,'6');" {if ($item.avatarlevel=='6')}class="shenhe_dian"{else}class="shenhe"{/if} >推荐到首页</button>
                            </div>
                     </form>

                   </li>
                     {/foreach}
                </ul></div></td></tr>

</table>

    <div class="form-group form-group-sm" style="margin-top: 5px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10" style="width:100%; ">
            <input type="hidden" name="size" id="size" value="{$smarty.foreach.foo.index+1}"/>
            <button  class="btn btn-primary" style="float:right;">提交</button>
        </div>
    </div>
<script>

    //选择审核状态
    function shenhe(id,avatarlevel,i,value){


             document.getElementById('button_'+avatarlevel+'_1').className="shenhe";
            document.getElementById('button_'+avatarlevel+'_2').className="shenhe";
            document.getElementById('button_'+avatarlevel+'_4').className="shenhe";

        document.getElementById('button_'+avatarlevel+'_'+i).className="shenhe_dian";
        document.getElementById('avatarlevel'+avatarlevel).value=id+","+value;
        document.getElementById('user'+id).style.display='none';

    }
    //隐藏头像
    function yincang(id){
       document.getElementById('user'+id).style.display='none';
    }


</script>
{include "pager.tpl"}
{include 'footer.tpl'}
