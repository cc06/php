{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/WeixinHuodong/list" style="margin-left:0px">微信活动列表</a> | <a  href="/admin/WeixinHuodong/add" style="margin-left:0px">添加微信活动</a></li>
</ol>

<style>
    .goods_pic li {
        position: relative;
        list-style: none;
        width: 100px;
        height: 100px;
        display: block;
        float: left;
        margin: 20px;
    }
    .btn-img-remove1 {
        cursor: pointer;
        position: absolute;
        display: block;
        top: 5px;
        left: 5px;
    }
    .btn-img-set-cover {
        cursor: pointer;
        /*position: absolute;*/
        display: block;
        top: 5px;
        left: 25px;
    }
</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>
<script type="text/javascript" src="/js/flib.js"></script>
<link rel="stylesheet" href="/css/skins/square/blue.css"/>
{*<script src="/js/icheck.min.js"></script>*}

 <div class="row">
        <div class="col-xs-1"></div>
    </div>
<div class="form-horizontal">
    <div class="form-group form-group-sm" id="anniu1">
        <label for="input-title" class="col-sm-2 control-label">标题： </label>
        <div class="col-sm-10">
            <input id="title_f" type="text" name="title_f" value="{$weixin_huodong.title}" class="form-control" style="width: 500px;"/>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">内容说明： </label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <textarea id="text_f" type="text" name="text_f"
                   class="form-control" reg="" tip="内容说明" style="width: 600px; height: 100px;">{$weixin_huodong.text}</textarea>
        </div>

    </div>
</div>
<form   method="post" enctype="multipart/form-data" id="upload_form" class="form-horizontal">
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">图片： </label>
        <div class="col-sm-10" style="float: left; width: 320px;">

            <input type="file" name="file_name"><img src="" id="show_img">

            <input type="button" name="" value="上传" id="upload_but" onclick="doupload()" />
        </div>
        <div class="col-sm-10" style="float: left; width: 110px; height: 110px; display: none;" id="pic_xiao">

        </div>
        <div class="col-sm-10" style="float: left; width: 150px; line-height: 30px;">
            尺寸100*100
        </div>
    </div>
</form>

<form rel="ajax" id="add_form" method="post" action="/admin/WeixinHuodong/update?id={$id}" class="form-horizontal"
      role="form" onsubmit="return checkFiled()">

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">链接地址： </label>
        <div class="col-sm-10">
            <input id="url" type="text" name="url" value="{$weixin_huodong.url}" class="form-control" style="width: 500px;"/>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">排序： </label>
        <div class="col-sm-10">
            <input id="position" type="text" name="position" value="{{$weixin_huodong.position}}" class="form-control" style="width: 100px;"/>
            整数，越小越靠前
        </div>
    </div>
    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
            <input type="hidden" name="text" id="text" value="{$weixin_huodong.text}" />
            <input type="hidden" name="title" id="title" value="{$weixin_huodong.title}" />
            <input type="hidden" name="pic" id="pic" value="{$weixin_huodong.pic}" />
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>


<script type="text/javascript">


    function submitFun() {
        document.getElementById('text').value=document.getElementById('text_f').value;
        document.getElementById('title').value=document.getElementById('title_f').value;
    }

    function doupload(){
        $("#upload_form").ajaxSubmit({
            type: 'post',
            url: "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000" ,
            success: function(data){
               // alert(data.msg);

                if(data.msg=="上传成功"){
                    document.getElementById('pic').value=data.res.file_http_path;
                    document.getElementById('pic_xiao').style.display="block";
                    document.getElementById('pic_xiao').innerHTML='<img width="100" style="margin: 5px" height="100" src="'+data.res.file_http_path+'"  class="img-rounded"/>';
                   }
             },
            error: function(XmlHttpRequest, textStatus, errorThrown){
                alert( "error");
            }
        });
    }

    {if $weixin_huodong.pic  neq ""}
    document.getElementById('pic_xiao').style.display="block";
    document.getElementById('pic_xiao').innerHTML='<img width="100" style="margin: 5px" height="100" src="{$weixin_huodong.pic}"  class="img-rounded"/>';
    {/if}



</script>

{include "footer.tpl"}
