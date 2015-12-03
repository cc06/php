<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/6
 * Time: 上午16:10
 */
class Controller_Admin_TopicZhiding extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }




    //获取所有圈子
    function listAction(){
        //global $_F;
       // $_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));
        $uid = FRequest::getInt('uid');

        $where = array(
            'tp.status'=>'1'
        );

        if($uid >0){
            $where["ud.uid"] = $uid;
        } else {
            $where["1"]=0;
        }


        $table = new FTable("topic","tp");
        $topics = $table->fields(array(
            "tp.id",
            "tp.uid",
            "tp.title",
            "tp.pics",
            "ud.nickname",
            "tp.picslevel"
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
            $discovery_table = new FTable("discovery","mmd",FDB::$DB_MUMU_SORT);
            $discovery = $discovery_table->where(array('tid' => $topic["id"]))->find();
            $topic["priority"] =$discovery["priority"];
        }


        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('topics', $topics);
        $this->assign('uid', $uid);
        $this->display('admin/user_topic_zhiding_list');
    }


    public function shenheAction() {
        //global $_F;
       // $_F["debug"] = true;

        $tid = FRequest::getPostInt('tid');
        $priority = FRequest::getPostInt('priority');

        $discovery_table = new FTable("discovery","mmd",FDB::$DB_MUMU_SORT);
        $discovery_table->where(array("tid"=>$tid))->update(array("priority"=>$priority));

        $this->showMessage("修改成功","success");
        return;

    }

    public function chexiaoAction() {
        //global $_F;
        // $_F["debug"] = true;

        $tid = FRequest::getInt('tid');
        $priority = FRequest::getPostInt('priority');

        $discovery_table = new FTable("discovery","mmd",FDB::$DB_MUMU_SORT);
        $discovery_table->where(array("tid"=>$tid))->update(array("priority"=>"0"));

        echo( "<script LANGUAGE='javascript'> document.getElementById('priority_".$tid."').value=0;</script>");
        $this->showMessage("撤销成功","success");

        return;

    }


}