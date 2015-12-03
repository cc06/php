<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15/5/28
 * Time: 下午7:20
 */
class Controller_Admin_YUser extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }
    static  $STARS = Array("白羊座","金牛座","双子座","巨蟹座","狮子座","处女座","天秤座","天蝎座","射手座","摩羯座","水瓶座","双鱼座");

    //获取所有一审用户列表
    function listAction(){
          global $_F;
        // $_F["debug"] = true;

        $uid = FRequest::getInt("uid");
        $page = max(1, FRequest::getInt('page'));
        $gender = FRequest::getInt('gender');

        $province = FRequest::getString('province');
        $city = FRequest::getString('city');
        $this->assign("province",$province);
        $this->assign("city",$city);
        $where = array();
        if($uid >0){
            $where["um.uid"] = $uid;
        } else {
            $query_str= " ur.item = 'all'  ";
            $where["ur.status"] = 0;
            $query_str=$query_str." and ur.uid >= '5000000'  ";
            if ($city=="长沙") {
                $where["ud.city"] =  $city;
            }
            if ($city=="北京") {
                $where["ud.city"] =  $city;
            }
            if ($city=="非长沙") {
                $query_str=$query_str." and ud.city<>'长沙'";
            }
            $where["str"] = $query_str;
        }
        if ($gender) {
            $where["um.gender"] = $gender;
        }
        if($uid >0){
            $table = new FTable("user_main","um");
            $users = $table->fields(array(
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
                "ud.aboutme",
                "ud.workarea",
                "ud.job",
                "ud.interest",
                "ud.birthday",
                "ud.workplaceid"
            ))
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where)->page($page)->limit(20) ->select();
        } else {
            $table = new FTable("update_record","ur");
            $users = $table->fields(array(
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
                "ud.aboutme",
                "ud.workarea",
                "ud.job",
                "ud.interest",
                "ud.birthday",
                "ud.workplaceid"
            ))->leftJoin("user_main","um","ur.uid=um.uid")
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where)->page($page)->limit(20) ->groupBy("ur.uid")->order(array("ur.id"=>"asc"))->select();
            $table = new FTable("update_record","ur");
            $user_messages2 = $table->fields(array(
                "um.uid"
            ))->leftJoin("user_main","um","ur.uid=um.uid")
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where) ->groupBy("ur.uid")->select();
            $total = count($user_messages2);

        }

        foreach($users as &$user){
           //$user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],200,200);
            $user["age"] =CommonUtil::birthdayToAge($user["birthday"]);
            $dynamics = new FTable("dynamics");
            $dynamic = $dynamics->fields(array("count(*) as count"))->where(array("uid"=>$user["uid"],"str"=>" status in (2,3,4) "))->select();
            $user["dynamics"] =$dynamic[0]['count'];
            //echo($user["dynamics"]);
            $photo_table = new FTable("user_photo_album");
            $photos_o = $photo_table->fields(array("pic","albumid"))->where(array("uid"=>$user["uid"],"str"=>" pic <> '".$user["avatar"]."'"))->select();
            $photos = array();
            foreach($photos_o as &$p){
                $p["pic"] =CommonUtil::getMoreSizeImg($p["pic"],150,150);
                array_push($photos,$p);
            }
            $user["photo_arr"] = $photos;

            $update_record = new FTable("update_record");
            $updates = $update_record->fields(array("item"))->where(array("uid"=>$user["uid"],"status"=>0))->select();

            $update_arr = array();
            $j=0;
            foreach ($updates as $update) {
                $update_arr[$j]= $update['item'];
                $j++;
            }
            //echo(json_encode($update_arr));
            if (in_array("nickname",$update_arr)) { $user["nicknamecss"] = "red"; }
            if (in_array("avatar",$update_arr)) { $user["avatarcss"] = "red"; }
            if (in_array("aboutme",$update_arr)) { $user["aboutmecss"] = "red"; }


            $uid_d = $user["uid"];

            $table2 = new FTable("image_md5","im");
            $image_md5 = $table2->fields(array("im.md5")) ->where(array("im.url"=>$user["avatar"]))->find();
            // echo($user["avatar"]);
            $table3 = new FTable("image_md5","im");
            $images  = $table3->fields(array("im.url")) ->where(array("im.md5"=>$image_md5["md5"],"str"=>" im.url<>'".$user["avatar"]."' "))->select();
            $i=1;
            foreach($images as $image){

                $table4 = new FTable("user_detail","ud");
                $users4 = $table4->fields(array("ud.uid")) ->where(array("ud.avatar"=>$image['url']))->find();
                if ($users4) {
                    $i++;
                    $uid_d = $uid_d.",".$users4['uid'];
                }
            }
            $user["uid_d"] =$uid_d;
            $user["uid_i"] = $i;
            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],150,150);
        }
        if($uid >0){
            $page_info = $table->getPagerInfo();
        } else {
            $page_info =  FPager::getPagerInfo($total, $page, 20);
        }



        $this->assign('page_info', $page_info);
        $this->assign("users",$users);
        $this->assign("uid",$uid);
        $this->assign('gender', $gender);
        $this->display('admin/y_user_list');
    }

    function list2Action(){

        $uid = FRequest::getInt("uid");
        $page = max(1, FRequest::getInt('page'));
        $gender = FRequest::getInt('gender');

        $province = FRequest::getString('province');
        $city = FRequest::getString('city');
        $this->assign("province",$province);
        $this->assign("city",$city);
        $where = array();

        if($uid >0){
            $where["um.uid"] = $uid;
        } else {
            $query_str= " ur.item <> 'all'  ";
            $where["ur.status"] = 0;
            $query_str=$query_str." and ur.uid >= '5000000'  ";
            if ($city=="长沙") {
                $where["ud.city"] =  $city;
            }
            if ($city=="北京") {
                $where["ud.city"] =  $city;
            }
            if ($city=="非长沙") {
                $query_str=$query_str." and ud.city<>'长沙'";
            }
            $where["str"] = $query_str;
        }
        if ($gender) {
            $where["um.gender"] = $gender;
        }

        if($uid >0){
            $table = new FTable("user_main","um");
            $users = $table->fields(array(
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
                "ud.aboutme",
                "ud.workarea",
                "ud.job",
                "ud.interest",
                "ud.birthday",
                "ud.workplaceid"
            ))
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where)->page($page)->limit(20) ->select();
        } else {

            $table = new FTable("update_record","ur");
            $users = $table->fields(array(
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
                "ud.aboutme",
                "ud.workarea",
                "ud.job",
                "ud.interest",
                "ud.birthday",
                "ud.workplaceid"
            ))->leftJoin("user_main","um","ur.uid=um.uid")
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where)->page($page)->limit(20) ->groupBy("ur.uid")->order(array("ur.id"=>"asc"))->select();
            $table = new FTable("update_record","ur");
            $user_messages2 = $table->fields(array(
                "um.uid"
            ))->leftJoin("user_main","um","ur.uid=um.uid")
                ->leftJoin("user_detail","ud","um.uid=ud.uid")
                ->where($where) ->groupBy("ur.uid")->select();
            $total = count($user_messages2);
        }


        foreach($users as &$user){
            //$user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],200,200);
            $user["age"] =CommonUtil::birthdayToAge($user["birthday"]);
            $dynamics = new FTable("dynamics");
            $dynamic = $dynamics->fields(array("count(*) as count"))->where(array("uid"=>$user["uid"],"str"=>" status in (2,3,4) "))->select();
            $user["dynamics"] =$dynamic[0]['count'];
            $photo_table = new FTable("user_photo_album");
            $photos_o = $photo_table->fields(array("pic","albumid"))->where(array("uid"=>$user["uid"],"str"=>" pic <> '".$user["avatar"]."'"))->select();
            $photos = array();
            foreach($photos_o as &$p){
                $p["pic"] =CommonUtil::getMoreSizeImg($p["pic"],150,150);
                array_push($photos,$p);
            }
            $user["photo_arr"] = $photos;

            $update_record = new FTable("update_record");
            $updates = $update_record->fields(array("item"))->where(array("uid"=>$user["uid"],"status"=>0))->select();

            $update_arr = array();
            $j=0;
            foreach ($updates as $update) {
                $update_arr[$j]= $update['item'];
                $j++;
            }
            //echo(json_encode($update_arr));
            if (in_array("nickname",$update_arr)) { $user["nicknamecss"] = "red"; }
            if (in_array("avatar",$update_arr)) { $user["avatarcss"] = "red"; }
            if (in_array("aboutme",$update_arr)) { $user["aboutmecss"] = "red"; }


            $uid_d = $user["uid"];

            $table2 = new FTable("image_md5","im");
            $image_md5 = $table2->fields(array("im.md5")) ->where(array("im.url"=>$user["avatar"]))->find();
            // echo($user["avatar"]);
            $table3 = new FTable("image_md5","im");
            $images  = $table3->fields(array("im.url")) ->where(array("im.md5"=>$image_md5["md5"],"str"=>" im.url<>'".$user["avatar"]."' "))->select();
            $i=1;
            foreach($images as $image){

                $table4 = new FTable("user_detail","ud");
                $users4 = $table4->fields(array("ud.uid")) ->where(array("ud.avatar"=>$image['url']))->find();
                if ($users4) {
                    $i++;
                    $uid_d = $uid_d.",".$users4['uid'];
                }


            }

            $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],150,150);
            $user["uid_d"] =$uid_d;
            $user["uid_i"] = $i;

        }
        if($uid >0){
            $page_info = $table->getPagerInfo();
        } else {
            $page_info =  FPager::getPagerInfo($total, $page, 20);
        }


        $this->assign('page_info', $page_info);
        $this->assign("users",$users);
        $this->assign("uid",$uid);
        $this->assign('gender', $gender);
        $this->display('admin/y_user_list2');
    }
    function  listdynamicsAction()
    {
        global $_F;
        // $_F["debug"] = true;

        $uid = FRequest::getInt('uid');

        $table = new FTable("dynamics","dy");
        $dynamics = $table->fields(array(
            "dy.pic",
            "dy.text"
        ))
            ->where(array("uid"=>$uid,"str"=>" status in (2,3,4) "))->select();



        $this->assign('dynamics', $dynamics);

        $this->display('admin/y_list_dynamics');

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
        $photos = $photo_table->fields(array("pic","albumid"))->where(array("uid"=>$uid,"first_status"=>0))->select();
        $photo_arr = $photos;
        $uid_d = $uid;

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
        $updates = $update_record->fields(array("item"))->where(array("uid"=>$uid,"status"=>0))->select();
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


        $this->display('admin/y_user_update');
    }


}

