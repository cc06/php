<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/23
 * Time: 上午10:20
 */
class Controller_Admin_UserMessage extends  Controller_Admin_Abstract{
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
        $query_str= "  ( mm.type='pic' or mm.type='text' ) ";
        $where = array();

        if($uid >0){
            $where["mm.from"] = $uid;
            //$query_str=$query_str." and (mm.from='$uid' or mm.to='$uid') and mm.from<>1 and mm.to<>1 ";
            $where["str"] =  $query_str;

            $user_detail_table = new FTable("user_detail");
            $user_detail = $user_detail_table->where(array('uid' => $uid))->find();
            $user_avatar = CommonUtil::getMoreSizeImg($user_detail["avatar"],100,100);

            $table = new FTable("message","mm",FDB::$DB_MUMU_MESSAGE);
            $user_messages = $table->fields(array(
                "mm.tm",
                "mm.from",
                "mm.to",
                "mm.content"
            ))
                ->where($where)->groupBy("mm.to")->page($page)->limit(20)->order(array("mm.tm"=>"desc"))->select();
            $user_messages1 = $table->fields(array(
                "mm.tm",
                "mm.from",
                "mm.to",
                "mm.content"
            ))
                ->where($where)->groupBy("mm.to")->order(array("mm.tm"=>"desc"))->select();
            $total = count($user_messages1);
            foreach($user_messages as &$user_message){

                $user_detail_table = new FTable("user_detail");
                $user_detail = $user_detail_table->where(array('uid' => $user_message["to"]))->find();
                $user_message["to_avatar"] = CommonUtil::getMoreSizeImg($user_detail["avatar"],100,100);
                $user_message["content"] = json_decode($user_message["content"]);


            }

        }


        if ($uid >0){
            $page_info = $table->getPagerInfo();
            $this->assign('page_info',FPager::getPagerInfo($total, $page, '20'));
            $this->assign('user_messages', $user_messages);
            $this->assign('user_avatar', $user_avatar);
        }
        $this->assign('uid', $uid);
        $this->display('admin/usermessage_list');
    }



}