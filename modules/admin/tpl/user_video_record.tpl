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
    <li class="active" style="width:100%;font-size: 14px; ">审核视频  <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button></li>

 </ol>

<form method="get" action="/admin/VideoRecord/list" class="form-inline" >
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
        <th style="width: 70px;">用户昵称</th>
        <th style="width: 330px;">视频截图</th>
        <th style="width: 50px;">对比图</th>
        <th style="width: 50px;">操作</th>
    </tr>
    {foreach from=$users item=item name=foo}
                        <form rel="ajax" id="add_form" method="post" action="/admin/VideoRecord/shenhe" class="form-horizontal" role="form">
                            <tr id="user{$item.id}">
                                <th style="width: 10px;">{$smarty.foreach.foo.index+1}</th>
                                <th style="width: 20px;">{$item.uid}</th>
                                <th style="width: 70px;text-align: left ">{$item.nickname}<br/><br/><span>版本：{$item.sysver}<br/>机型：{$item.model} <br/>{$item.tm}</span></th>
                                <th style="width: 330px;">{$photos=explode(',',$item.photos)}{foreach $photos as $photo}
                                        {if $photo neq ""}<div style="float: left; width: 120px; height: 120px;"><div style="position: relative;"><div style="position: absolute;top: 0px; left: 0px;"><img width="100" style="margin: 5px;float: left;" height="100" src="{$photo}"  class="img-rounded" /></div><div style="position: absolute;top: 5px; right: 15px;"><img src="/images/h5/arr1.gif" style="cursor:pointer" onclick=""  /></div></div></div>{/if}
                                    {/foreach}</th>
                                <th style="width: 50px;"><img width="100" height="100" src="{$item.video_img}" class="img-rounded"  /></th>
                                <th style="width: 50px;"><input type="hidden" name="size" id="size" value="{$smarty.foreach.foo.index+1}"/>
                                    {if $item.status==0}
                                    <input type="hidden" name="avatarlevel{$smarty.foreach.foo.index+1}" id="avatarlevel{$smarty.foreach.foo.index+1}"  value="{$item.id},1"/>

                                    <button  onclick="shenhe({$item.id},'1',{$smarty.foreach.foo.index+1});" class="shenhe">通过</button>
                                    <button  onclick="shenhe({$item.id},'-1',{$smarty.foreach.foo.index+1});" class="shenhe">不通过</button>
                                {/if}
                                </th>
                            </tr>
                     </form>

                     {/foreach}

</table>


<script>

    //选择审核状态
    function shenhe(id,value,avatarlevel){

        document.getElementById('avatarlevel'+avatarlevel).value=id+","+value;
        document.getElementById('user'+id).style.display='none';

    }


</script>
<script type="text/javascript">
    function rotate(obj,arr){
        var img = document.getElementById(obj);
        if(!img || !arr) return false;
        var n = img.getAttribute('step');
        if(n== null) n=0;
        if(arr=='left'){
            (n==0)? n=3:n--;
        }else if(arr=='right'){
            (n==3)? n=0:n++;
        }
        img.setAttribute('step',n);
        //对IE浏览器使用滤镜旋转
        if(document.all) {
            img.style.filter = 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ n +')';
            //HACK FOR MSIE 8
            switch(n){
                case 0:
                    img.parentNode.style.height = img.height;
                    break;
                case 1:
                    img.parentNode.style.height = img.width;
                    break;
                case 2:
                    img.parentNode.style.height = img.height;
                    break;
                case 3:
                    img.parentNode.style.height = img.width;
                    break;
            }
            // 对现代浏览器写入HTML5的元素进行旋转： canvas
        }else{
            var c = document.getElementById('canvas_'+obj);
            if(c== null){
                img.style.visibility = 'hidden';
                img.style.position = 'absolute';
                c = document.createElement('canvas');
                c.setAttribute("id",'canvas_'+obj);
                img.parentNode.appendChild(c);
            }
            var canvasContext = c.getContext('2d');
            switch(n) {
                default :
                case 0 :
                    c.setAttribute('width', img.width);
                    c.setAttribute('height', img.height);
                    canvasContext.rotate(0 * Math.PI / 180);
                    canvasContext.drawImage(img, 0, 0);
                    break;
                case 1 :
                    c.setAttribute('width', img.height);
                    c.setAttribute('height', img.width);
                    canvasContext.rotate(90 * Math.PI / 180);
                    canvasContext.drawImage(img, 0, -img.height);
                    break;
                case 2 :
                    c.setAttribute('width', img.width);
                    c.setAttribute('height', img.height);
                    canvasContext.rotate(180 * Math.PI / 180);
                    canvasContext.drawImage(img, -img.width, -img.height);
                    break;
                case 3 :
                    c.setAttribute('width', img.height);
                    c.setAttribute('height', img.width);
                    canvasContext.rotate(270 * Math.PI / 180);
                    canvasContext.drawImage(img, -img.width, 0);
                    break;
            };
        }
    }
</script>

{include "pager.tpl"}
{include 'footer.tpl'}
