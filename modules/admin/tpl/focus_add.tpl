{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/FocusList/list?type={$type}" style="margin-left:0px">焦点图列表</a> | <a  href="/admin/FocusList/add?type={$type}" style="margin-left:0px">添加焦点图</a></li>
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

<div class="form-horizontal" {if $type=="loginPopup"} style="display: none;" {/if}  >

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">内容说明：<br> 不超过200个字</label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <textarea id="text_f" type="text" name="text_f"
                   class="form-control" reg=""  tip="内容说明" style="width: 600px; height: 300px;"></textarea>
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
<form rel="ajax" id="add_form" method="post" action="/admin/FocusList/add" class="form-horizontal"
      role="form" onsubmit="return checkFiled()" >
    <div class="form-group form-group-sm" style="display: none;">
        <label for="input-title" class="col-sm-2 control-label">类型： </label>
        <div class="col-sm-10">
            <select name="type">
                <option value="main" {if $type=="main"} selected {/if} >广场</option>
                <option value="loginPopup" {if $type=="loginPopup"} selected {/if} >登陆弹窗</option>
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">操作： </label>
        <div class="col-sm-10">
            <select name="anniu_caozuo" onChange="anniu_select(this)">
                <option value="1">打开网页</option>
                <option value="2">打开活动列表界面</option>
                <option value="3">打开某个活动</option>
                <option value="4">打开活动中奖清单</option>
                <option value="5">打开游戏</option>
        </select>
    </div>
    </div>

    <div class="form-group form-group-sm" id="anniu1">
        <label for="input-title" class="col-sm-2 control-label">输入链接地址： </label>
        <div class="col-sm-10">
            <input id="url" type="text" name="url" value="" class="form-control" style="width: 500px;"/>
        </div>
    </div>
    <div class="form-group form-group-sm" id="anniu2">

    </div>
    <div class="form-group form-group-sm" id="anniu3">
        <label for="input-title" class="col-sm-2 control-label">活动ID： </label>
        <div class="col-sm-10">
            <input id="events_id" type="text" name="events_id" value="" class="form-control" style="width: 100px;"/>
        </div>
    </div>
    <div class="form-group form-group-sm" id="anniu4">

    </div>

    <div class="form-group form-group-sm" id="anniu5">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>请选择游戏和区： </label>
        <div class="col-sm-10">
            <select name="gid">
                <option value="1">飞机大战</option>
            </select>
            <select name="area_id" >
                <option value="1">战区1</option>
            </select>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">排序： </label>
        <div class="col-sm-10">
            <input id="position" type="text" name="position" value="" class="form-control" style="width: 100px;"/>
            整数，越小越靠前
        </div>
    </div>
    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
            <input type="hidden" name="text" id="text" value=""/>
            <input type="hidden" name="pic" id="pic" value=""/>
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>


<script type="text/javascript">
    $(function () {
        create_editor('text_f');

    });
    $('#anniu2').hide();
    $('#anniu3').hide();
    $('#anniu4').hide();
    $('#anniu5').hide();
    function anniu_select(selObj){

        $('#anniu1').hide();
        $('#anniu2').hide();
        $('#anniu3').hide();
        $('#anniu4').hide();
        $('#anniu5').hide();
        $('#anniu'+selObj.options[selObj.selectedIndex].value).show();

    }
    function submitFun() {
        document.getElementById('text').value=document.getElementById('text_f').value;
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

</script>

{include "footer.tpl"}
