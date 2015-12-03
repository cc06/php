<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/23
 * Time: 上午10:20
 */
class Controller_Admin_User extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){
        $this->display('admin/user_list');
    }


    //获取所有用户
    function listAction(){
        global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));
        $sayhello = FRequest::getInt('sayhello');
        $uid = FRequest::getString('uid');
        $nickname = FRequest::getString('nickname');
        $where = array(
           // 'um.stat'=>'0'
        );

        if($uid){
            $where["ud.uid"] = array('in'=> $uid);

        }
        if($nickname){
            $where["ud.nickname"] = array('like'=> $nickname);
        }


        if ($sayhello) {
            $fields = array(
                "sm.from",
                "count(*) as count"
            );

            $table2 = new FTable("sayhello_msg","sm");
            $total_rs = $table2->fields($fields)->groupBy("sm.from")->having("count>".$sayhello."")->select();

            $sayhello_user="";
            foreach($total_rs as $total){
                if ($sayhello_user) {
                    $sayhello_user=$sayhello_user.",".$total['from'];
                } else {
                    $sayhello_user=$total['from'];
                }
              }

if ($sayhello_user) {
    $where["str"] = " ud.uid in (".$sayhello_user.") ";
}else {
    $where["str"] = " ud.uid in (0) ";
}


        }

        $table = new FTable("user_detail","ud");
        $users = $table->fields(array(
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
            "ud.aboutme"
        ))->leftJoin("user_main","um","ud.uid=um.uid")
            ->where($where)->page($page)->limit(10)->order(array("ud.uid"=>"desc"))->select();

          foreach($users as &$user){

            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],50,50);
           }


        $page_info = $table->getPagerInfo();
      //  if ($uid >0||$nickname){
            $this->assign('page_info', $page_info);
            $this->assign('users', $users);
      //  }
        $this->assign('sayhello', $sayhello);
        $this->assign('uid', $uid);
        $this->assign('nickname', $nickname);
        $this->display('admin/user_list');
    }
    //获取资料完善度>80%  ，头像推荐等级>0   的2天内注册的用户
    function youxiuAction(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $nickname = FRequest::getString('nickname');
        $where = array(
            "ud.uid" => array('gte'=> '5000000'),
            //"ud.infocomplete" => array('gte'=> '14'),
            "ud.avatarlevel" => 9,
            "um.stat" => 0
        );
        $datetime_riqi_qiantian=date("Y-m-d", time()-172800);
        $query_str= " um.reg_time >= '".$datetime_riqi_qiantian." 00:00:00'  ";
        $where["str"] = $query_str;


        $table = new FTable("user_detail","ud");
        $users = $table->fields(array(
            "um.uid",
            "um.stat",
            "um.gender",
            "um.reg_time",
            "ud.nickname",
            "ud.avatar",
            "ud.province",
            "ud.city",
            "ud.birthday",
            "ud.height",
            "ud.marry",
            "ud.aboutme"
        ))->leftJoin("user_main","um","ud.uid=um.uid")
            ->where($where)->page($page)->limit(100)->order(array("ud.uid"=>"desc"))->select();
        foreach($users as &$user){
            $user["age"] =CommonUtil::birthdayToAge($user["birthday"]);
            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],50,50);
        }


        $page_info = $table->getPagerInfo();
          $this->assign('page_info', $page_info);
            $this->assign('users', $users);

        $this->display('admin/user_list_youxiu');
    }

  /*  public function shenheAction() {
       // global $_F;
       // $_F["debug"] = true;

        $uid = FRequest::getPostInt('uid');


        $params = array("uid"=>$uid);
        $params =json_encode($params);
        $params=Service_Common::postfeng_user($params);

        $params=json_decode($params);

        if($params->status=="ok"){
        $this->showMessage("封闭成功",$messageType = 'success');
            echo( "<script LANGUAGE='javascript'>zhuangtai('stat".$uid."');</script>");
       } else{
            $this->showMessage("封闭失败",$messageType = 'success');
        }
        return;

    }*/
    public function shenheAction() {
        // global $_F;
        // $_F["debug"] = true;

        $uid = FRequest::getInt('uid');


        $params = array("uid"=>$uid);
        $params =json_encode($params);
        $url =  FConfig::get('global.service_mumu_url')."/user/BanUser";

        $params=Service_Common::post($url,$params);

        $params=json_decode($params);

        if($params->status=="ok"){
            //$this->showMessage("封闭成功",$messageType = 'success');
            //echo( "<script LANGUAGE='javascript'>zhuangtai('stat".$uid."');</script>");
            echo("ok");
        } else{
            //$this->showMessage("封闭失败",$messageType = 'success');
        }
        return;

    }
    public function shenhe_cheAction() {
        // global $_F;
        // $_F["debug"] = true;

        $uid = FRequest::getInt('uid');


        $params = array("uid"=>$uid);
        $params =json_encode($params);
        $url =  FConfig::get('global.service_mumu_url')."/user/UnBanUser";

        $params=Service_Common::post($url,$params);

        $params=json_decode($params);

        if($params->status=="ok"){
           // $this->showMessage("撤销成功",$messageType = 'success');
          //  echo( "<script LANGUAGE='javascript'>zhuangtai_che('stat".$uid."');</script>");
            echo("ok");
        } else{
          //  $this->showMessage("撤销失败",$messageType = 'success');
        }
        return;

    }
    /**
     * 秋千帐号详细
     */
    function  xiangxiAction(){
        global $_F;

        $uid = FRequest::getInt("uid");
        $user_detail_table = new FTable("user_main","um");
        $user = $user_detail_table->leftJoin("user_detail","ud","um.uid=ud.uid")
            ->where(array("um.uid"=>$uid))->select();
        $this->assign("user",$user[0]);
        $interests = explode(",",$user[0]["interest"]);

        $photo_table = new FTable("user_photo_album");
        $photos = $photo_table->fields(array("pic"))->where(array("uid"=>$uid))->select();
        $photo_arr = array();
        foreach($photos as $photo){
            array_push($photo_arr,$photo["pic"]);
        }

        $this->assign("photos",$photo_arr);

        $this->assign("old_interests",$interests);


        $this->display('admin/user_xiangxi');
    }

