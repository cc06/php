<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午9:30
 */
class Controller_Admin_VideoRecordYi extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }




    //获取所有有头像未审核用户
    function listAction(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $where = array();
        if ($uid) {
              $where["vr.uid"] = $uid;
          } else {
            $where["vr.status"] = array('neq'=> '0');;
        }


        $table = new FTable("video_record","vr");
        $users = $table->fields(array(
            "vr.uid",
            "vr.id",
            "vr.photos",
            "vr.status",
            "ud.video_img",
            "ud.nickname",
            "vr.tm",
            "um.reg_ip",
            "um.model",
            "um.sysver"
        )) ->leftJoin("user_detail","ud","vr.uid=ud.uid")
            ->leftJoin("user_main","um","vr.uid=um.uid")
            ->where($where)->page($page)->limit(20)->order(array("vr.id"=>"asc"))->select();
        foreach($users as &$user){

            $user["video_img"] = CommonUtil::getMoreSizeImg($user["video_img"],222,222);


        }

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('users', $users);
        $this->assign('uid', $uid);
        $this->display('admin/user_video_record_yi');
    }

}