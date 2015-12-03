<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/23
 * Time: 上午10:10
 */
class Controller_Admin_Topic extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){
        $this->display('admin/user_topic_list');
    }




    //获取所有圈子
    function listAction(){
        //global $_F;
       // $_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));
        $uid = FRequest::getInt('uid');

        $where = array(
           // 'tp.status'=>'1'
        );

        if($uid >0){
            $where["ud.uid"] = $uid;
        }


        $table = new FTable("topic","tp");
        $topics = $table->fields(array(
            "tp.id",
            "tp.uid",
            "tp.title",
            "tp.pics",
            "ud.nickname",
            "tp.picslevel",
            "tp.status"
        ))->leftJoin("user_detail","ud","tp.uid=ud.uid")
            ->where($where)->page($page)->limit(20)->order(array("tp.id"=>"desc"))->select();

        foreach($topics as &$topic){
            $topic_tupian = explode(",",$topic['pics']);
            $pics="";
            foreach($topic_tupian as $topic_pics) {
                if ($topic_pics) {
                    $pics =$pics.CommonUtil::getMoreSizeImg($topic_pics, 100, 100).",";
                }
            }
            $topic["pics"] =$pics;
        }


        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('topics', $topics);
        $this->assign('uid', $uid);
        $this->display('admin/user_topic_list');
    }


    public function shenheAction() {
        global $_F;
       // $_F["debug"] = true;

        $tid = FRequest::getPostInt('tid');


        $params = array("tid"=>$tid);

       // $params =json_encode($params);
       // echo($params);
        $url =  FConfig::get('global.service_mumu_url')."/s/topic/IClose";
        // $url =  "http://yfservice.admin.docker:8081/s/topic/IClose";
       // echo( $url);

        //$params=Service_Common::post($url,$params);

        //$cookie = "sid=306123456;uid=5000513;key=306123456";
        $cookie = "sid=".FSession::get('sid').";uid=".FSession::get('user_id').";key=".FSession::get('sid');


        $params = FHttp::doPost($url,$params,$cookie);

        //print_r($params);
        $params=json_decode($params);

       if($params->status=="ok"){
           $this->showMessage("封闭成功",$messageType = 'success');
           echo( "<script LANGUAGE='javascript'>guanbi('guanbi_".$tid."');</script>");

        } else{
            $this->showMessage("封闭失败",$messageType = 'success');
        }
        return;

    }

    //获取圈子的聊天记录
    function messageAction(){
        //global $_F;
        // $_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $tid = FRequest::getInt('tid');
        $query_str= "  ( mm.type='pic' or mm.type='text' ) ";
        $where = array();

        if($tid >0){
            $where["mm.tag"] = "topic_".$tid;
            $where["str"] =  $query_str;
        }

        $table = new FTable("tag_message","mm",FDB::$DB_MUMU_MESSAGE);
        $user_messages = $table->fields(array(
            "mm.from",
            "mm.content",
            "mm.type"
        )) ->where($where)->page($page)->limit(100)->order(array("mm.id"=>"desc"))->select();

        foreach($user_messages as &$user_message){

            $user_message["content"] = json_decode($user_message["content"]);


        }
        $page_info = $table->getPagerInfo();
        if ($tid >0){
            $this->assign('page_info', $page_info);
            $this->assign('user_messages', $user_messages);
        }
        $this->assign('uid', $tid);
        $this->display('admin/topicmessage_list');
    }


}