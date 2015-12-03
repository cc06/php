<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15/11/03
 * Time: 下午7:20
 * 用户资料审核
 */
class Controller_Admin_UserVerify extends  Controller_Admin_Abstract{

    /**
     * 首次审核用户形象照
     * @throws Exception
     */
    function verifyPhotoFirstAction(){
        $id = FRequest::getInt("id");
        $status = FRequest::getInt("status");
        if(CommonUtil::parmIsEmpty($id)||CommonUtil::parmIsEmpty($status)){
            FResponse::output(CommonUtil::GetDefRes(201,"参数错误"));
            return;
        }
        $table = new FTable("user_photo_album");
        $data = array(
            'first_status' => $status
        );
        $table->where(array("albumid"=>$id))->update($data);
        FResponse::output(CommonUtil::GetDefRes(200,"操作成功"));





    }

    /**
     * 复审用户形象照
     */
    function verifyPhotoSecondAction(){
        $id = FRequest::getInt("id");
        $status = FRequest::getInt("status");
        if(CommonUtil::parmIsEmpty($id)||CommonUtil::parmIsEmpty($status)){
            FResponse::output(CommonUtil::GetDefRes(201,"参数错误"));
            return;
        }
        $table = new FTable("user_photo_album");
        $abblum = $table->where(array("albumid"=>$id))->find();
        $uid = $abblum["uid"];
        //请求服务端接口
        $url =  FConfig::get('global.service_mumu_url')."/s/user/IUserPhotoVerify";
        $res = Service_Common::secPost($url,array("id"=>$id,"uid"=>$uid,"status"=>$status));
        FResponse::output($res);
    }

    /**
     * 用户资料首审
     */
    function verifyUserFirstAction(){
        $uid = FRequest::getInt("uid");
        $status = FRequest::getInt("status");
        $reason = FRequest::getString("reason");


        if(CommonUtil::parmIsEmpty($uid)||CommonUtil::parmIsEmpty($status)){
            FResponse::output(CommonUtil::GetDefRes(201,"参数错误"));
            return;
        }
        // 检测如果已经存在需要复审记录，则直接返回
        $table2 = new FTable("verify_user");
        $n = $table2->where(array("uid"=>$uid,"flag"=>0))->count();
        if($n>0){
            FResponse::output(CommonUtil::GetDefRes(200,"操作成功"));
            return;
        }
        // 原子操作，开启事务处理
        FDB::begin();
        try{
            // 修改用户资料修改记录状态
            $table = new FTable("update_record");
            $table->where(array("uid"=>$uid,"status"=>0))->update(array("status"=>1));
            // 插入到复审的表里
            $table2 = new FTable("verify_user");
            $id=$table2->insert(array("uid"=>$uid,"status"=>$status,"reason"=>$reason,"aid"=>FSession::get('user_id')));
             FDB::commit();
        }catch (Exception $e){
            FDB::rollBack();
            //写入日志
            $log = new FLogger("user_log");
            $log->append("verifyUserFirstAction:".$e);
            FResponse::output(CommonUtil::GetDefRes(201,"操作失败"));
            return;
        }
       // FResponse::output(CommonUtil::GetDefRes(200,"操作成功"));



        //下面是一审完了，走二审接口
        /*$table2 = new FTable("verify_user","vu");
        $verify_user = $table2->fields(array("vu.id")) ->where(array("vu.uid"=>$uid,"vu.flag"=>0))->find();*/

        $url =  FConfig::get('global.service_mumu_url')."/s/user/IUserInfoVerify";
        $res = Service_Common::secPost($url,array("id"=>$id,"uid"=>$uid,"level"=>$status));

        FResponse::output($res);

    }

    /**
     * 用户资料复审
     */
    function verifyUserSecondAction(){
        $id = FRequest::getInt("id");
        $uid = FRequest::getInt("uid");
        $status = FRequest::getInt("status");
       // $reason = FRequest::getString("reason");
        if(CommonUtil::parmIsEmpty($uid)||CommonUtil::parmIsEmpty($status)||CommonUtil::parmIsEmpty($id)){
            FResponse::output(CommonUtil::GetDefRes(201,"参数错误"));
            return;
        }
        //请求服务端接口
        $url =  FConfig::get('global.service_mumu_url')."/s/user/IUserInfoVerify";
        $res = Service_Common::secPost($url,array("id"=>$id,"uid"=>$uid,"level"=>$status));

        FResponse::output($res);
    }

}

