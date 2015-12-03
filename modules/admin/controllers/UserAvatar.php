<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午9:30
 */
class Controller_Admin_UserAvatar extends  Controller_Admin_Abstract{
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
        $nickname = FRequest::getString('nickname');
        $gender = FRequest::getInt('gender');
        $where = array();
        if ($uid||$nickname) {
          if ($uid) {
              $where["ud.uid"] = $uid;
          }
            if ($nickname) {
                $where["ud.nickname"] = array('like'=> $nickname);
            }
        } else {
            $where["um.stat"] = '0';
            $where["ud.avatarlevel"] = '-2';
            $where["ud.uid"] = array('gte'=> '5000000');
        }
        if ($gender) {
            $where["um.gender"] = $gender;
        }

        $table = new FTable("user_detail","ud");
        $users = $table->fields(array(
            "ud.uid",
            "um.gender",
            "ud.nickname",
            "ud.avatar",
            "ud.avatarlevel"
        )) ->leftJoin("user_main","um","ud.uid=um.uid")
            ->where($where)->page($page)->limit(50)->order(array("ud.uid"=>"asc"))->select();
        foreach($users as &$user){
            $uid_d=$user["uid"];
            $table2 = new FTable("image_md5","im");
            $image_md5 = $table2->fields(array("im.md5")) ->where(array("im.url"=>$user["avatar"]))->find();
           // echo($user["avatar"]);
            $table3 = new FTable("image_md5","im");
            $images  = $table3->fields(array("im.url")) ->where(array("im.md5"=>$image_md5["md5"],"str"=>" im.url<>'".$user["avatar"]."' ","im.type"=>"avatar"))->select();
            $i=1;
            foreach($images as $image){

                $i++;
                $table4 = new FTable("user_detail","ud");
                $users4 = $table4->fields(array("ud.uid")) ->where(array("ud.avatar"=>$image['url']))->find();
               if ($users4) {
                   $uid_d = $uid_d.",".$users4['uid'];
               }


            }

            $user["uid_d"] =$uid_d;
            $user["uid_i"] = $i;

            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],222,222);


        }

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('users', $users);
        $this->assign('uid', $uid);
        $this->assign('nickname', $nickname);
        $this->assign('gender', $gender);
        $this->display('admin/user_avatar_list');
    }

    public function shenheAction() {
        global $_F;
       // $_F["debug"] = true;

        $size = FRequest::getPostInt('size');

        $list =array();
        /*
        for($j=1;$j <$size;$j++) {
            $list[$j-1] =FRequest::getPostString('avatarlevel'.$j);
        }
        $list[$size-1] = FRequest::getPostString('avatarlevel'.$size);
        */

        $list[0] = FRequest::getPostString('avatarlevel'.$size);

        $params = array("list"=>$list);

        $query = explode(",",$list[0]);
        $query =$query[0];
        $params_uid = array("uid"=>$query);

        $params =json_encode($params);
        //$this->showMessage($params,$messageType = 'success');
       // exit;

        $url =  FConfig::get('global.service_mumu_url')."/user/AdminSetAvatarStat";

        $params=Service_Common::post($url,$params);


        /*$url_rztz =  FConfig::get('global.service_mumu_url')."/s/user/ICertifyAvatar";
        $params_rztz=Service_Common::post($url_rztz,json_encode($params_uid));*/

        $url_rztz =  FConfig::get('global.service_mumu_url')."/s/user/ICertifyAvatar";
        $cookie = "sid=".FSession::get('sid').";uid=".FSession::get('user_id').";key=".FSession::get('sid');
        $params_rztz=FHttp::doPost($url_rztz,$params_uid,$cookie);

        $params=json_decode($params);

       /* $url_rztz =  FConfig::get('global.service_mumu_url')."/s/user/ICertifyAvatar";
        $params_rztz=Service_Common::post($url_rztz,$params_uid);*/

        if($params->status=="ok"){



        //$this->showMessage("审核成功",$messageType = 'success');
       } else{
            $this->showMessage("审核失败",$messageType = 'success');
        }


        return;

    }



}