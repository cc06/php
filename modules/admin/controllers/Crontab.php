<?php

/*
 * 部署crontab的方法
 */
class Controller_Crontab extends FController {

    // 生成活动当天的爆奖记录
    public function genActAwardAction() {
        $tm = date("Y-m-d");
        // 查询所有需要参与爆奖的活动
        $game_act_table = new FTable("game_act_config","gac");
        $date_str = "gac.s_date <= '".$tm."' and gac.e_date >= '".$tm."'  ";
        $acts = $game_act_table->where(array("gac.status"=>1,"gac.award_style"=>array("in"=>array(2,3)),"str"=>$date_str))->select();
        echo(count($acts)."&&<br>");
        $now = date("Y-m-d H:i:s");

        if(count($acts)>0){
            foreach($acts as $act){
                $num = $act["num"];
                $finish_num = Service_Cron::getAwardsByActId($act["game_id"],$act["id"],$now);
                $awards_arr = Service_Cron::genAwardsByActID($act,$num-$finish_num);
                echo(json_encode($awards_arr)."<br>");
            }
        }
    }

    function showMessage($message, $messageType = 'success', $jumpUrl = null) {
        if ($messageType == 'error') {
            $messageType = 'warning';
        }
        $this->assign('messageType', $messageType);
        $this->assign('message_content', $message);
        $this->assign('jump_url', $jumpUrl);
        $this->display('admin/message');
        return true;
    }

    //计算 user_star_date 星级用户统计
    function userStarDateAction(){
        // $datetime_zuotian = date("Y-m-d ", time() - 86400);
        // $datetime_jintian = date("Y-m-d ", time());

        $datetime_jintian = FRequest::getString("datetime_jintian");
        if (!$datetime_jintian) { $datetime_jintian = date("Y-m-d ", time());  }
        if ($datetime_jintian) {

            //$datetime_jintian = "2015-07-04";
            //$datetime_jintian = date("Y-m-d ", time());
            $datetime_zuotian = date("Y-m-d",strtotime("$datetime_jintian - 1 days"));

            $query_str= " tm >= '" . $datetime_zuotian . " 00:00:00' and  tm < '" . $datetime_jintian . " 00:00:00'   ";
            $query_str2= " ac.tm >= '" . $datetime_zuotian . " 00:00:00' and  ac.tm < '" . $datetime_jintian . " 00:00:00'   ";

            $user_star_date=array();
            $user_star_date['date']=$datetime_zuotian;


            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table->fields(array("count(*) as count","gender"))->where(array("str"=>$query_str2,"type"=>22))->groupBy("gender")->select();
            foreach ($actions as $action) {
                if ($action['gender']==1) { $user_star_date['login_man'] = $action['count'];}
                if ($action['gender']==2) { $user_star_date['login_woman'] = $action['count'];}
            }
            $table = new FTable("user_star_level", "usl");
            $usls = $table->fields(array("usl.uid" ))->where(array("usl.level"=> array('gte'=> '1'))) ->select();

            $user_ids=array();
            foreach ($usls as $usl) {
                array_push($user_ids, $usl['uid']);

            }
            $user_ids=implode(",",$user_ids);

            //echo($user_ids);

            $table = new FTable("user_star_level", "usl");
            $usls = $table->fields(array("count(*) as count","level","gender"))
                ->where(array("usl.level"=> array('gte'=> '1')))
                ->groupBy("level,gender")->select();
            // echo(json_encode($usls));
            foreach ($usls as $usl) {
                if ($usl['level']=='1') {
                    if ($usl['gender'] == '1') {
                        $user_star_date["level1_man"] = $usl['count'];
                    }
                    if ($usl['gender'] == '2') {
                        $user_star_date["level1_woman"] = $usl['count'];
                    }
                }
                if ($usl['level']=='2') {
                    if ($usl['gender'] == '1') {
                        $user_star_date["level2_man"] = $usl['count'];
                    }
                    if ($usl['gender'] == '2') {
                        $user_star_date["level2_woman"] = $usl['count'];
                    }
                }
                if ($usl['level']=='3') {
                    if ($usl['gender'] == '1') {
                        $user_star_date["level3_man"] = $usl['count'];
                    }
                    if ($usl['gender'] == '2') {
                        $user_star_date["level3_woman"] = $usl['count'];
                    }
                }

            }
            $table = new FTable("user_star_level", "usl");
            $usls = $table->fields(array("count(*) as count","level","gender"))
                ->where(array("usl.level"=> array('in'=> '1,2'),"changes"=>"-1","str"=>$query_str))
                ->groupBy("level,gender")->select();
            // echo(json_encode($usls));
            foreach ($usls as $usl) {
                if ($usl['level']=='2') {
                    if ($usl['gender'] == '1') {
                        $user_star_date["level3_2_man"] = $usl['count'];
                    }
                    if ($usl['gender'] == '2') {
                        $user_star_date["level3_2_woman"] = $usl['count'];
                    }
                }
                if ($usl['level']=='1') {
                    if ($usl['gender'] == '1') {
                        $user_star_date["level2_1_man"] = $usl['count'];
                    }
                    if ($usl['gender'] == '2') {
                        $user_star_date["level2_1_woman"] = $usl['count'];
                    }
                }
            }

            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table
                ->where(array("str"=>$query_str2,"uid"=> array('in'=>$user_ids),"gender"=>1,"type"=>'9'))
                ->groupBy("uid")->select();
            $user_star_date['star_message_man'] = count($actions);
            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table
                ->where(array("str"=>$query_str2,"uid"=> array('in'=>$user_ids),"gender"=>2,"type"=>'9'))
                ->groupBy("uid")->select();
            $user_star_date['star_message_woman'] = count($actions);

            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table->fields(array("count(*) as count","gender","type"))
                ->where(array("str"=>$query_str2,"uid"=> array('in'=>$user_ids),"type"=>array('in'=>'10,9')))
                ->groupBy("type,gender")->select();
            foreach ($actions as $action) {
                //总消息量
                if ($action['type']=='9') {
                    if ($action['gender']==1) { $user_star_date['star_messages_man'] = $action['count'];}
                    if ($action['gender']==2) { $user_star_date['star_messages_woman'] = $action['count'];}
                }
                //关注人数
                if ($action['type']=='10') {
                    if ($action['gender']==1) { $user_star_date['star_follow_man'] = $action['count'];}
                    if ($action['gender']==2) { $user_star_date['star_follow_woman'] = $action['count'];}
                }


            }
            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table
                ->where(array("str"=>$query_str2,"uid"=> array('in'=>$user_ids),"gender"=>1,"type"=>'13'))
                ->groupBy("uid")->select();
            $user_star_date['star_game_man'] = count($actions);
            $table = new FTable("Actions", "ac", FDB::$DB_MUMU_STAT);
            $actions = $table
                ->where(array("str"=>$query_str2,"uid"=> array('in'=>$user_ids),"gender"=>2,"type"=>'13'))
                ->groupBy("uid")->select();
            $user_star_date['star_game_woman'] = count($actions);



            //echo(json_encode($user_star_date));
            $table = new FTable("user_star_date");
            $user_star_date1 = $table->where(array("date"=>$datetime_zuotian))->select();
          if ($user_star_date1) {
              $user_star_level_table = new FTable("user_star_date");
              $result=$user_star_level_table->where(array('date' => $datetime_zuotian))->update($user_star_date);
          } else {
              $user_star_level_table = new FTable("user_star_date");
              $result=$user_star_level_table->insert($user_star_date);
          }


            if($result){
                //$this->success('插入成功！');
            }else{
                //$this->error("插入失败");
            }

        }
    }

