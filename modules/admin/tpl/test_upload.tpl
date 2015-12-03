{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">添加秋千帐号</li>
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
<script charset="utf-8" src="/js/jquery.form.js" type="text/javascript"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>
{*<script src="/js/icheck.min.js"></script>*}
{*<form action="/admin/upload/save" method="post" enctype="multipart/form-data">*}
<form method="post" action="/admin/upload/save"  id="out_form">
    <input value="test123" name="hh"/>
<form   method="post" enctype="multipart/form-data" id="upload_form">
    <input type="file" name="file_name"><img src="" id="show_img">

    <input type="button" name="" value="上传" id="upload_but" onclick="doupload()" />
</form>
    <input value="test1232" name="hhh"/>
    <input type="button" name="" value="上传" id="upload_but2" onclick="doupload2()" />
</form>
<script>
    function doupload(){
       $("#upload_form").ajaxSubmit({
           type: 'post',
           url: "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000" ,
           success: function(data){
               alert(data);
           },
           error: function(XmlHttpRequest, textStatus, errorThrown){
               alert( "error");
           }
       });
    }
    function doupload2(){
        $("#out_form").submit();
    }

</script>

{include "footer.tpl"}
