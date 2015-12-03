{include 'header.tpl'}

<style>

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

<ol class="breadcrumb" style="height: 60px;">
    <li class="active" style="width:100%;font-size: 14px; "><a href="/admin/UserImage/list">审核图片</a>|<a href="/admin/UserImage/list2">第三方审核失败图片</a>  <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button></li>

 </ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr><td><div style="float: left;"><ul>
                    {foreach from=$images item=item name=foo}
                    <li style="float: left; width:126px;" id="user{$smarty.foreach.foo.index+1}" >
                        <form rel="ajax" id="add_form" method="post" action="/admin/UserImage/shenhe" class="form-horizontal" role="form">
                        <div class="col-sm-10" style="float: left; width:126px; padding: 1px;" ><img id="img{$smarty.foreach.foo.index+1}" width="111" height=111" src="{$item.url_xiao}" class="img-rounded"  />
                        </div>
                            <div style="float: left; width:126px; padding: 2px;">
                           类型：{$item.type_w}；</div>
                            <div style="float: left; width:126px; padding: 2px;">
                                UID：<a href="/admin/User/list?uid={$item.uid}" target="_blank">{$item.uid}</a> ； </div>
                     </form>

                   </li>
                     {/foreach}
                </ul></div></td></tr>

</table>

{include "pager.tpl"}
{include 'footer.tpl'}
