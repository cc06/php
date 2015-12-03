<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15/5/28
 * Time: 下午7:20
 */
class Controller_Admin_YUser2 extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }
    static  $STARS = Array("白羊座","金牛座","双子座","巨蟹座","狮子座","处女座","天秤座","天蝎座","射手座","摩羯座","水瓶座","双鱼座");

    //获取所有待二审用户
    function listAction(){

        $uid = FRequest::getInt("uid");
        $page = max(1, FRequest::getInt('page'));
        $shen = FRequest::getInt("shen");


        $where = array();
        //$where["vu.status2"] = -2;
        $where["vu.flag"] = 0;
        if($uid >0){
            $where["vu.uid"] = $uid;
        }

        $table = new FTable("verify_user","vu");
        $users = $table->fields(array(
            "vu.id",
            "vu.status",
            "vu.reason",
            "um.uid",
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
        ))->leftJoin("user_main","um","vu.uid=um.uid")
            ->leftJoin("user_detail","ud","um.uid=ud.uid")
            ->where($where)->page($page)->limit(20) ->order(array("um.uid"=>"desc"))->select();
        if ($shen==1) {
            header("Location: /admin/YUser2/update?uid=".$users[0]["uid"]);
            exit;
        }
        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign("users",$users);
        $this->assign("uid",$uid);
        $this->display('admin/y_user2_list');
    }

    /**
     * 审核用户详情
     */
    function  updateAction(){
        global $_F;

        $uid = FRequest::getInt("uid");
        $user_detail_table = new FTable("user_main","um");
        $user = $user_detail_table->leftJoin("user_detail","ud","um.uid=ud.uid")
            ->where(array("um.uid"=>$uid))->select();
        $user[0]["age"] =CommonUtil::birthdayToAge($user[0]["birthday"]);
        $interests = explode(",",$user[0]["interest"]);

        $this->assign("old_interests",$interests);

        $photo_table = new FTable("user_photo_album");
        $photos = $photo_table->fields(array("pic","albumid","first_status"))->where(array("uid"=>$uid,"status"=>0))->select();
        $photo_arr = $photos;
        $uid_d = $uid;

            $table2 = new FTable("verify_user","vu");
            $verify_user = $table2->fields(array("vu.id","vu.status", "vu.reason")) ->where(array("vu.uid"=>$uid,"vu.flag"=>0))->find();
        $user[0]["id"] =$verify_user['id'];
        $user[0]["status"] = $verify_user['status'];
        $user[0]["reason"] = $verify_user['reason'];
        $table2 = new FTable("image_md5","im");
        $image_md5 = $table2->fields(array("im.md5")) ->where(array("im.url"=>$user[0]["avatar"]))->find();
            // echo($user["avatar"]);
            $table3 = new FTable("image_md5","im");
            $images  = $table3->fields(array("im.url")) ->where(array("im.md5"=>$image_md5["md5"],"str"=>" im.url<>'".$user[0]["avatar"]."' "))->select();
            $i=1;
            foreach($images as $image){

                $i++;
                $table4 = new FTable("user_detail","ud");
                $users4 = $table4->fields(array("ud.uid")) ->where(array("ud.avatar"=>$image['url']))->find();
                if ($users4) {
                    $uid_d = $uid_d.",".$users4['uid'];
                }


            }

            $user[0]["uid_d"] =$uid_d;
            $user[0]["uid_i"] = $i;

            $user[0]["avatar"] = CommonUtil::getMoreSizeImg($user[0]["avatar"],222,222);


        $this->assign("user",$user[0]);

        $update_record = new FTable("update_record");
        $updates = $update_record->fields(array("item"))->where(array("uid"=>$uid,"status"=>1))->select();
        //$update_arr = $updates;
        //$size = count($updates);
        $update_arr = array();
        $j=0;
        foreach ($updates as $update) {
            $update_arr[$j]= $update['item'];
            $j++;
        }
        //echo(json_encode($update_arr));
        if (in_array("nickname",$update_arr)) { $nickname = "red"; }
        if (in_array("avatar",$update_arr)) { $avatar = "red"; }
        if (in_array("aboutme",$update_arr)) { $aboutme = "red"; }

       /* $photo_arr = array();
        foreach($photos as $photo){
            array_push($photo_arr,$photo["pic"]);
        }*/
        //echo(count($photo_arr));
        $this->assign("photos",$photo_arr);
        $this->assign("photos_num",count($photo_arr));

        $this->assign("stars",self::$STARS);
        $this->assign("nickname",$nickname);
        $this->assign("avatar",$avatar);
        $this->assign("aboutme",$aboutme);



        $this->display('admin/y_user2_update');
    }


}

