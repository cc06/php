<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Share extends Controller_Www_Abstract
{
    public function dynamicAction()
    {
        global $_F;
      //  $_F["debug"] = true;
        $uid = FRequest::getInt('uid');
        $id = FRequest::getInt('id');
        $table  = new FTable("dynamics","dy");
        $dy = $table->where(array("id"=>$id))->find();
        // echo(json_encode($dy));
        if(!$dy||$dy["uid"]<=0){
            return;
        }
        $user = Service_Client::getUserByUid($uid);
        $user["age"] = CommonUtil::birthdayToAge($user["birthday"]);
        $this->assign('dy',$dy);
        $this->assign('user',$user);

        $pic = $dy["pic"];
        if($pic){
            $pic_arr = explode(",",$pic);
         //   echo json_encode($pic_arr);
            $this->assign("pic_arr",$pic_arr);
        }
        $this->display('shareDynamic');
    }
    public function articleAction()
    {
        global $_F;
        $id = FRequest::getInt('id');
        $table  = new FTable("dynamics","dy");
        $dy = $table->where(array("id"=>$id))->find();
        // echo(json_encode($dy));
        if(!$dy||$dy["uid"]<=0){
            return;
        }
        FResponse::redirect($dy["url"]);
    }


    public function puzzleAction()
    {
        global $_F;
       // $_F["debug"] = true;
        $uid = FRequest::getInt('uid');
        $id = FRequest::getInt('id');
        $table  = new FTable("dynamics","dy");
        $dy = $table->where(array("id"=>$id))->find();
       // echo(json_encode($dy));
        if(!$dy||$dy["uid"]<=0){
            return;
        }
        $user = Service_Client::getUserByUid($uid);
        $table2 = new FTable("comment","c");
        $tms = $table2->fields(array("ud.uid","ud.nickname","ud.avatar","c.*"))->where(array("source_id"=>$id,"status"=>0,"source_type"=>1,"type"=>3))->leftJoin("user_detail","ud","c.uid = ud.uid")->select();
        $join = false;
        $join_item = array();

        foreach($tms as $key=>&$tmItem){
            if($tmItem["avatar"]=="" || $tmItem["nickname"]==""){
                unset($tms[$key]);
                continue;
            }
            $avatar = $tmItem["avatar"];
            $tmItem["avatar"] = CommonUtil::getMoreSizeImg($avatar,100,100);
            if($tmItem["uid"]==$uid){
                $join = true;
                $join_item = $tmItem;
                break;
            }
        }
        if(count($tms)>10){
            $tms_10 = array_slice($tms,0,10);
        }else{
            $tms_10 = $tms;
        }

        // 如果用户参与了拼图游戏，则需要结算胜率
        if($join){
            $this->assign("tm",$join_item["content"]);
        }

       // $dy["game_pic"] =$dy["pic"];
         $dy["game_pic"] = CommonUtil::getMoreSizeImg($dy["pic"],400,400);
        $dy["pic_big"] = $dy["pic"];
       // $dy["pic"] = CommonUtil::getMoreSizeImg($dy["pic"],200,200);
        $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],50,50);
        $this->assign("tms",$tms_10);
        $this->assign("join",$join);
        $this->assign("downUrl","http://down.xingyuan01.cn/imswing/Swing_8000_1021_1002_1.02.apk");
        $this->assign("dy",$dy);
        $this->assign("user",$user);
        $this->display('sharePuzzle2');
        /*$this->display('sliding');*/
    }


    public function puzzle2Action()
    {
        global $_F;
        //   $_F["debug"] = true;
        $uid = FRequest::getInt('uid');
        $id = FRequest::getInt('id');
        $table  = new FTable("dynamics","dy");
        $dy = $table->where(array("id"=>$id))->find();
        // echo(json_encode($dy));
        if(!$dy||$dy["uid"]<=0){
            return;
        }
        $user = Service_Client::getUserByUid($uid);
        $table2 = new FTable("comment","c");
        $tms = $table2->fields(array("ud.uid","ud.nickname","ud.avatar","c.*"))->where(array("source_id"=>$id,"status"=>0,"source_type"=>1,"type"=>3))->leftJoin("user_detail","ud","c.uid = ud.uid")->select();
        $join = false;
        $join_item = array();

        foreach($tms as $key=>&$tmItem){
            if($tmItem["avatar"]=="" || $tmItem["nickname"]==""){
                unset($tms[$key]);
                continue;
            }
            $avatar = $tmItem["avatar"];
            $tmItem["avatar"] = CommonUtil::getMoreSizeImg($avatar,100,100);
            if($tmItem["uid"]==$uid){
                $join = true;
                $join_item = $tmItem;
                break;
            }
        }
        if(count($tms)>10){
            $tms_10 = array_slice($tms,0,10);
        }else{
            $tms_10 = $tms;
        }

        // 如果用户参与了拼图游戏，则需要结算胜率
        if($join){
            $this->assign("tm",$join_item["content"]);
        }

        $dy["pic"] = CommonUtil::getMoreSizeImg($dy["pic"],200,200);
        $dy["pic_big"] = CommonUtil::getMoreSizeImg($dy["pic"],400,400);
        $user["avatar"] = CommonUtil::getMoreSizeImg($user["avatar"],50,50);
        $this->assign("tms",$tms_10);
        $this->assign("join",$join);
        $this->assign("dy",$dy);
        $this->assign("user",$user);
        $this->display('sharePuzzle2');
        /*$this->display('sliding');*/
    }
}