    //把
    function messageDateAction()
    {
        // $datetime_zuotian = date("Y-m-d ", time() - 86400);
        // $datetime_jintian = date("Y-m-d ", time());


        $datetime_jintian = FRequest::getString("datetime_jintian");
        if (!$datetime_jintian) { $datetime_jintian = date("Y-m-d ", time());  }
        if ($datetime_jintian) {

            //$datetime_jintian = "2015-07-04";
            //$datetime_jintian = date("Y-m-d ", time());
            $datetime_zuotian = date("Y-m-d", strtotime("$datetime_jintian - 1 days"));

            $datetime_qitian = date("Y-m-d ", strtotime("$datetime_jintian - 7 days"));

            $query_str_7 = "  tm < '" . $datetime_qitian . " 00:00:00'   ";

            $where = array();
            $users = array();
            $query_str = " mm.from>'5000000' and mm.tm >= '" . $datetime_zuotian . " 00:00:00' and  mm.tm < '" . $datetime_jintian . " 00:00:00' and mm.type in ('text','pic','voice') ";
            //$query_str = " 1=1";

            $useradds = new FTable('user_message_7');
            $useradds->where(array('str' => $query_str_7))->remove(true);

            $where["str"] = $query_str;

            $table = new FTable("message", "mm", FDB::$DB_MUMU_MESSAGE);
            $user_messages = $table->fields(array(
                "mm.from",
                "mm.tm"
            ))
                ->where($where)->groupBy("mm.from")->select();
            foreach ($user_messages as $user_message) {
                $data2 = array(
                    'uid' => $user_message['from'],
                    'tm' => $user_message['tm']
                );
                $user_detail_table = new FTable("user_message_7");
                $user_detail_table->insert($data2);

            }
            $table = new FTable("tag_message", "mm", FDB::$DB_MUMU_MESSAGE);
            $user_messages = $table->fields(array(
                "mm.from",
                "mm.tm"
            ))
                ->where($where)->groupBy("mm.from")->select();
            foreach ($user_messages as $user_message) {
                $data2 = array(
                    'uid' => $user_message['from'],
                    'tm' => $user_message['tm']
                );
                $user_detail_table = new FTable("user_message_7");
                $user_detail_table->insert($data2);

            }
        }
    }
}