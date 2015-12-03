<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午9:30
 */
class Controller_Admin_UserImage extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }




    //获取所有图片
    function listAction(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $nickname = FRequest::getString('nickname');
        $gender = FRequest::getInt('gender');
        $where = array();


        $query_str = " (im.sexy_review = '1' or im.ad_review = '1')  ";


        $table = new FTable("image_md5","im");
        $images = $table->fields(array(
            "im.url",
            "im.status"
        ))
            ->where(array('str' => $query_str))->page($page)->limit(50)->order(array("im.tm"=>"asc"))->select();
        foreach($images as &$image){

            $image["url_xiao"] = CommonUtil::getMoreSizeImg($image["url"],222,222);


        }

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('images', $images);
        $this->display('admin/user_image_list');
    }
    //获取所有图片
    function list2Action(){
        //global $_F;
        //$_F["debug"] = true;


        $page = max(1, FRequest::getInt('page'));

        $uid = FRequest::getInt('uid');
        $nickname = FRequest::getString('nickname');
        $gender = FRequest::getInt('gender');
        $where = array();


        $query_str = " im.status = '1' ";


        $table = new FTable("image_md5","im");
        $images = $table->fields(array(
            "im.url",
            "im.status",
            "im.type"
        ))
            ->where(array('str' => $query_str))
             ->page($page)->limit(50)->order(array("im.tm"=>"asc"))->select();
        foreach($images as &$image){
            //头像
            if ($image['type']=="avatar") {
                $table2 = new FTable("user_detail","ud");
                $users = $table2->fields(array("ud.uid")) ->where(array("ud.avatar"=>$image['url']))->find();
                $image["uid"] = $users['uid'];
                $image["type_w"] = "头像";
            }
            //大头像
            if ($image['type']=="avatar_big") {

                $image["type_w"] = "大头像";
            }
            //相册
            if ($image['type']=="photo") {
                $table2 = new FTable("user_photo_album","upa");
                $users = $table2->fields(array("upa.uid")) ->where(array("upa.pic"=>$image['url']))->find();
                $image["uid"] = $users['uid'];
                $image["type_w"] = "相册";
            }
            //聊天
            if ($image['type']=="chat") {
                $table2 = new FTable("bad_message","bm",FDB::$DB_MUMU_MESSAGE);
                $users = $table2->fields(array("bm.from")) ->where(array("bm.origin"=>$image['url']))->find();
                $image["uid"] = $users['from'];
                $image["type_w"] = "聊天";
            }
            //视屏认证
            if ($image['type']=="video_certify") {
                $table2 = new FTable("video_record","vr");
                $users = $table2->fields(array("vr.uid")) ->where(array("vr.video_img"=>$image['url']))->find();
                $image["uid"] = $users['uid'];
                $image["type_w"] = "视屏认证";
            }



            $image["url_xiao"] = CommonUtil::getMoreSizeImg($image["url"],111,111);


        }

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign('images', $images);
        $this->display('admin/user_image_list2');
    }

    public function shenheAction() {
       // global $_F;
       // $_F["debug"] = true;

        $status = FRequest::getPostInt('status');

        $url = FRequest::getPostString('url');



        $data2 = array(
            'sexy_review' => '0',
            'ad_review' => '0',
            'status' => $status
        );
        $image_md5_table = new FTable("image_md5");
        $result=$image_md5_table->where(array('url' => $url))->update($data2);

        if($result){
           echo('修改成功！');
        }else{
            echo("修改失败");
        }

        return;

    }



}