{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">发货  <button  class="btn btn-primary" style="float:right; margin-left: 200px;" onclick ="javascript:history.go(-1);">返回</button></li>
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

<form rel="ajax" id="add_form" method="post" action="/admin/User/awardfahuo?id={$id}&log_id={$log_id}&status={$status}&type={$type}" class="form-horizontal"
      role="form">
    <div class="row">
        <div class="col-xs-1"></div>
    </div>
    <div class="form-group form-group-sm">
        <label for="name" class="col-sm-2 control-label">物流名称： </label>
        <div class="col-sm-10">
            <input id="name" type="text" name="name"  value="{$award_trans.name}"
                   class="form-control" reg="" tip="物流名称"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="num" class="col-sm-2 control-label">物流单号： </label>
        <div class="col-sm-10">
            <input id="num" type="text" name="num"  value="{$award_trans.num}"
                   class="form-control" reg="" tip="物流单号"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="address_name" class="col-sm-2 control-label">收货人姓名： </label>
        <div class="col-sm-10">
            <input id="address_name" type="text" name="address_name"  value="{$award_trans.address_name}"
                   class="form-control" reg="" tip="收货人姓名"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="address_phone" class="col-sm-2 control-label">收货人手机号： </label>
        <div class="col-sm-10">
            <input id="address_phone" type="text" name="address_phone"  value="{$award_trans.address_phone}"
                   class="form-control" reg="" tip="收货人手机号"/>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">收货地址： </label>
        <div class="col-sm-10">
            <input id="address" type="text" name="address" value="{$award_trans.address}" class="form-control"/>
        </div>
    </div>

    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
           <button  class="btn btn-primary">提交</button>
        </div>
    </div>
</form>

{include "footer.tpl"}
