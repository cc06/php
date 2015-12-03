{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">修改邮寄地址</li>
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

<form rel="ajax" id="add_form" method="post" action="/admin/YUserAddress/update?uid={$uid}&addrid={$addrid}" class="form-horizontal"
      role="form" onsubmit="return checkFiled()">
    <div class="row">
        <div class="col-xs-1"></div>
    </div>

    <div class="form-group form-group-sm">
        <label for="username" class="col-sm-2 control-label">联系人： </label>
        <div class="col-sm-10">
            <input id="username" type="text" name="username"  value="{$useradd.username}"
                   class="form-control" reg="" tip="联系人不能为空"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="phone" class="col-sm-2 control-label">联系电话： </label>
        <div class="col-sm-10">
            <input id="phone" type="text" name="phone"  value="{$useradd.phone}"
                   class="form-control" reg="" tip="联系电话不能为空"/>
        </div>
    </div>

    <div class="form-group form-group-sm" id="city1">
        <label for="input-title" class="col-sm-2 control-label">省份： </label>
        <div class="col-sm-10">
            <select name="province" class="prov" id="provinces"></select>
            <select name="city" class="city" id="cities"></select>
        </div>
    </div>
    <script type="text/javascript">
        var pro = "{$useradd.province}";
        var city = "{$useradd.city}";
        {literal}
        $("#city1").citySelect({
            prov:pro, //省份
            city:city
        });
        {/literal}
    </script>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">详细地址： </label>
        <div class="col-sm-10">
            <input id="address" type="text" name="address" value="{$useradd.address}" class="form-control"/>
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

        if($('#add_form input[name=["username"]').val()===''){
            alert("联系人不能为空！");
            return false;
        }
        if($('#add_form input[name=["phone"]').val()===''){
            alert("联系电话不能为空！");
            return false;
        }
        return true;
    }

</script>

{include "footer.tpl"}
