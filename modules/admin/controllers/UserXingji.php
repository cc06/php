<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午9:30
 */
class Controller_Admin_UserXingji extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }





    function listAction()
    {
        //global $_F;
        //$_F["debug"] = true;
        $page = max(1, FRequest::getInt('page'));

        $table = new FTable("user_star_level", "usl");
        $usls = $table->fields(array("usl.uid" ))->where(array('uid'=>array('gte'=>5000000))) ->select();

        $user_ids1=array();
        foreach ($usls as $usl) {
            array_push($user_ids1, $usl['uid']);
        }
        $table = new FTable("user_ban", "ub");
        $user_bans = $table->fields(array("ub.uid" ))->where(array('uid'=>array('gte'=>5000000))) ->select();

        $user_ids2=array();
        foreach ($user_bans as $user_ban) {
            array_push($user_ids2, $user_ban['uid']);
        }
        //$user_ids1=array(1,2,3,4,5);
       // $user_ids2=array(6,7,3,4,8);
        $user_ids=array_merge($user_ids1,$user_ids2);
        $user_ids=array_unique($user_ids);

        $user_ids=implode(",",$user_ids);
        $guolv_xingji_yonghu="";
        if ($user_ids){
            //$guolv_xingji_yonghu=" and mm.from not in (".$user_ids.") ";
            $guolv_xingji_yonghu=" and mm.uid not in (".$user_ids.") ";
        }

        $table = new FTable("honesty_record", "hr");
        $users = $table->fields(array("hr.uid" ))->where(array("item" => 2))->select();
        $user_ins1=array();
        foreach ($users as $user) {
            array_push($user_ins1, $user['uid']);
        }
        $users = $table->fields(array("hr.uid" ))->where(array("item" => 3))->select();
        $user_ins2=array();
        foreach ($users as $user) {
            array_push($user_ins2, $user['uid']);
        }
        $user_ins=array_intersect($user_ins1,$user_ins2);
        $user_ins=implode(",",$user_ins);
        if ($user_ins){
            $guolv_xingji_yonghu=$guolv_xingji_yonghu." and mm.uid  in (".$user_ins.") ";
        }

//echo($guolv_xingji_yonghu);

        $where = array();
        $users = array();
        $datetime_qitian = date("Y-m-d ", time() - 86400 * 7);
       // $query_str = " mm.from>'5000000' and ( mm.tm>='" . $datetime_qitian . " 00:00:00' ) and type in ('text','pic','voice') ".$guolv_xingji_yonghu."";
        //$query_str = " 1=1";
        $query_str = " 1=1  ".$guolv_xingji_yonghu."";

        $where["str"] = $query_str;
        $where["um.stat"] = 0;
        $where["ud.avatarlevel"] = array('gte' => '3');

        $table = new FTable("user_message_7", "mm");
        $user_messages = $table->fields(array(
            "um.uid",
            "um.stat",
            "um.gender",
            "um.reg_time",
            "ud.nickname",
            "ud.avatar",
            "ud.province",
            "ud.city",
            "ud.age",
            "ud.height",
            "ud.marry",
            "ud.aboutme",
            "um.phonestat",
            "um.certify_video",
            "um.certify_idcard"
        ))->leftJoin("user_main","um","um.uid=mm.uid")
            ->leftJoin("user_detail","ud","ud.uid=mm.uid")
            ->where($where)->page($page)->limit(50)->groupBy("mm.uid")->select();

        $table = new FTable("user_message_7", "mm");
        $user_messages2 = $table->fields(array(
            "um.uid"
        ))->leftJoin("user_main","um","um.uid=mm.uid")
            ->leftJoin("user_detail","ud","ud.uid=mm.uid")
            ->where($where)->groupBy("mm.uid")->select();
        $total = count($user_messages2);
        foreach ($user_messages as &$user_message) {

            $user_message['avatar'] = CommonUtil::getMoreSizeImg($user_message['avatar'], 222, 222);


            $photo_table = new FTable("user_photo_album");
            $photos = $photo_table->fields(array("pic"))->where(array("uid" => $user_message['uid']))->limit(3)->select();
            $photo_arr = array();
            foreach ($photos as $photo) {
                array_push($photo_arr, CommonUtil::getMoreSizeImg($photo["pic"], 222, 222));
            }
            $user_message['photo_arr'] = $photo_arr;

        }
//echo(json_encode($user_messages));
        //$users=$user_messages;

        $page_info =  FPager::getPagerInfo($total, $page, 50);
        $this->assign('page_info', $page_info);
        $this->assign('users', $user_messages);

        $this->display('admin/user_xingji_list');
    }


    public function shenheAction() {
        // global $_F;
        // $_F["debug"] = true;

        $size = FRequest::getPostInt('size');

        $list = FRequest::getPostString('avatarlevel'.$size);

        $query = explode(",",$list);
        $uid =$query[0];
        $gender =$query[1];
        $status =$query[2];

        $data2 = array(
            'uid' => $uid,
            'gender' => $gender,
            'level' => $status,
            'changes' => 1
        );
        $user_star_level_table = new FTable("user_star_level");
        $result=$user_star_level_table->insert($data2);

        if($result){
            //$this->success('修改成功！');
        }else{
            //$this->error("修改失败");
        }

        return;

    }
    function levelAction()
    {
        $page = max(1, FRequest::getInt('page'));
        $uid = FRequest::getInt('uid');
        $where=array();
        if ($uid) {
            $where["usl.uid"]= $uid;
        }
        $table = new FTable("user_star_level","usl");
        $user_messages = $table->fields(array(
            "usl.uid",
            "usl.level",
            "um.gender",
            "ud.nickname",
            "ud.avatar"
        )) ->leftJoin("user_main","um","um.uid=usl.uid")
            ->leftJoin("user_detail","ud","ud.uid=usl.uid")
            ->where($where)->page($page)->limit(20)->order(array("usl.tm"=>"desc"))->select();
        foreach ($user_messages as &$user_message) {
            $user_message['avatar'] = CommonUtil::getMoreSizeImg($user_message['avatar'], 222, 222);


            $photo_table = new FTable("user_photo_album");
            $photos = $photo_table->fields(array("pic"))->where(array("uid" => $user_message['uid']))->limit(3)->select();
            $photo_arr = array();
            foreach ($photos as $photo) {
                array_push($photo_arr, CommonUtil::getMoreSizeImg($photo["pic"], 222, 222));
            }
            $user_message['photo_arr'] = $photo_arr;
        }
        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('users', $user_messages);

        $this->display('admin/user_xingji_level_list');
    }

}