{include "header.tpl"}

<ol class="breadcrumb">
    <li class="active">用户基本信息</li>
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
    <label for="input-title" class="col-sm-2 control-label">注册时间： </label>
    <div class="col-sm-10">{$user.reg_time}</div>
</div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">性别： </label>
        <div class="col-sm-10" id="gender_radio">{if $user.gender==2}女{/if}{if $user.gender==1}男{/if}
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">昵称： </label>
        <div class="col-sm-10">{$user['nickname']}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">年龄： </label>
        <div class="col-sm-10">{$user['age']}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">星座： </label>
        <div class="col-sm-10">
         {foreach from=$stars item=star_name key=num}
             {if $user.star==($num+1)} {$star_name} {/if}
            {/foreach}
            </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">省份： </label>
        <div class="col-sm-10">{$user.province}
        </div>
    </div>
<div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
    <label for="input-title" class="col-sm-2 control-label">市： </label>
    <div class="col-sm-10">{$user.city}
    </div>
</div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">自我简介： </label>
        <div class="col-sm-10">{$user['aboutme']}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="input-title" class="col-sm-2 control-label">身高： </label>
        <div class="col-sm-10">{$user["height"]} cm
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="job" class="col-sm-2 control-label">职业：</label>
        <div class="col-sm-10">{$user.job}
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="tag" class="col-sm-2 control-label">标签：</label>
        <div class="col-sm-10">{$user.tag}
        </div>
    </div>
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="interests" class="col-sm-2 control-label">爱好<font color="red">(最多3个)</font>：</label>
        <div class="col-sm-10" id="interests_box">{$user.interest}
        </div>
    </div>

    {*//婚姻 1未婚 2已婚 3离异*}
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="marry" class="col-sm-2 control-label">婚姻状态：</label>
        <div class="col-sm-10">
            {if $user.marry == 1}单身{/if}
            {if $user.marry == 2}恋爱中{/if}
            {if $user.marry == 3}貌似恋爱{/if}
            {if $user.marry == 4}已婚{/if}
            {if $user.marry == 5}分居{/if}
            {if $user.marry == 6}离异{/if}
        </div>
    </div>

    {*要求*}
    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="" class="col-sm-2 control-label">对另一半的要求：</label>
        <div class="col-sm-10">
                {$user.require}
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
        <label for="" class="col-sm-2 control-label">对爱情的看法：</label>
        <div class="col-sm-10">
            {$user.looking}
        </div>
    </div>

    <div class="form-group form-group-sm" style="height: 30px; margin-bottom: 5px;">
            <label for="contact" class="col-sm-2 control-label">联系方式：</label>
            <div class="col-sm-10">
                {$user.contact}
                {if $user.private == 1}保密{/if}
            </div>
    </div>
    <div style="clear: both;"></div>

    <div class="form-group form-group-sm form-group form-group-sm-sm">
        <label for="" class="col-sm-2 control-label">头像：</label>
        <div class="col-sm-10">
            <img width="100" height="100" src="{$user.avatar}" class="img-rounded"  />
        </div>
    </div>

<div class="form-group form-group-sm form-group form-group-sm-sm">
    <label for="" class="col-sm-2 control-label">相册：</label>
    <div class="col-sm-10">
        {foreach $photos as $photo}
            <img width="100" style="margin: 5px" height="100" src="{$photo}"  class="img-rounded"/>
        {/foreach}
    </div>
</div>

<script type="text/javascript" src="/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>


{include "footer.tpl"}
