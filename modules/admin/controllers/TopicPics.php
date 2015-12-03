<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午11:00
 */
class Controller_Admin_TopicPics extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }




    //获取所有有图片未审核圈子
    function listAction(){
        //global $_F;
       // $_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));
        $uid = FRequest::getInt('uid');
        $tiaojian = FRequest::getString('tiaojian');

        $where = array(
            'tp.picslevel'=> array('gte'=> '3'),
            'tp.uid'=> array('gte'=> '5000000'),
            'tp.status'=>'1'
        );

        if($uid >0){
            $where["tp.uid"] = $uid;
        }

        $datetime_riqi=date("Y-m-d", time());
        $datetime_riqi_zuotian=date("Y-m-d", time()-86400);
        $datetime_riqi_qiantian=date("Y-m-d", time()-172800);

        if ($tiaojian=="dangri") {
            $query_str= " tp.tm >= '".$datetime_riqi." 00:00:00'  ";
            $where["str"] = $query_str;
        }
        if ($tiaojian=="zuori") {
            $query_str= " tp.tm >= '".$datetime_riqi_zuotian." 00:00:00'  and tp.tm < '".$datetime_riqi." 00:00:00'  ";
            $where["str"] = $query_str;
        }
        if ($tiaojian=="qianri") {
            $query_str= " tp.tm >= '".$datetime_riqi_qiantian." 00:00:00'  and tp.tm < '".$datetime_riqi_zuotian." 00:00:00'  ";
            $where["str"] = $query_str;
        }
        if ($tiaojian=="fengsuo") {
            $where["tp.status"] = '2';
        } else {
            $where["tp.status"] = '1';
        }

        $table = new FTable("topic","tp");
        $topics = $table->fields(array(
            "tp.id",
            "tp.uid",
            "tp.status",
            "um.gender",
            "tp.title",
            "tp.pics",
            "tp.tm",
            "ud.nickname",
            "ud.province",
            "ud.city",
            "tp.picslevel"
        ))->leftJoin("user_detail","ud","tp.uid=ud.uid")
            ->leftJoin("user_main","um","tp.uid=um.uid")
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
        $this->display('admin/user_topicpics_list');
    }


    public function shenheAction() {
        //global $_F;
       // $_F["debug"] = true;

        $id = FRequest::getInt('id');
        $picslevel = FRequest::getPostInt('picslevel');

        $topic_table = new FTable("topic");
        $topic_table->where(array('id' => $id))->update(array("picslevel"=>$picslevel));



        $params = array("tid"=>"200");
        $params =json_encode($params);

        $url =  FConfig::get('global.service_mumu_url')."/topic/ClearCache";

        $params=Service_Common::post($url,$params);

        $params=json_decode($params);

        if($params->status=="ok"){
            $this->showMessage("审核成功",$messageType = 'success');
        } else{
            $this->showMessage("审核失败",$messageType = 'success');
        }
        return;

    }


}