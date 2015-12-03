{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">编辑活动</li>
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

<link rel="stylesheet" type="text/css" href="/css/jquery.datetimepicker.css"/ >
<script src="/js/jquery.datetimepicker.js"></script>
 <div class="row">
        <div class="col-xs-1"></div>
    </div>
<div class="form-horizontal">
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>活动标题： </label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <input id="text_f" type="text" name="text_f"  value="{$events.title}"
                   class="form-control" reg="" tip="活动标题不能为空" style="width: 300px;"/>
        </div>
        <div class="col-sm-10" style="float: left; width: 100px; line-height: 30px;">
            20字以内
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>活动内容：<br>不超过200个字 </label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <textarea id="textlong_f" type="text" name="textlong_f"
                   class="form-control" reg="" tip="活动内容不能为空" style="width: 600px; height: 300px;">{$events.content->text}</textarea>
        </div>
    </div>
</div>
<form   method="post" enctype="multipart/form-data" id="upload_form" class="form-horizontal">
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>活动小图： </label>
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
<form   method="post" enctype="multipart/form-data" id="upload_form2" class="form-horizontal">
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">活动大图： </label>
        <div class="col-sm-10" style="float: left; width: 320px;">


            <input type="file" name="file_name"><img src="" id="show_img">

            <input type="button" name="" value="上传" id="upload_but" onclick="doupload2()" />

        </div>
        <div class="col-sm-10" style="float: left; width: 410px; height: 210px; display: none;" id="picda_xiao">

        </div>
        <div class="col-sm-10" style="float: left; width: 150px; line-height: 30px;">
            尺寸400*200
        </div>
    </div>
    </form>
<form rel="ajax" id="add_form" method="post" action="/admin/EventsList/update?id={$id}" class="form-horizontal"
      role="form" onsubmit="return checkFiled()">

<div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>按钮文字： </label>
        <div class="col-sm-10" style="float: left; width: 220px;">
            <input id="tip" type="text" name="tip" value="{$events.content->buts[1]->tip}" class="form-control" tip="按钮文字不能为空" style="width: 200px;"/>
        </div>
        <div class="col-sm-10" style="float: left; width: 200px; line-height: 30px;">
            不超过10个字
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>按钮操作： </label>
        <div class="col-sm-10">
            <select name="anniu_caozuo"  onChange="anniu_select(this)">
            <option value="1" {if $events.content->buts[1]->cmd=="cmd_open_web"} selected {/if}>打开网页</option>
            <option value="2" {if $events.content->buts[1]->cmd=="cmd_open_topic"} selected {/if}>打开圈子</option>
            <option value="3" {if $events.content->buts[1]->cmd=="cmd_entry_game"} selected {/if}>打开游戏</option>
        </select>
    </div>
    </div>

    <div class="form-group form-group-sm" id="anniu1">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>输入链接地址： </label>
        <div class="col-sm-10">
            <input id="url" type="text" name="url" value="{$events.content->buts[1]->data->url}" class="form-control" style="width: 500px;"/>
        </div>
    </div>
    <div class="form-group form-group-sm" id="anniu2">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>输入圈子话题ID： </label>
        <div class="col-sm-10">
            <input id="topic_id" type="text" name="topic_id" value="{$events.content->buts[1]->data->id}" class="form-control" style="width: 100px;"/>
        </div>
    </div>
    <div class="form-group form-group-sm" id="anniu3">
        <label for="input-title" class="col-sm-2 control-label"><span style="font-size: 12px;">（必填）</span>请选择游戏和区： </label>
        <div class="col-sm-10">
            <select name="gid">
                <option value="1" {if $events.content->buts[1]->data->gid=="1"} selected {/if}>飞机大战</option>
            </select>
            <select name="area_id" >
                <option value="1" {if $events.content->buts[1]->data->area_id=="1"} selected {/if}>战区1</option>
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">结束时间：</label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <input style="border: 1px solid"  id="datetimepicker" name="timeout" value="{$events.timeout}"/>
        </div>
    </div>
    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
            <input type="hidden" name="text" id="text" value="{$events.title}"/>
            <input type="hidden" name="textlong" id="textlong" value="{$events.content->text}"/>
            <input type="hidden" name="pic" id="pic" value="{$events.pic}"/>
            <input type="hidden" name="picda" id="picda" value="{$events.content->pic}"/>
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>


<script type="text/javascript">
    $(function () {
        create_editor('textlong_f');
        {literal}
        $('#datetimepicker').datetimepicker({
            lang:'ch',
            timepicker:true,
            format:'Y-m-d H:i'
        });
        {/literal}
    });
    $('#anniu1').hide();
    $('#anniu2').hide();
    $('#anniu3').hide();

    function anniu_select(selObj){

        $('#anniu1').hide();
        $('#anniu2').hide();
        $('#anniu3').hide();
        $('#anniu'+selObj.options[selObj.selectedIndex].value).show();

    }
    {if $events.content->buts[1]->cmd=="cmd_open_web"}$('#anniu1').show();{/if}
    {if $events.content->buts[1]->cmd=="cmd_open_topic"}$('#anniu2').show();{/if}
    {if $events.content->buts[1]->cmd=="cmd_entry_game"}$('#anniu3').show();{/if}
    function submitFun() {
        document.getElementById('text').value=document.getElementById('text_f').value;
        document.getElementById('textlong').value=document.getElementById('textlong_f').value;
    }
    // 较验字段
    function checkFiled(){

        if($('#add_form input[name=["username"]').val()===''){
            alert("活动内容不能为空！");
            return false;
        }
        if($('#add_form input[name=["phone"]').val()===''){
            alert("活动标题不能为空！");
            return false;
        }
        return true;
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

    function doupload2(){
        $("#upload_form2").ajaxSubmit({
            type: 'post',
            url: "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000" ,
            success: function(data){
                // alert(data.msg);

                if(data.msg=="上传成功"){
                    document.getElementById('picda').value=data.res.file_http_path;
                    document.getElementById('picda_xiao').style.display="block";
                    document.getElementById('picda_xiao').innerHTML='<img width="400" style="margin: 5px" height="200" src="'+data.res.file_http_path+'"  class="img-rounded"/>';
                 }
            },
            error: function(XmlHttpRequest, textStatus, errorThrown){
                alert( "error");
            }
        });
    }
    {if $events.pic  neq ""}
    document.getElementById('pic_xiao').style.display="block";
    document.getElementById('pic_xiao').innerHTML='<img width="100" style="margin: 5px" height="100" src="{$events.pic}"  class="img-rounded"/>';
    {/if}
    {if $events.content->pic  neq ""}
    document.getElementById('picda_xiao').style.display="block";
    document.getElementById('picda_xiao').innerHTML='<img width="400" style="margin: 5px" height="200" src="{$events.content->pic}"  class="img-rounded"/>';
    {/if}


</script>

{include "footer.tpl"}
