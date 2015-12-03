<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/23
 * Time: 上午10:20
 */
class Controller_Admin_UserReport extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }

    static $MARRY = Array("未填写", "单身", "恋爱中", "貌似恋爱", "已婚", "分居", "离异");


    //获取所有用户
    function listAction(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $nickname = FRequest::getString('nickname');
        $where = array(
            'ub.count'=>array('gte'=> '1'),
            'um.stat'=>'0',
            'ud.uid'=> array('gte'=> '5000000')
        );

        if($uid >0){
            $where["ud.uid"] = $uid;
        }
        if($nickname){
            $where["ud.nickname"] = array('like'=> $nickname);
        }


        $table = new FTable("user_ban","ub");
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
            "ud.aboutme",
            "ub.count"
        ))->leftJoin("user_detail","ud","ub.uid=ud.uid")
            ->leftJoin("user_main","um","ub.uid=um.uid")
            ->where($where)->page($page)->limit(10)->order(array("ub.count"=>"desc"))->select();
        foreach($users as &$user){
            $marry_id = $user["marry"];
            $user["marry"] = self::$MARRY[$marry_id];
            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],50,50);
        }
       
        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('users', $users);
        $this->assign('uid', $uid);
        $this->assign('nickname', $nickname);
        $this->display('admin/userreport_list');
    }

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
       // $this->showMessage("封闭成功",$messageType = 'success');
            //echo( "<script LANGUAGE='javascript'>zhuangtai('stat".$uid."');</script>");
            echo("ok");
       } else{
           // $this->showMessage("封闭失败",$messageType = 'success');
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
           // echo( "<script LANGUAGE='javascript'>zhuangtai_che('stat".$uid."');</script>");
            echo("ok");
        } else{
          //  $this->showMessage("撤销失败",$messageType = 'success');
        }
        return;

    }

    public function userbanAction() {
        // global $_F;
        // $_F["debug"] = true;

        $uid = FRequest::getInt('uid');

        $topic_table = new FTable("user_ban");
        $topic_table->where(array('uid' => $uid))->update(array("count"=>"0"));
        echo("ok");


    }
}