{include 'header.tpl'}
<style type="text/css">
    table .header-fixed {
        position: fixed;
        /* 10 less than .navbar-fixed to prevent any overlap */

        top: 0px;
        z-index: 1020;
        border-bottom: 1px solid #d5d5d5;
        -webkit-border-radius: 0;
        -moz-border-radius: 0;
        border-radius: 0;
        -webkit-box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        -moz-box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        /* IE6-9 */

        box-shadow: inset 0 1px 0 #fff, 0 1px 5px rgba(0, 0, 0, 0.1);
        filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);
    }

    .shenhe {
        /*float: right;*/
        border: 0;
        margin-top: 5px;
        color: #428bca;
        background-color: #fff;
        border: 1px solid #ddd;
        padding: 6px 7px;
        margin-left: 1px;
        line-height: 1.42857143;
    }
    .shenhe:hover {
        color: #2a6496;
        background-color: #eee;
        border-color: #ddd;
    }
    .shenhe_dian {
        /* float: right;*/
        border: 0;
        margin-top: 5px;
        padding: 6px 7px;
        margin-left: 1px;
        line-height: 1.42857143;
        color: #fff;
        background-color: #428bca;
        border: 1px solid #ddd;
    }
    input:focus {
        outline:none;
    }
  /* .red { border: 2px solid #ff0000; }*/
