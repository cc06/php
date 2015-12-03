{include 'header.tpl'}

<style>


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
    .search_table td{
        padding-right:20px;
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
<form method="get" action="/admin/UserAvatarAdd/list" id="search_form" class="form-inline" >
<table class="search_table">
            <td>性别：&nbsp;&nbsp;<input type="radio" name="gender" {if $gender==2}checked {/if} value="2"/> 男&nbsp;&nbsp;&nbsp; <input type="radio"  name="gender" value="1" {if $gender==1}checked {/if} /> 女 </td>
             <td>年龄：<select name="age">
                    {section name=foo loop=30}
                        <option  value="{$smarty.section.foo.index+18}" {if $age==($smarty.section.foo.index+18)}selected="selected" {/if}>{$smarty.section.foo.index+18}</option>
                    {/section}
                </select></td>
</table>
<table style="width:100%;">
    <tr>
        <td>
            省份：
            <div class="" id="city1" style="width:100%;">
                <input type="hidden"  name="province" id="province" value=""/>
                {foreach from=$provinces item=item name=foo}
                        <span type="button" style="border:1px #cfcfcf solid; padding: 2px;float: left;margin: 2px;cursor:pointer;" {if ($item.city==$province)}class="shenhe_dian"{else}class="shenhe"{/if}  onclick="setProvince('{$item.city}')"/>{$item.city}</span>
                {/foreach}
            </div>
        </td>
    </tr>
</table>
</form>
<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr><td><div style="float: left;"><ul>
                    {if $status=='ok'}
                        {foreach from=$users item=item name=foo}
                            {$u}
                            <li style="float: left; width:226px;" id="user{$item->uid}" >
                                <form rel="ajax" id="add_form" method="post" action="/admin/UserAvatarAdd/shenhe" class="form-horizontal" role="form">
                                    <div class="col-sm-10" style="float: left; width:226px; padding: 1px;" ><img id="img{$smarty.foreach.foo.index+1}" width="222" height=222" src="{$item->avatar}" class="img-rounded"  /> </div>
                                    <div style="line-height: normal"> <span style="">{$item->age}岁 &nbsp;&nbsp;{$item->province}</span> &nbsp;&nbsp;{$item->localtag}</div>
                                    <div style="float: left; width:226px; padding: 1px;">
                                        <input type="hidden" name="size" id="size" value="{$smarty.foreach.foo.index+1}"/>
                                        <input type="hidden" name="avatarlevel{$smarty.foreach.foo.index+1}" id="avatarlevel{$smarty.foreach.foo.index+1}"  value="{$item->uid},{$item->avatarLevel}"/>
                                        <span style="font-size: 14px; margin-top: -5px; margin-left: 5px;">{if $item->gender == 1}男 {else}女 {/if}</span>
                                        <button id="button_{$smarty.foreach.foo.index+1}_1" onclick="shenhe({$item->uid},{$smarty.foreach.foo.index+1},1,'-1');" {if ($item->avatarLevel=='-1')}class="shenhe_dian"{else}class="shenhe"{/if} >删除</button>
                                        <button id="button_{$smarty.foreach.foo.index+1}_2" onclick="shenhe({$item->uid},{$smarty.foreach.foo.index+1},2,'0');" {if ($item->avatarLevel=='0')}class="shenhe_dian"{else}class="shenhe"{/if} >不推荐</button>
                                        <button id="button_{$smarty.foreach.foo.index+1}_3" onclick="shenhe({$item->uid},{$smarty.foreach.foo.index+1},3,'3');" {if ($item->avatarLevel=='3')}class="shenhe_dian"{else}class="shenhe"{/if} >一般</button>
                                        <button id="button_{$smarty.foreach.foo.index+1}_4" onclick="shenhe({$item->uid},{$smarty.foreach.foo.index+1},4,'6');" {if ($item->avatarLevel=='6')}class="shenhe_dian"{else}class="shenhe"{/if} >好</button>
                                        <button id="button_{$smarty.foreach.foo.index+1}_5" onclick="shenhe({$item->uid},{$smarty.foreach.foo.index+1},5,'9');" {if ($item->avatarLevel=='9')}class="shenhe_dian"{else}class="shenhe"{/if} >优秀</button>
                                    </div>
                                </form>
                            </li>
                        {/foreach}
                    {/if}
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

        for (var j=1;j<=4;j++){
            document.getElementById('button_'+avatarlevel+'_'+j).className="shenhe";
        }
        document.getElementById('button_'+avatarlevel+'_'+i).className="shenhe_dian";
        document.getElementById('avatarlevel'+avatarlevel).value=id+","+value;
        document.getElementById('user'+id).style.display='none';

    }
    //隐藏头像
    function yincang(id){
        document.getElementById('user'+id).style.display='none';
    }

    // 较验字段
    function setProvince(v){
        $("#province").val(v);
        $("#search_form").submit();
        return true;
    }

</script>
{include "pager.tpl"}
{include 'footer.tpl'}
