<?php

class Controller_Admin_UserCertify extends Controller_Admin_Abstract {
    /**
     * 主报表查询
     */
    public function defaultAction(){
        //global $_F;
        //$_F["debug"] = true;

        $time[1]=date("Y-m-d",strtotime("-0 day"));
        $time[2]=date("Y-m-d",strtotime("-1 day"));
        $time[3]=date("Y-m-d",strtotime("-2 day"));
        $time[4]=date("Y-m-d",strtotime("-3 day"));
        $time[5]=date("Y-m-d",strtotime("-4 day"));
        $time[6]=date("Y-m-d",strtotime("-5 day"));
        $time[7]=date("Y-m-d",strtotime("-6 day"));


        $i=1;
        while($i<=7) {
            if ($i==1) {
                $query_str = " um.reg_time >= '" . $time[$i] . " 00:00:00'  ";
                $query_str2= " s.tm >= '" . $time[$i] . " 00:00:00'  ";
               // $query_str3= " tm >= '" . $time[$i] . " 00:00:00' and  ".$query_str;
            } else {
                $query_str = " um.reg_time >= '" . $time[$i] . " 00:00:00' and um.reg_time < '" . $time[$i-1] . " 00:00:00'  ";
                $query_str2= " s.tm >= '" . $time[$i] . " 00:00:00' and  s.tm < '" . $time[$i-1] . " 00:00:00'   ";
               // $query_str3= " tm >= '" . $time[$i] . " 00:00:00' and  tm < '" . $time[$i-1] . " 00:00:00'  and  ".$query_str;

            }
            $user_main_table = new FTable("honesty_record","hr");
            $user_mains = $user_main_table->fields(array("count(*) as count","hr.item"))->leftJoin("user_main","um","hr.uid=um.uid")->where(array('str' => $query_str))->groupBy("hr.item")->select();
            $total_rs[$i]["zhaopian3"] =0;
            $total_rs[$i]["ziliao"] =0;
            //echo(json_encode($user_mains));
            foreach($user_mains as $user_main) {

                if ($user_main['item']=='2') {  $total_rs[$i]["zhaopian3"] = $user_main['count'];  }
                if ($user_main['item']=='3') { $total_rs[$i]["ziliao"] = $user_main['count'];  }

            }

            $table = new FTable("honesty_record","hr");
            $honesty_records = $table->fields(array("um.uid"))
                ->leftJoin("user_main","um","hr.uid=um.uid")
                ->where(array('str' => $query_str,"hr.item" => 2))->groupBy("hr.uid")->select();
            $user_ids1=array();
            foreach ($honesty_records as $honesty_record) {
                array_push($user_ids1, $honesty_record['uid']);
            }
            $table = new FTable("honesty_record","hr");
            $honesty_records = $table->fields(array("um.uid"))
                ->leftJoin("user_main","um","hr.uid=um.uid")
                ->where(array('str' => $query_str,"hr.item" => 3))->groupBy("hr.uid")->select();
            $user_ids2=array();

            foreach ($honesty_records as $honesty_record) {
                array_push($user_ids2, $honesty_record['uid']);
            }
            $user_ids11=array_intersect($user_ids1,$user_ids2);

            $user_ids=implode(",",$user_ids11);
            $baohan_yonghu="";
            if ($user_ids){
                $baohan_yonghu=" uid  in (".$user_ids.") ";
            }
if ($baohan_yonghu) {
    $table = new FTable("user_star_level", "usl");
    $usls = $table->fields(array("count(*) as count" ))->where(array('uid'=>array('gte'=>5000000),"str" => $baohan_yonghu)) ->find();
    $total_rs[$i]["xingji"]=$usls["count"];
    //$total_rs[$i]["xingji"]=0;
    $table = new FTable("user_main", "um");
    $usls = $table->fields(array("count(*) as count" ))->where(array('uid'=>array('gte'=>5000000),"str" => $baohan_yonghu,"stat"=>0)) ->find();
    $total_rs[$i]["pingbi"]=$usls["count"];
    $table = new FTable("user_detail", "ud");
    $usls = $table->fields(array("count(*) as count" ))->where(array('uid'=>array('gte'=>5000000),"str" => $baohan_yonghu,"avatarlevel"=>array('gte' => '3'))) ->find();
    $total_rs[$i]["touxiang"]=$usls["count"];
}



            $table = new FTable("honesty_record","hr");
            $honesty_record = $table->fields(array("count(*) as count"))
                ->leftJoin("user_main","um","hr.uid=um.uid")
                ->where(array('str' => $query_str))->groupBy("hr.uid")->Having("count>1")->select();
           if  ($honesty_record) {
               $total_rs[$i]["zhaopian3_ziliao"] = count($honesty_record);
           } else {
               $total_rs[$i]["zhaopian3_ziliao"] = 0;
           }


            $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
            $Stat = $table->fields(array("sum(s.value) as sum"))
                ->where(array('str' => $query_str2,'s.key'=>"online_award_users_lc_1","s.interval"=>"day"))->find();
            $total_rs[$i]["liucun"] = $Stat['sum'];

            $total_rs[$i]["time"] = $time[$i];

            $user_main_table = new FTable("user_main", "um");
           /* $user_main = $user_main_table->where(array('str' => $query_str, 'gender' => 1))->count();
            $total_rs[$i]["zhuce1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'gender' => 2))->count();
            $total_rs[$i]["zhuce2"] = $user_main;*/

            $user_mains = $user_main_table->fields(array("count(*) as count","gender"))->where(array('str' => $query_str))->groupBy("um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['gender']=='1') {  $total_rs[$i]["zhuce1"] = $user_main['count'];  }
                if ($user_main['gender']=='2') { $total_rs[$i]["zhuce2"] = $user_main['count'];  }
            }
            $total_rs[$i]["zhuce"] = $total_rs[$i]["zhuce1"]+$total_rs[$i]["zhuce2"];

            /*$user_main = $user_main_table->where(array('str' => $query_str, 'phonestat' => 1, 'gender' => 1))->count();
            $total_rs[$i]["phonestat1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'phonestat' => 1, 'gender' => 2))->count();
            $total_rs[$i]["phonestat2"] = $user_main;*/
            $user_mains = $user_main_table->fields(array("count(*) as count","gender"))->where(array('str' => $query_str, 'phonestat' => 1))->groupBy("um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['gender']=='1') {  $total_rs[$i]["phonestat1"] = $user_main['count'];  }
                if ($user_main['gender']=='2') { $total_rs[$i]["phonestat2"] = $user_main['count'];  }
            }
            $total_rs[$i]["phonestat"] = $total_rs[$i]["phonestat1"]+$total_rs[$i]["phonestat2"];

            /*$user_main = $user_main_table->where(array('str' => $query_str, 'certify_video' => 1, 'gender' => 1))->count();
            $total_rs[$i]["certify_video1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_video' => 1, 'gender' => 2))->count();
            $total_rs[$i]["certify_video2"] = $user_main;*/
            $user_mains = $user_main_table->fields(array("count(*) as count","gender"))->where(array('str' => $query_str, 'certify_video' => 1))->groupBy("um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['gender']=='1') {  $total_rs[$i]["certify_video1"] = $user_main['count'];  }
                if ($user_main['gender']=='2') { $total_rs[$i]["certify_video2"] = $user_main['count'];  }
            }
            $total_rs[$i]["certify_video"] = $total_rs[$i]["certify_video1"]+$total_rs[$i]["certify_video2"];

            /*$user_main = $user_main_table->where(array('str' => $query_str, 'certify_idcard' => 1, 'gender' => 1))->count();
            $total_rs[$i]["certify_idcard1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_idcard' => 1, 'gender' => 2))->count();
            $total_rs[$i]["certify_idcard2"] = $user_main;*/
            $user_mains = $user_main_table->fields(array("count(*) as count","gender"))->where(array('str' => $query_str, 'certify_idcard' => 1))->groupBy("um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['gender']=='1') {  $total_rs[$i]["certify_idcard1"] = $user_main['count'];  }
                if ($user_main['gender']=='2') { $total_rs[$i]["certify_idcard2"] = $user_main['count'];  }
            }
            $total_rs[$i]["certify_idcard"] = $total_rs[$i]["certify_idcard1"]+$total_rs[$i]["certify_idcard2"];

            /*$user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 1, 'gender' => 1))->count();
            $total_rs[$i]["certify_level1_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 1, 'gender' => 2))->count();
            $total_rs[$i]["certify_level1_2"] = $user_main;
            $total_rs[$i]["certify_level1"] = $total_rs[$i]["certify_level1_1"]+$total_rs[$i]["certify_level1_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 2, 'gender' => 1))->count();
            $total_rs[$i]["certify_level2_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 2, 'gender' => 2))->count();
            $total_rs[$i]["certify_level2_2"] = $user_main;
            $total_rs[$i]["certify_level2"] = $total_rs[$i]["certify_level2_1"]+$total_rs[$i]["certify_level2_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 3, 'gender' => 1))->count();
            $total_rs[$i]["certify_level3_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'certify_level' => 3, 'gender' => 2))->count();
            $total_rs[$i]["certify_level3_2"] = $user_main;
            $total_rs[$i]["certify_level3"] = $total_rs[$i]["certify_level3_1"]+$total_rs[$i]["certify_level3_2"];*/
            $user_mains = $user_main_table->fields(array("count(*) as count","gender","certify_level"))->where(array('str' => $query_str))->groupBy("um.certify_level,um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['certify_level']=='1') {
                    if ($user_main['gender'] == '1') {
                        $total_rs[$i]["certify_level1_1"] = $user_main['count'];
                    }
                    if ($user_main['gender'] == '2') {
                        $total_rs[$i]["certify_level1_2"] = $user_main['count'];
                    }
                }
                if ($user_main['certify_level']=='2') {
                    if ($user_main['gender'] == '1') {
                        $total_rs[$i]["certify_level2_1"] = $user_main['count'];
                    }
                    if ($user_main['gender'] == '2') {
                        $total_rs[$i]["certify_level2_2"] = $user_main['count'];
                    }
                }
                if ($user_main['certify_level']=='3') {
                    if ($user_main['gender'] == '1') {
                        $total_rs[$i]["certify_level3_1"] = $user_main['count'];
                    }
                    if ($user_main['gender'] == '2') {
                        $total_rs[$i]["certify_level3_2"] = $user_main['count'];
                    }
                }

            }
            $total_rs[$i]["certify_level1"] = $total_rs[$i]["certify_level1_1"]+$total_rs[$i]["certify_level1_2"];
            $total_rs[$i]["certify_level2"] = $total_rs[$i]["certify_level2_1"]+$total_rs[$i]["certify_level2_2"];
            $total_rs[$i]["certify_level3"] = $total_rs[$i]["certify_level3_1"]+$total_rs[$i]["certify_level3_2"];


            /*$user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 1, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level1_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 1, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level1_2"] = $user_main;
            $total_rs[$i]["honesty_level1"] = $total_rs[$i]["honesty_level1_1"]+$total_rs[$i]["honesty_level1_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 2, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level2_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 2, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level2_2"] = $user_main;
            $total_rs[$i]["honesty_level2"] = $total_rs[$i]["honesty_level2_1"]+$total_rs[$i]["honesty_level2_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 3, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level3_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 3, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level3_2"] = $user_main;
            $total_rs[$i]["honesty_level3"] = $total_rs[$i]["honesty_level3_1"]+$total_rs[$i]["honesty_level3_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 4, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level4_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 4, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level4_2"] = $user_main;
            $total_rs[$i]["honesty_level4"] = $total_rs[$i]["honesty_level4_1"]+$total_rs[$i]["honesty_level4_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 5, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level5_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 5, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level5_2"] = $user_main;
            $total_rs[$i]["honesty_level5"] = $total_rs[$i]["honesty_level5_1"]+$total_rs[$i]["honesty_level5_2"];

            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 6, 'gender' => 1))->count();
            $total_rs[$i]["honesty_level6_1"] = $user_main;
            $user_main = $user_main_table->where(array('str' => $query_str, 'honesty_level' => 6, 'gender' => 2))->count();
            $total_rs[$i]["honesty_level6_2"] = $user_main;
            $total_rs[$i]["honesty_level6"] = $total_rs[$i]["honesty_level6_1"]+$total_rs[$i]["honesty_level6_2"];*/
            $user_mains = $user_main_table->fields(array("count(*) as count","gender","honesty_level"))->where(array('str' => $query_str))->groupBy("um.honesty_level,um.gender")->select();
            foreach($user_mains as $user_main) {
                if ($user_main['honesty_level']=='1') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level1_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level1_2"] = $user_main['count'];  }
                }
                if ($user_main['honesty_level']=='2') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level2_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level2_2"] = $user_main['count'];  }
                }
                if ($user_main['honesty_level']=='3') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level3_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level3_2"] = $user_main['count'];  }
                }
                if ($user_main['honesty_level']=='4') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level4_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level4_2"] = $user_main['count'];  }
                }
                if ($user_main['honesty_level']=='5') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level5_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level5_2"] = $user_main['count'];  }
                }
                if ($user_main['honesty_level']=='6') {
                    if ($user_main['gender'] == '1') {  $total_rs[$i]["honesty_level6_1"] = $user_main['count'];  }
                    if ($user_main['gender'] == '2') {  $total_rs[$i]["honesty_level6_2"] = $user_main['count'];  }
                }
            }
            $total_rs[$i]["honesty_level1"] = $total_rs[$i]["honesty_level1_1"]+$total_rs[$i]["honesty_level1_2"];
            $total_rs[$i]["honesty_level2"] = $total_rs[$i]["honesty_level2_1"]+$total_rs[$i]["honesty_level2_2"];
            $total_rs[$i]["honesty_level3"] = $total_rs[$i]["honesty_level3_1"]+$total_rs[$i]["honesty_level3_2"];
            $total_rs[$i]["honesty_level4"] = $total_rs[$i]["honesty_level4_1"]+$total_rs[$i]["honesty_level4_2"];
            $total_rs[$i]["honesty_level5"] = $total_rs[$i]["honesty_level5_1"]+$total_rs[$i]["honesty_level5_2"];
            $total_rs[$i]["honesty_level6"] = $total_rs[$i]["honesty_level6_1"]+$total_rs[$i]["honesty_level6_2"];
            $total_rs[$i]["honesty_level"] = $total_rs[$i]["honesty_level1"]+ $total_rs[$i]["honesty_level2"]+ $total_rs[$i]["honesty_level3"]+ $total_rs[$i]["honesty_level4"]+ $total_rs[$i]["honesty_level5"]+ $total_rs[$i]["honesty_level6"];
         $i++;
        }
       // echo(json_encode($total_rs));
        $this->assign('total_rs', $total_rs);

        $this->display('admin/user_certify');
        // FResponse::output($total_rs);
    }


    /**
     * 根据时间获取所有照片和完善资料记录
     */
    public function detailAction(){
        $date = FRequest::getString("date");
        $item = FRequest::getString("item");


        $stm = date("Y-m-d 00:00:00",strtotime($date)); // 昨天凌晨
        $etm = date("Y-m-d 00:00:00",strtotime($date . "+1 day"));

        $str = " u.reg_time>='".$stm."' and u.reg_time < '".$etm."'";
       // echo $str;
        $ht_table = new FTable("honesty_record","h");
        $data = $ht_table->fields(array("DATE(h.tm) as t","count(*) as cnt ","u.gender as g"))
            ->leftJoin("user_main","u","h.uid = u.uid")->where(array("h.item"=>array("eq"=>$item),"str"=>$str))->groupBy("DATE(h.tm)","g")->select();


        $res = array();
        foreach($data as $d){
            $item = array("1"=>0,"2"=>0);
            if(array_key_exists($d["t"],$res)){
                $item = $res[$d["t"]];
            }
            $item[$d["g"]] = $d["cnt"];
            $res[$d["t"]] = $item;
        }

        $this->assign('date', $date);
        $this->assign('item', $item);
        $this->assign('data', $res);




        $this->display('admin/user_certify_detail');
    }

}