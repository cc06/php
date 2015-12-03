<?php

class Controller_Admin_ReportLiucun extends Controller_Admin_Abstract {

    function defaultAction(){
        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $table = new FTable("user_province_area");
        $user_province = $table ->groupBy("province")  ->order(array("id"=>"asc"))->select();

        $this->assign('user_province', $user_province);

        $this->assign('spmList', $c_names);
        $this->display('admin/stats_liucun');
    }
    /**
     * 主报表查询
     */
    public function reportAction(){
        //global $_F;
        //$_F["debug"] = true;
        $page_size = 30;
        $page = max(1, FRequest::getInt('page'));
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $user_gender =  CommonUtil::getComParam(FRequest::getInt('user_gender'),-1);
        $stats_date = FRequest::getString('stats_date');
        $stats_key = FRequest::getString('stats_key');
        $province = FRequest::getString('province');
        $ver = FRequest::getString('ver');


        $table = new FTable("user_province_area");
        $user_province = $table ->groupBy("province")  ->order(array("id"=>"asc"))->select();

        $this->assign('user_province', $user_province);
        $this->assign('province', $province);
        $this->assign('ver', $ver);
        if (!$stats_key) {
            $stats_key="online_award_users";
            // $stats_key="on_top_users";
//            $this->showMessage("查询留存不能为空",error,"/admin/ReportLiucun/default");
//
//        return;
//            exit;
        }
        $where = array(
            "s.interval"=>"day"
        );
        if ($c_uid !="" ) {
            $where["channel"] = $c_uid;
        }
        if ($user_gender>=0) {
             $where["gender"] = $user_gender;
        }
        if ($province) {
            $where["province"] = $province;
        }
        if ($ver) {
            $where["ver"] = $ver;
        }
        $stats_key0=$stats_key."_lc_0";
        $stats_key1=$stats_key."_lc_1";
        $stats_key2=$stats_key."_lc_2";
        $stats_key3=$stats_key."_lc_3";
        $stats_key4=$stats_key."_lc_4";
        $stats_key5=$stats_key."_lc_5";
        $stats_key6=$stats_key."_lc_6";
        $stats_key7=$stats_key."_lc_7";
        $stats_key15=$stats_key."_lc_15";
        $stats_key30=$stats_key."_lc_30";
        $stats_key_array = array(
            "'register'",
            "'".$stats_key0."'",
            "'".$stats_key1."'",
            "'".$stats_key2."'",
            "'".$stats_key3."'",
            "'".$stats_key4."'",
            "'".$stats_key5."'",
            "'".$stats_key6."'",
            "'".$stats_key7."'",
            "'".$stats_key15."'",
            "'".$stats_key30."'"
        );
        $fields = array(
            "s.tm",
            "s.key",
            "sum(s.value) as sum"
        );
        //echo(json_encode($stats_key_array));
        $where["s.key"] = array('in'=> $stats_key_array);

        $datetime_riqi_qiantian=date("Y-m-d", time()-86400);

        $query_str= " s.tm <= '".$datetime_riqi_qiantian." 00:00:00'  ";
            $where["str"] = $query_str;

        $table2 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $total_rs = $table2->fields($fields)
            ->where($where)->groupBy("s.tm")->order(array("s.tm"=>"desc"))->select();

        //echo(json_encode($where));
        $total = count($total_rs);
        $jieshu_time=$total_rs[$page_size*$page-$page_size][tm];
        if ($page_size*$page>$total) {
            $kaishi_time=$total_rs[$total-1][tm];
        } else {
            $kaishi_time=$total_rs[$page_size*$page-1][tm];
        }


        //echo($kaishi_time.$jieshu_time);
        if ($total>0) {
            $query_str= " s.tm >= '".$kaishi_time."' and  s.tm <= '".$jieshu_time."'   ";
            $where["str"] = $query_str;
        }

        $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $Stat = $table->fields($fields)
            ->where($where)->groupBy("s.tm,s.key")
            ->order(array("s.tm"=>"desc"))->select();

        $Stats=array();
        foreach($Stat as &$s){
            $sub_arr = array();
            $s["tm"] = substr($s["tm"],0,10);
            if (array_key_exists($s["tm"], $Stats)) {
                $sub_arr = $Stats[$s["tm"]];
            }
            array_push($sub_arr,$s);
            $Stats[$s["tm"]] = $sub_arr;
//            $where["s.tm"] = $s["tm"];
//            $where["s.key"] = "register";
//            $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data = $table->fields(array("sum(s.value) as sum" )) ->where($where)->find();
//            $s["register"] = $data["sum"];
//
//
//            if ($stats_key) { $where["s.key"] = $stats_key1;  }
//         $table1 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data1 = $table1->fields(array("sum(s.value) as sum" )) ->where($where)->find();
//            $s["stats_key1"] = $data1["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key2;  }
//            $table2 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data2 = $table2->fields(array("sum(s.value) as sum" )) ->where($where)->find();
//            $s["stats_key2"] = $data2["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key3;  }
//            $table3 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data3 = $table3->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key3"] = $data3["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key4;  }
//            $table4 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data4 = $table4->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key4"] = $data4["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key5;  }
//            $table5 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data5 = $table5->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key5"] = $data5["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key6;  }
//            $table6 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data6 = $table6->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key6"] = $data6["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key7;  }
//            $table7 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data7 = $table7->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key7"] = $data7["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key15;  }
//            $table15 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data15 = $table15->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key15"] = $data15["sum"];
//            if ($stats_key) { $where["s.key"] = $stats_key30;  }
//            $table30 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
//            $data30 = $table30->fields(array("sum(s.value) as sum")) ->where($where)->find();
//            $s["stats_key30"] = $data30["sum"];

            //$s["stats_date"] = substr($s["tm"],0,10);
        }
        /*print_r($Stats);*/

        $Stats2=array();
        foreach($Stats as &$s){
            $sub_arr = array(
                "tm"=>"",
                "register"=>0,
                $stats_key0=>0,
                $stats_key1=>0,
                $stats_key2=>0,
                $stats_key3=>0,
                $stats_key4=>0,
                $stats_key5=>0,
                $stats_key6=>0,
                $stats_key7=>0,
                $stats_key15=>0,
                $stats_key30=>0
            );
            foreach($s as &$s_x){
                $sub_arr["tm"]=$s_x["tm"];
                if ($s_x["key"]=="register") { $sub_arr["register"]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key0) { $sub_arr[$stats_key0]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key1) { $sub_arr[$stats_key1]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key2) { $sub_arr[$stats_key2]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key3) { $sub_arr[$stats_key3]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key4) { $sub_arr[$stats_key4]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key5) { $sub_arr[$stats_key5]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key6) { $sub_arr[$stats_key6]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key7) { $sub_arr[$stats_key7]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key15) { $sub_arr[$stats_key15]=$s_x["sum"]; }
                if ($s_x["key"]==$stats_key30) { $sub_arr[$stats_key30]=$s_x["sum"]; }
            }
            array_push($Stats2,$sub_arr);
        }
        //echo(json_encode($Stats2));
       // $total = count($Stats);
        $page_info =  FPager::getPagerInfo($total, $page, $page_size);

        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign('page_info', $page_info);

        $this->assign('Stat', $Stats2);
        $this->assign('stats_key', $stats_key);

        $this->assign('sc_uid', $c_uid);
        $this->assign('user_gender', $user_gender);
        $this->assign('stats_date', $stats_date);

        $this->assign('stats_key0', $stats_key0);
        $this->assign('stats_key1', $stats_key1);
        $this->assign('stats_key2', $stats_key2);
        $this->assign('stats_key3', $stats_key3);
        $this->assign('stats_key4', $stats_key4);
        $this->assign('stats_key5', $stats_key5);
        $this->assign('stats_key6', $stats_key6);
        $this->assign('stats_key7', $stats_key7);
        $this->assign('stats_key15', $stats_key15);
        $this->assign('stats_key30', $stats_key30);


        $this->display('admin/stats_liucun');
    }


}