</style>
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <a href="/admin/YUser/list"><h5>新用户审核</h5></a> <h5>|</h5> <h5>老用户审核</h5> <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-6" style="width: 100%">
                            <div class="dataTables_length" id="dataTable_length">
                                <form method="get" action="/admin/YUser/list2" class="form-inline" >
                                <label style="line-height: 50px;">UID： <input class="form-control input-sm" type="text" name="uid" value="{if $uid >0}{$uid}{/if}"><button type="submit" class="btn btn-primary">查找</button>
                                    <span {if $gender=="2"} class="shenhe_dian" {else} class="shenhe" {/if} onclick="window.location='/admin/YUser/list?city={$city}&gender=2'" style="  padding: 10px 20px; text-align: center; margin-left: 50px;">女</span>
                                    <span {if $gender=="1"} class="shenhe_dian" {else} class="shenhe" {/if} onclick="window.location='/admin/YUser/list2?city={$city}&gender=1'" style="padding: 10px 20px; text-align: center; margin-left: 10px;">男</span></label>
                                    <span {if $city=="长沙"} class="shenhe_dian" {else} class="shenhe" {/if} onclick="window.location='/admin/YUser/list2?gender={$gender}&city=长沙'" style="  padding: 10px 20px; text-align: center; margin-left: 50px;">长沙用户</span>
                                    <span {if $city=="非长沙"} class="shenhe_dian" {else} class="shenhe" {/if} onclick="window.location='/admin/YUser/list2?gender={$gender}&city=非长沙'" style="padding: 10px 20px; text-align: center; margin-left: 10px;">非长沙用户</span></label>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="mytable" class="table table-bordered table-striped table-fixed-header" role="grid" aria-describedby="dataTable_info">

                                <tbody>
                                {foreach from=$users item=item name=foo}
                                <tr role="row" id="item_{$item.uid}" class="{if ($smarty.foreach.foo.index+1%2)}odd{else}even{/if}" style="border-bottom: 50px solid #ddd">
                                    <td class="sorting_1">
                                       <div style=" overflow: hidden;" class="{$item.avatarcss}" >
                                           <div id="photo"style="height: 160px; float: left; width: 160px;"><div><img width="150" height="150" src="{$item.avatar}" class="img-rounded"  /></div></div>
                                           {foreach $item.photo_arr as $photo}
                                            <div id="photo{$photo.albumid}"style="height: 160px; float: left; width: 160px;"><div><img width="150" style="margin: 5px" height="150" src="{$photo.pic}"  class="img-rounded"/></div>
                                                <div style="text-align: right; width: 150px; height: 30px; margin-top: -45px; display: none;">
                                                    <button onclick="shenhe({$photo.albumid},2);" class="shenhe" >冻结</button></div></div>
                                        {/foreach}</div>
                                        <div style="text-align: center; width: 110px; height: 25px; margin-top: -25px;margin-left: 5px; ">{if $item.uid_i > 1}<a href="/admin/User/list?uid={$item.uid_d}" target="_blank"><font color="#ff000">共有{$item.uid_i}个用户使用相同头像</font></a> {/if}</div>
                                        <div class="{$item.nicknamecss}" style="line-height: 35px; font-size: 20px;">{$item.uid}、{$item.nickname}、{if $item.gender == 1}男 {else}女 {/if}、{$item.age}岁；</div>
                                        <div class="{$item.aboutmecss}"  style="line-height: 35px; font-size: 20px;"">交友寄语：{$item.aboutme}</div>
                        <div style="line-height: 35px; font-size: 20px;"">兴趣爱好：{$item.interest}</div>
                    <div style="line-height: 35px; font-size: 20px;"">行业：{$item.job}</div>
                <div style="line-height: 35px; font-size: 20px;"">工作地点：{$item.workarea}{if $item.workplaceid!=""}(带GPS){else}<font color="#ffoooo">(不带GPS)</font>{/if}</div>
            <div style="line-height: 35px; font-size: 20px;"">性感动态，涉黄动态：{$item.dynamics}条</div>

                                    </td>
                                    <td style=" width: 310px;">
                                        <div style="height: 50px;line-height: 50px;"><input type="submit" value="优质" style="width: 60px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="shenhe_z({$item.uid},9);">
                                            <input type="submit" value="非优质" style="width: 80px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="shenhe_z({$item.uid},3);">
                                            <input type="submit" value="不通过" style="width: 80px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="document.getElementById('butongguo_{$item.uid}').style.display='block';document.getElementById('fenghao_{$item.uid}').style.display='none';">
                                            <input type="submit" value="封号" style="width: 60px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="document.getElementById('butongguo_{$item.uid}').style.display='none';document.getElementById('fenghao_{$item.uid}').style.display='block';">
                                        </div>
                                        <div id="butongguo_{$item.uid}" style="display: none; margin-top: 20px;">

                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_1" name="reason_{$item.uid}_1" class="uniform" type="checkbox" value="形象照非本人头像" style="zoom:150%;"> <label  for="reason_{$item.uid}_1" >形象照非本人头像</lable></div>
                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_2" name="reason_{$item.uid}_2" class="uniform" type="checkbox" value="照片质量太差" style="zoom:150%;"> <label  for="reason_{$item.uid}_2" >照片质量太差</lable></div>
                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_3" name="reason_{$item.uid}_3" class="uniform" type="checkbox" value="人物太远看不清" style="zoom:150%;"> <label  for="reason_{$item.uid}_3" >人物太远看不清</lable></div>
                                            <div style="height: 50px;line-height: 50px;font-size: 20px;"><strong>其它原因:</strong><input type="text" id="reason_{$item.uid}_4" name="reason_{$item.uid}_4" class="form-control"></div>
                                            <div style="height: 50px;line-height: 50px;font-size: 20px;"><input type="submit" value="确定" style="width: 80px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="shenhe_z({$item.uid},-1);"></div>
                                        </div>
                                        <div id="fenghao_{$item.uid}" style="display: none; margin-top: 20px;">

                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_5" name="reason_{$item.uid}_5" class="uniform" type="checkbox" value="涉黄" style="zoom:150%;"> <label  for="reason_{$item.uid}_5" >涉黄</lable></div>
                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_6" name="reason_{$item.uid}_6" class="uniform" type="checkbox" value="广告" style="zoom:150%;"> <label  for="reason_{$item.uid}_6" >广告</lable></div>
                                            <div style="line-height: 40px;padding-left: 40px;font-size: 20px;cursor:pointer;"><input id="reason_{$item.uid}_7" name="reason_{$item.uid}_7" class="uniform" type="checkbox" value="反动" style="zoom:150%;"> <label  for="reason_{$item.uid}_7" >反动</lable></div>
                                            <div style="height: 50px;line-height: 50px;font-size: 20px;"><strong>其它原因:</strong><input type="text" id="reason_{$item.uid}_8" name="reason_{$item.uid}_8" class="form-control"></div>
                                            <div style="height: 50px;line-height: 50px;font-size: 20px;"><input type="submit" value="确定" style="width: 80px; height: 50px;font-size: 20px;" class="btn btn-primary" onclick="shenhe_z({$item.uid},-5);"></div>
                                        </div>
                                   </td>
                                </tr>
                                {/foreach}</tbody>
                            </table>
                        </div></div>
            <div class="row">
                <div class="col-sm-6">
                    {include "pager.tpl"}
                </div>

            </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">


    function shenhe(albumid,status){

        var URL = "/admin/UserVerify/verifyPhotoFirst?id="+albumid+"&status="+status;

        $.get(URL,function(data){
            // alert(data);
            document.getElementById('photo'+albumid).style.display='none';
            if(data.code=="200"){

            }
            if(data.code=="201"){
                alert("审核失败："+data.msg);
            }

        });

    }

    function shenhe_z(uid,status){
        var reason="";
        if (status=='-1') {
            if ($("#reason_" + uid + "_1").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_1").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_2").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_2").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_3").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_3").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_4").val()) {
                reason = reason + $("#reason_" + uid + "_4").val() + ",";
            }
        }

        if (status=='-5') {
            if ($("#reason_" + uid + "_5").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_5").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_6").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_6").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_7").is(':checked')) {
                reason = reason + $("#reason_" + uid + "_7").attr('value') + ",";
            }
            if ($("#reason_" + uid + "_8").val()) {
                reason = reason + $("#reason_" + uid + "_8").val() + ",";
            }
        }
        document.getElementById('item_'+uid).style.display='none';
         alert(reason);

            var URL = "/admin/UserVerify/verifyUserFirst?uid=" + uid + "&status=" + status + "&reason=" + reason;

            $.get(URL, function (data) {
                //alert(data.code);
                if (data.code == "200") {
                    // alert("审核成功");
                    //window.location.href = "/admin/YUser/list?shen=1";
                }
                if(data.code=="201"){
                    alert("审核失败："+data.msg);
                }

            });

    }


</script>


{include 'footer.tpl'}