//获取所有用户领奖记录
    function awardAction(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $status =  FRequest::getInt('status');
        $type =  FRequest::getInt('type');
        $where = array(
            // 'um.stat'=>'0'
        );

        if($status >=0){
            $where["ar.status"] = $status;
        }
       if($type >=0){
            $where["ac.type"] = $type;
        } else {
            $where["ac.type"] = array('in'=> "2,3,4");
        }


        $table = new FTable("award_record","ar");
        $award_record = $table->fields(array(
            "ud.uid",
            "ud.nickname",
            "ar.id",
            "ar.tm",
            "ar.oper_tm",
            "ar.status",
            "ar.charge_phone",
            "ar.log_id",
            "ac.name",
            "ac.type"
        ))->leftJoin("user_detail","ud","ud.uid=ar.uid")
            ->leftJoin("award_config","ac","ac.id=ar.award_id")
            ->where($where)->page($page)->limit(10)->order(array("ar.id"=>"desc"))->select();



        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('award_record', $award_record);
        $this->assign('status', $status);
        $this->assign('type', $type);
        $this->display('admin/user_list_award');
    }
    public function awardchongzhiAction() {
        // global $_F;
        // $_F["debug"] = true;

        $id = FRequest::getInt('id');
        $status =  FRequest::getInt('status');
        $type =  FRequest::getInt('type');

        $data2 = array(
            'status' => 3,
            'oper_tm' => date('Y-m-d H:i:s')
        );
        $user_award_record = new FTable("award_record");
        $user_award_record->where(array('id' => $id))->update($data2);

         $this->showMessage("充值成功",$messageType = 'success',"/User/award?status=".$status."&type=".$type."");

        return;

    }
    public function awardfahuoAction() {
        // global $_F;
        // $_F["debug"] = true;
        $id = FRequest::getInt('id');
        $log_id = FRequest::getInt('log_id');
        $status =  FRequest::getInt('status');
        $type =  FRequest::getInt('type');

        if ($this->isPost()) {

            $name = FRequest::getPostString('name');
            $num = FRequest::getPostString('num');
            $address = FRequest::getPostString('address');
            $address_phone = FRequest::getPostString('address_phone');
            $address_name = FRequest::getPostString('address_name');

            if (!$name) {
                $this->showMessage("物流公司不能为空" ,error);
                return;
            }
            if (!$num) {
                $this->showMessage("物流单号不能为空" ,error);
                return;
            }
            $data2 = array(
                'name' => $name,
                'num' => $num,
                'address' => $address,
                'tm' => date('Y-m-d H:i:s'),
                'address_phone' => $address_phone,
                'address_name' => $address_name
            );
            $user_detail_table = new FTable("award_trans");
            $user_detail_table->where(array('id' => $log_id))->update($data2);

            $data2 = array(
                'status' => 3,
                'oper_tm' => date('Y-m-d H:i:s')
            );
            $user_award_record = new FTable("award_record");
            $user_award_record->where(array('id' => $id))->update($data2);

            $this->showMessage("发货成功" ,$messageType = 'success' ,"/User/award?status=".$status."&type=".$type."");
            return;
        }

        $award_trans_table = new FTable("award_trans");
        $award_trans = $award_trans_table->where(array('id' => $log_id))->find();

        $this->assign("award_trans",$award_trans);
        $this->assign("id",$id);
        $this->assign("log_id",$log_id);
        $this->assign("status",$status);
        $this->assign("type",$type);
        $this->display('admin/user_award_fahuo');

    }
    public function awardyifahuoAction() {
        // global $_F;
        // $_F["debug"] = true;

        $log_id = FRequest::getInt('log_id');
        $status =  FRequest::getInt('status');
        $type =  FRequest::getInt('type');

        $award_trans_table = new FTable("award_trans");
        $award_trans = $award_trans_table->where(array('id' => $log_id))->find();

        $this->assign("award_trans",$award_trans);
        $this->assign("log_id",$log_id);
        $this->assign("status",$status);
        $this->assign("type",$type);
        $this->display('admin/user_award_yifahuo');

    }
}