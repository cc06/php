{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">修改栏目</li>
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

<link rel="stylesheet" href="/css/skins/square/blue.css"/>
{*<script src="/js/icheck.min.js"></script>*}

<form rel="ajax" id="add_form" method="post" action="/admin/TopMenus/update?topid={$topid}" class="form-horizontal"
      role="form" onsubmit="return checkFiled()">
    <div class="row">
        <div class="col-xs-1"></div>
    </div>

    <div class="form-group form-group-sm">
        <label for="name" class="col-sm-2 control-label">名称： </label>
        <div class="col-sm-10">
            <input id="name" type="text" name="name"  value="{$top_menu.name}"
                   class="form-control" reg="" tip="名称不能为空"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="menu" class="col-sm-2 control-label">标识： </label>
        <div class="col-sm-10">
            <input id="menu" type="text" name="menu"  value="{$top_menu.menu}"
                   class="form-control" reg="" tip="标识不能为空"/>
        </div>
    </div>

    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>


<script type="text/javascript">

    // 较验字段
    function checkFiled(){

        if($('#add_form input[name=["name"]').val()===''){
            alert("名称不能为空！");
            return false;
        }
        if($('#add_form input[name=["menu"]').val()===''){
            alert("标识不能为空！");
            return false;
        }
        return true;
    }

</script>

{include "footer.tpl"}
