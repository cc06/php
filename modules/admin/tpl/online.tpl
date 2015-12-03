{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">在线用户</li>
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
    <label for="input-title" class="col-sm-2 control-label">注册用户： </label>
    <div class="col-sm-10">{$man_num+$woman_num}(男:{$man_num}|女:{$woman_num})</div>
</div>
<div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
    <label for="input-title" class="col-sm-2 control-label">在线用户： </label>
    <div class="col-sm-10">{$user_online_man+$user_online_woman}(男:{$user_online_man}|女:{$user_online_woman})</div>
</div>

{include "footer.tpl"}
