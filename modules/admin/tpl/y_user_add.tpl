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
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>
{*<script src="/js/icheck.min.js"></script>*}


<form rel="ajax" id="add_form" method="post" action="/admin/YUser/add" enctype="multipart/form-data" class="form-horizontal"
      role="form" onsubmit="return checkFiled()">
    <div class="row">
        <div class="col-xs-1"></div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">性别： </label>
        <div class="col-sm-10" id="gender_radio">
            <input type="radio" name="gender" onclick="setUserTags()"  value="2" checked /> 女&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio"  name="gender" onclick="setUserTags()"  value="1"/>&nbsp;&nbsp;男
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="nickname" class="col-sm-2 control-label">昵称： </label>
        <div class="col-sm-10">
            <input id="nickname" type="text" name="nickname"  value=""
                   class="form-control" reg="" tip="昵称不能为空"/>
            <a href="javascript:getNickName();" style="height: 30px;line-height: 30px;}">换一个</a>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">年龄： </label>
        <div class="col-sm-10">
            <input id="input-title" type="number"  name="age" value="23" class="form-control"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">星座： </label>
        <div class="col-sm-10">
        <select name="star" id="form-select-cate-id">
            <option value="0">请选择星座</option>
            {foreach from=$stars item=star_name key=num}
                <option value="{$num+1}">{$star_name}</option>
            {/foreach}
        </select>
            </div>
    </div>

    <div class="form-group form-group-sm" id="city1">
        <label for="input-title" class="col-sm-2 control-label">省份： </label>
        <div class="col-sm-10">
            <select name="province" class="prov" id="provinces"></select>
            <select name="city" class="city" id="cities"></select>
        </div>
    </div>
    {literal}
        <script type="text/javascript">
            $("#city1").citySelect();
        </script>
    {/literal}
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">自我简介： </label>
        <div class="col-sm-10">
            <input id="input-title" type="text" name="aboutme" value="{$user['aboutme']}" class="form-control"/>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="input-title" class="col-sm-2 control-label">身高： </label>
        <div class="col-sm-10">
        <select name="height" id="form-select-cate-id">
            {section name=foo loop=50}
                <option  value="{$smarty.section.foo.index+155}" {if $smarty.section.foo.index==15}selected="selected" {/if}>{$smarty.section.foo.index+155}</option>
            {/section}
        </select> cm
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="job" class="col-sm-2 control-label">职业：</label>
        <div class="col-sm-10">
        <select name="job" id="form-select-cate-id">
            <option value="">请选择分类</option>
            {foreach from=$jobs item=star_name key=num}
                <option value="{$star_name}">{$star_name}</option>
            {/foreach}
        </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="tag" class="col-sm-2 control-label">标签：</label>
        <div class="col-sm-10">
            <select name="tag" id="tag">
                <option value="">请选择标签</option>
            </select>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <label for="interests" class="col-sm-2 control-label">爱好<font color="red">(最多3个)</font>：</label>
        <div class="col-sm-10" id="interests_box">
            {foreach from=$interests item=interest key=i}
                <input type="checkbox" name="interests[]" id="i_{$i}" value="{$interest}" />
                <label for="i_{$i}" style="margin-right: 10px" >{$interest}</label>
            {/foreach}
        </div>
    </div>

    {*//婚姻 1未婚 2已婚 3离异*}
    <div class="form-group form-group-sm">
        <label for="marry" class="col-sm-2 control-label">婚姻状态：</label>
        <div class="col-sm-10">
            {*"未填写", "单身", "恋爱中", "貌似恋爱", "已婚", "分居", "离异"*}
            <input name='marry' value="1" id="m_1" type="radio" checked/>
            <label for="m_1" style="margin-right: 10px" >单身</label>
            <input name='marry' value="2"  id="m_2" type="radio" />
            <label for="m_2" style="margin-right: 10px" >恋爱中</label>
            <input name='marry' value="3" id="m_3" type="radio" />
            <label for="m_3" style="margin-right: 10px" >貌似恋爱</label>
            <input name='marry' value="4" id="m_4" type="radio" />
            <label for="m_4" style="margin-right: 10px" >已婚</label>
            <input name='marry' value="5"  id="m_5" type="radio" />
            <label for="m_5" style="margin-right: 10px" >分居</label>
            <input name='marry' value="6"  id="m_6" type="radio" />
            <label for="m_6" style="margin-right: 10px" >离异</label>
        </div>
    </div>

    {*要求*}
    <div class="form-group form-group-sm">
        <label for="" class="col-sm-2 control-label">对另一半的要求：</label>
        <div class="col-sm-10">
                <input name='require' style="width: 300px;display: inline" class="form-control" id="require" />

             <select name="require_select" style="display: inline" id="require_select" onchange="setText()">
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <label for="" class="col-sm-2 control-label">对爱情的看法：</label>
        <div class="col-sm-10">
            <input name='looking' style="width: 300px;display: inline" class="form-control" id="looking" />
            <select name="looking_select"  style="display: inline" id="looking_select" onchange="setLookText()">
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
            <label for="contact" class="col-sm-2 control-label">联系方式：</label>
            <div class="col-sm-10">
                <input name='contact' type="text" class="form-control" />
                <input type="checkbox" id="private" checked value="1" name="private"/>
                <label for="private" style="margin-right: 10px" >是否保密</label>
            </div>
    </div>
    <div style="clear: both;"></div>


    <script>
        function update_conplete(img_arr){
            var picLiHtml = "";
            for(var i = 0 ; i < img_arr.length ; i++){
                picLiHtml += '<li>';
                picLiHtml += '<div class="btn-img-remove1"></div>';
                picLiHtml += '<img width="100" height="100" src="'+img_arr[i]+'" class="img-rounded"  />';
                picLiHtml += '<div class="btn-img-set-cover" name="set_div" id="m_show'+i+'" onclick="setFm(\''+img_arr[i]+'\','+i+');">设置为头像</div>';
                picLiHtml += '<div class="btn-img-set-cover" name="ok_div"  id="m_s_'+i+'"  style="display:none;color: red;" >当前头像</div>';
                picLiHtml += '</li>';
            }
            $("#picListUl").html(picLiHtml);
        }
        //设置为头像
        function setFm(url,i){
            $("#avatar").val(url);
            $('div[name="set_div"]').show();
            $('div[name="ok_div"]').hide();
            $('#m_show'+i).hide();
            $('#m_s_'+i).show();
        }

    </script>


    <div class="form-group form-group-sm form-group form-group-sm-sm">
        <label for="" class="col-sm-2 control-label">相册：</label>
        <div class="col-sm-10"s>
            {include "swf-upload.tpl"}
        </div>
    </div>

    <div class="form-group form-group-sm form-group form-group-sm-sm">
        <label for="" class="col-sm-2 control-label">设置头像：</label>
        <div class="col-sm-10"s>
            <ul id="picListUl" class="clearfix goods_pic">

            </ul>
        </div>
    </div>
    <div class="form-group form-group-sm" style="margin-top: 50px">
        <label for="" class="col-sm-2 control-label"></label>
        <div class="col-sm-10">
            <input type="hidden" name="avatar" id="avatar" value=""/>
            <input type="hidden" name="pic" id="pic" value=""/>
           <button  onclick="submitFun()" class="btn btn-primary">提交</button>
        </div>
    </div>
</form>


<script type="text/javascript" src="/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script type="text/javascript">
    var picList = [];

    function submitFun() {
        //获取上传的图片
        var newPicList = picList.concat(uploadImageArray);
        var str_pics = newPicList.join(",");
        $("#pic").val(str_pics);
    }

    $(document).ready(function () {
        setUserTags();
        doGetNickName();
        setRequire();
        setLook();
        $.fn.bootstrapSwitch.defaults.onText = '是';
        $.fn.bootstrapSwitch.defaults.offText = '否';

        var recommend_index = $('#recommend_index');
        recommend_index.bootstrapSwitch();

        var isUpdateNewestAuction_index = $('#isUpdateNewestAuction_index');
        isUpdateNewestAuction_index.bootstrapSwitch();

        var hot_index = $('#hot_index');
        hot_index.bootstrapSwitch();

        var new_index = $('#new_index');
        new_index.bootstrapSwitch();

    });
    $(document).ready(function() {

        $('#interests_box input[type=checkbox]').click(function() {
            $("input[name='interests[]']").attr('disabled', true);
            if ($("input[name='interests[]']:checked").length >= 3) {
                $("input[name='interests[]']:checked").attr('disabled', false);
            } else {
                $("input[name='interests[]']").attr('disabled', false);
            }
        });

    })
    $('input[type=radio]').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        forceParse: 0,
        showMeridian: 1
    });

    $(function () {
        create_editor('content');
        jQuery('#form-select-cate-id').find("option[value='{$user.category}']").attr('selected', true);
    });

    // 较验字段
    function checkFiled(){
        if($('#add_form input[name="gender"]:checked').val()===''){
            alert("请选择性别！");
            return false;
        }
        if($('#add_form input[name=["nickname"]').val()===''){
            alert("昵称不能为空！");
            return false;
        }
        if($('#add_form input[name=["star"]').val()===''){
            alert("星座不能为空！");
            return false;
        }

        var age = $('#add_form input[name="age"]').val();
        if (age < 16  || age >=120  ){
            alert("年龄范围为18周岁以上");
            return false;
        }
        if($('#add_form input[name="marry"]:checked').val()===''){
            alert("请选择婚姻状况！");
            return false;
        }
       /* if($('#add_form input[name=["require"]').val()===''){
            alert("请填写对另一半的要求！");
            return false;
        }*/
        if($("#avatar").val()===''){
            alert("请设置头像！");
            return false;
        }

        return true;
    }

    function setUserTags(){
        var woman_arr = eval('({$woman_tags})');
        var man_arr = eval('({$man_tags})');
        var tag_obj = $("#tag");
        var gender = $('#gender_radio input[name="gender"]:checked').val();

        var arr = new Array();
        var tags = woman_arr
        if(gender == "1") {
            tags = man_arr;
        }
        arr[arr.length] = '<option value="">请选择标签</option>';
        var len = tags.length;
        for(var i = 0; i<len;i++){
            arr[arr.length] = '<option value="'+tags[i]+'">'+tags[i]+'</option>';
        }
        tag_obj.html(arr.join(""));
        $('#add_form #looking').val("");
        getNickName();
        setRequire();
        setLook();
    }

    function setRequire(){
        var arr = ["即使经历了再多，我也依然相信真爱","只想简简单单，平平凡凡的跟爱的人相守","对爱情已经有些许麻木了，期待被拯救"];
        var len = arr.length;
        for(var i = 0; i<len;i++){
            arr[arr.length] = '<option value="'+arr[i]+'">'+arr[i]+'</option>';
        }
        $("#require_select").html(arr.join(""));
       // setText();
    }

    function setLook(){
        var woman_arr = ["成熟稳重，有自己的事业","帅气阳光，有幽默感","憨厚、踏实、勤劳、有责任心","温柔，会煮饭，会照顾人"];
        var man_arr = ["长发及腰，温柔可人型","善良孝顺，顾家型","成熟有魅力，事业型","青春活泼，无忧无虑型"];
        var tag_obj = $("#tag");
        var gender = $('#gender_radio input[name="gender"]:checked').val();
        var arr = new Array();
        var tags = woman_arr
        if(gender == "1") {
            tags = man_arr;
        }
        var len = tags.length;
        for(var i = 0; i<len;i++){
            arr[arr.length] = '<option value="'+tags[i]+'">'+tags[i]+'</option>';
        }
        $("#looking_select").html(arr.join(""));
       // setLookText();
    }

    function setText(){
        var require = $('#add_form #require_select').val();
        $('#add_form #require').val(require);
    }

    function setLookText(){
        var r = $('#add_form #looking_select').val();
        $('#add_form #looking').val(r);
    }

    var man_name = new Array();
    var woman_name =new Array();
    function getNickName(){
        var gender = $("#gender_radio input[name='gender']:checked").val();
        var names = "";
        if(gender =="1" ){
            if(!man_name || man_name.length<=3){
                doGetNickName();
                return
            }
            names = man_name[0];
            man_name.splice(0,1);
        }else{
            if(!woman_name ||woman_name.length<=3){
                doGetNickName();
                return
            }
            names = woman_name[0];
            woman_name.splice(0,1);
        }
        $('#nickname').val(names)

    }

    function doGetNickName(){
        var URL = "/admin/YUser/getNickName";
        var gender = $("#gender_radio input[name='gender']:checked").val();
        $.get(URL,function(res){
            var names = "";
            var data = eval('('+res+')');
            if(data.status=="ok"){
                    man_name = data.res.list;
                    woman_name = data.res.list_female;
            }
            getNickName();
        });
    }
</script>

{include "footer.tpl"}
