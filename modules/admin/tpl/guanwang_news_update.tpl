{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active"><a  href="/admin/GuanwangNews/list" style="margin-left:0px">秋千动态列表</a> | <a  href="/admin/GuanwangNews/add" style="margin-left:0px">秋千动态添加</a></li>
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
<form rel="ajax" id="add_form" method="post" action="/admin/GuanwangNews/update?id={$id}" class="form-horizontal"
                role="form" onsubmit="return checkFiled()">

<div class="form-horizontal">
    <div class="form-group form-group-sm" id="anniu1">
        <label for="input-title" class="col-sm-2 control-label">标题： </label>
        <div class="col-sm-10">
            <input id="title" type="text" name="title" value="{$guanwang_news.title}" class="form-control" style="width: 500px;"/>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">内容说明： </label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <textarea id="text" type="text" name="text"
                   class="form-control" reg="" tip="内容说明" style="width: 600px; height: 300px;">{$guanwang_news.text}</textarea>
        </div>

    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">时间：</label>
        <div class="col-sm-10" style="float: left; width: 320px;">
            <input style="border: 1px solid"  id="datetimepicker" name="riqi" value="{$guanwang_news.riqi}"/>
        </div>
    </div>
</div>

    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>
<script>
    $(function () {
        create_editor('text');
        {literal}
        $('#datetimepicker').datetimepicker({lang:'ch',timepicker:false,
            format:'Y-m-d'
        });
        {/literal}
    });
</script>


{include "footer.tpl"}
