<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/23
 * Time: 上午10:20
 */
class Controller_Admin_UserMessageJt extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    //获取所有用户
    function listAction(){
        //global $_F;
       // $_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $touid = FRequest::getInt('touid');
        $query_str= "  ( mm.type='pic' or mm.type='text' ) ";
        $where = array();

        if($uid >0){
           // $where["mm.from"] = $uid;
            $query_str=$query_str." and ((mm.from='$uid' and mm.to='$touid') or (mm.from='$touid' and mm.to='$uid')) ";
            $where["str"] =  $query_str;
        }

        $table = new FTable("message","mm",FDB::$DB_MUMU_MESSAGE);
        $user_messages = $table->fields(array(
            "mm.tm",
            "mm.from",
            "mm.to",
            "mm.content"
           ))
            ->where($where)->page($page)->limit(100)->order(array("mm.tm"=>"asc"))->select();

        foreach($user_messages as &$user_message){

           // $useradd_table = new FTable("user_address");
           // $useradd = $useradd_table->where(array('addrid' => $addrid))->find();

            $user_message["content"] = json_decode($user_message["content"]);


        }


$page_info = $table->getPagerInfo();
        if ($uid >0){
            $this->assign('page_info', $page_info);
            $this->assign('user_messages', $user_messages);
        }
        $this->assign('uid', $uid);
        $this->display('admin/usermessage_list_jt');
    }



}