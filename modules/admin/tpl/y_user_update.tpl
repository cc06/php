{include "header.tpl"}

<script type="text/javascript" src="/admin/js/jquery.form.js"></script>
<style type="text/css">
.form-group {
    line-height: 40px;
    border: 1px solid #EFEFEF;
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
    .red { border: 2px solid #ff0000; }
</style>
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>基本信息</h5>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="dataTables_length" id="dataTable_length">
                                <div class="form-group {$nickname}" id="nickname">
                                    <label class="control-label col-lg-4" for="dpYears">昵称（uid）：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['nickname']}（{$user['uid']}）
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">性别：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user.gender==2}女{else}男{/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">年龄：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['age']>0}{$user['age']}岁{/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">星座：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {foreach from=$stars item=star_name key=num}
                                                {if $user.star==($num+1)}{$star_name}{/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">身高：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['height']>0}{$user['height']}cm{/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>重点审核区</h5>
            </header>
            <div id="avatar" class="body {$avatar}" >
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="dataTables_length" id="dataTable_length">

                                <div class="form-group" style="border: 0px solid #ddd;">
                                    <label class="control-label col-lg-4" for="dpYears">头像：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            <div id="photo{$photo.albumid}" style="height: 150px; float: left; width: 130px;"><div><img width="100" height="100" src="{$user.avatar}" class="img-rounded"  /></div>
                                                <div style="text-align: center; width: 110px; height: 30px;">{if $user.uid_i > 1}<a href="/admin/User/list?uid={$user.uid_d}" target="_blank">共有{$user.uid_i}个用户使用</a> {/if}</div></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group" style="border: 0px solid #ddd;">
                                    <label class="control-label col-lg-4" for="dpYears">现有相册：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {foreach $photos as $photo}
                                            <div id="photo{$photo.albumid}" style="height: 150px; float: left; width: 130px;"><div><img width="100" style="margin: 5px" height="100" src="{$photo.pic}"  class="img-rounded"/></div>
                                            <div style="text-align: center; width: 110px; height: 30px;"><button onclick="shenhe({$photo.albumid},1);" class="shenhe" >正常</button>
                                                <button onclick="shenhe({$photo.albumid},2);" class="shenhe" >冻结</button></div></div>
                                            {/foreach}

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">

                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">工作地点：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                           {$user.workarea}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">工作单位：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user.workunit}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">毕业院校：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user.school}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>交友信息</h5>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">

                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">年龄：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['minage']==0}不限{/if}{if $user['minage']>0}{$user['minage']}岁{/if} -- {if $user['maxage']==0}不限{/if}{if $user['maxage']>0}{$user['maxage']}岁{/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">城市：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['requireprovince']}  {$user['requirecity']}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">身高：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['minheight']==0}不限{/if}{if $user['minheight']>0}{$user['minheight']}cm{/if} -- {if $user['maxheight']==0}不限{/if}{if $user['maxheight']>0}{$user['maxheight']}cm{/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">学历：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['minedu']==0}不限{/if}
                                            {if $user['minedu']==1}高中及以上{/if}
                                            {if $user['minedu']==2}专科及以上{/if}
                                            {if $user['minedu']==3}本科及以上{/if}
                                            {if $user['minedu']==4}硕士及以上{/if}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">要求是否硬性：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {if $user['hardrequire']==0}非硬性{/if}
                                            {if $user['hardrequire']==1}是硬性{/if}
                                            {if $user['hardrequire']==2}不全是硬性{/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">

                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">感兴趣类型：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['needtag']}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group {$aboutme}" id="aboutme">
                                    <label class="control-label col-lg-4" for="dpYears">交友寄语：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['aboutme']}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>选择信息</h5>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">

                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">行业：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user.job}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">家乡：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user.province} {$user.city}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">兴趣爱好：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['interest']}
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4" for="dpYears">标签：</label>
                                    <div class="col-lg-3">
                                        <div class="input-group input-append  date">
                                            {$user['tag']}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12 ui-sortable">
        <div class="box ui-sortable-handle" style="position: relative;">
            <header>
                <h5>审核结论</h5>
            </header>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">
                                <div class="form-group">
                                    <label class="control-label col-lg-4">不通过原因</label>
                                     <div class="col-lg-8">
                                            <input id="reason1" name="reason1" class="uniform" type="checkbox" value="形象照非本人头像"> 形象照非本人头像
                                            <input id="reason2" name="reason2" class="uniform" type="checkbox" value="广告"> 广告
                                            <input id="reason3" name="reason3" class="uniform" type="checkbox" value="黄图"> 黄图
                                            <input id="reason4" name="reason4" class="uniform" type="checkbox" value="性别不符" > 性别不符

                                     </div>

                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">其它原因</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="reason5" name="reason5" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div id="collapse4" class="body">
                <div id="dataTable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="dataTables_length" id="dataTable_length">
                                <div class="form-actions no-margin-bottom">
                                    <input type="submit" value="推荐" class="btn btn-primary" onclick="shenhe_z({$user['uid']},9);">
                                    <input type="submit" value="不推荐" class="btn btn-primary" onclick="shenhe_z({$user['uid']},3);">
                                    <input type="submit" value="封号" class="btn btn-primary" onclick="shenhe_z({$user['uid']},-5);">
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
var photos_num={$photos_num};

    function shenhe(albumid,status){

        var URL = "/admin/UserVerify/verifyPhotoFirst?id="+albumid+"&status="+status;

        $.get(URL,function(data){
          // alert(data);
            if(data.code=="200"){
                document.getElementById('photo'+albumid).style.display='none';
                photos_num=photos_num-1;
            }
            if(data.code=="201"){
                alert("审核失败："+data.msg);
            }

        });

    }

    function shenhe_z(uid,status){
        var reason="";
        if ($("#reason1").is(':checked')) { reason=reason+$("#reason1").attr('value')+","; }
        if ($("#reason2").is(':checked')) { reason=reason+$("#reason2").attr('value')+","; }
        if ($("#reason3").is(':checked')) { reason=reason+$("#reason3").attr('value')+","; }
        if ($("#reason4").is(':checked')) { reason=reason+$("#reason4").attr('value')+","; }
        if ($("#reason5").val()) { reason=reason+$("#reason5").val()+","; }


       // alert(reason);
  if (photos_num==0) {
      var URL = "/admin/UserVerify/verifyUserFirst?uid=" + uid + "&status=" + status + "&reason=" + reason;

      $.get(URL, function (data) {
          //alert(data.code);
          if (data.code == "200") {
             // alert("审核成功");
              window.location.href = "/admin/YUser/list?shen=1";
          }
          if(data.code=="201"){
              alert("审核失败："+data.msg);
          }

      });
  } else {
      alert("还有相册待审核");
  }
    }


</script>


{include "footer.tpl"}
