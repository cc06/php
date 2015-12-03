{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">发货详细信息  <button  class="btn btn-primary" style="float:right;margin-left: 200px;" onclick ="javascript:history.go(-1);">返回</button></li>
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

<div class="row">
        <div class="col-xs-1"></div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="name" class="col-sm-2 control-label">发货时间： </label>
        <div class="col-sm-10">{$award_trans.tm}
        </div>
    </div>
<div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
    <label for="name" class="col-sm-2 control-label">物流名称： </label>
    <div class="col-sm-10">{$award_trans.name}
    </div>
</div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="num" class="col-sm-2 control-label">物流单号： </label>
        <div class="col-sm-10">{$award_trans.num}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="address_name" class="col-sm-2 control-label">收货人姓名： </label>
        <div class="col-sm-10">{$award_trans.address_name}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="address_phone" class="col-sm-2 control-label">收货人手机号： </label>
        <div class="col-sm-10">{$award_trans.address_phone}
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">收货地址： </label>
        <div class="col-sm-10">{$award_trans.address}
        </div>
    </div>


{include "footer.tpl"}
