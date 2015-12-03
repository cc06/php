<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/18
 * Time: 上午9:30
 */
class Controller_Admin_UserXingjiDate extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){
       // $datetime_zuotian = date("Y-m-d ", time() - 86400);
       // $datetime_jintian = date("Y-m-d ", time());

        $datetime_jintian = FRequest::getString("datetime_jintian");
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
    function listAction()
    {
        global $_F;
       // $_F["debug"] = true;


        //$datetime_jintian = "2015-07-04";
        $datetime_jintian = date("Y-m-d ", time());
        //$datetime_zuotian = date("Y-m-d",strtotime("$datetime_jintian - 1 days"));

        $query_str= " tm >= '" . $datetime_jintian . " 00:00:00'   ";
        $query_str2= " ac.tm >= '" . $datetime_jintian . " 00:00:00'   ";

        $user_star_date=array();
        $user_star_date['date']=$datetime_jintian;


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

        if ($user_ids){

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


        }


       // echo(json_encode($user_star_date));


        $table = new FTable("user_star_date");
        $user_star_date1 = $table->limit(30)->order(array("date"=>"desc"))->select();

        $this->assign('user_star_date', $user_star_date);
        $this->assign('user_star_date1', $user_star_date1);

        $this->display('admin/user_xingjidate_list');

    }
}