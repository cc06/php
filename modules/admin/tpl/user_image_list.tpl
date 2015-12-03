{include 'header.tpl'}

<style>

    #show_table td{ line-height: 10px;}
    #show_table    ul {
        margin:0;
        padding:0;
        list-style-type:none;
        font-size:0;
    }
    #show_table    LI {
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
    <li class="active" style="width:100%;font-size: 14px; "><a href="/admin/UserImage/list">审核图片</a>|<a href="/admin/UserImage/list2">第三方审核失败图片</a></li>

 </ol>


<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr><td><div style="float: left;"><ul>
                    {foreach from=$images item=item name=foo}
                    <li style="float: left; width:226px;" id="user{$smarty.foreach.foo.index+1}" >
                        <div class="col-sm-10" style="float: left; width:226px; padding: 1px;" ><img id="img{$smarty.foreach.foo.index+1}" width="222" height=222" src="{$item.url_xiao}" class="img-rounded"  />
                        </div>
                            <div style="float: left; width:226px; padding: 2px;">

                            <button id="button_{$smarty.foreach.foo.index+1}_1" onclick="shenhe('{$item.url}',{$smarty.foreach.foo.index+1},1,'0');" {if ($item.status=='0')}class="shenhe_dian"{else}class="shenhe"{/if} >正常</button>
                            <button id="button_{$smarty.foreach.foo.index+1}_2" onclick="shenhe('{$item.url}',{$smarty.foreach.foo.index+1},2,'1');" {if ($item.status=='1')}class="shenhe_dian"{else}class="shenhe"{/if} >不正常</button>
                            </div>

                   </li>
                     {/foreach}
                </ul></div></td></tr>

</table>


<script>

    //选择审核状态
    function shenhe(url,avatarlevel,i,value){

        var URL = "/admin/UserImage/shenhe";
        var data1 ={ url: url, status: value };
        $.post(URL,data1,function(data){
             //alert(data);
            if(data=="修改成功！"){

                document.getElementById('user'+avatarlevel).style.display='none';
            }

        });

    }

</script>
{include "pager.tpl"}
{include 'footer.tpl'}
