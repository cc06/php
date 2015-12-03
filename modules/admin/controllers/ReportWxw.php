<?php

class Controller_Admin_ReportWxw extends Controller_Admin_Abstract {
    /**
     * 主报表查询
     */
    public function reportAction(){
        //global $_F;
        //$_F["debug"] = true;
        $page_size = 7;
        $page = max(1, FRequest::getInt('page'));
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);
        $user_xinlao =  CommonUtil::getComParam(FRequest::getInt('user_xinlao'),-1);

        $stats_date = FRequest::getString('stats_date');

        $where = array(
            "s.interval"=>"day"
        );
        if ($c_uid !="" ) {
            $where["channel"] = $c_uid;
        }
        if ($c_sid !="") {
            $where["sub_channel"] = $c_sid;
        }
        if ($user_type>=0) {
           // $where["user_type"] = $user_type;
        }
        if ($stats_date&&$stats_date!=""){
            $where["tm"] = $stats_date." 00:00:00";
        }
        $table1 = new FTable("Config","c",FDB::$DB_MUMU_STAT);
        $Config = $table1  ->order(array("c.action"=>"asc"))->select();

        foreach($Config as &$c){
            $c["id_0"] = $c["id"]."_0";
            $c["id_1"] = $c["id"]."_1";
            $c["id_2"] = $c["id"]."_2";
        }
        $fields = array(
            "s.tm",
            "s.key",
            "s.gender",
            "sum(s.value) as sum"
        );

        $table2 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $total_rs = $table2->fields($fields)->where($where)->groupBy("s.tm")->order(array("s.tm"=>"desc"))->select();
        $total = count($total_rs);
        $jieshu_time=$total_rs[$page_size*($page-1)][tm];
        if ($page_size*$page>$total) {
            $kaishi_time=$total_rs[$total-1][tm];
        } else {
            $kaishi_time=$total_rs[$page_size*$page-1][tm];
        }

       // echo($kaishi_time.$jieshu_time);
        if ($total>0) {
            $query_str= " s.tm >= '".$kaishi_time."' and  s.tm <= '".$jieshu_time."'   ";
            $where["str"] = $query_str;
        }



        $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $Stat = $table->fields($fields)
            ->where($where)->groupBy("s.tm,s.key,s.gender")
            ->order(array("s.tm"=>"desc"))->select();
        $Stats=array();
        foreach($Stat as &$s) {
            $sub_arr = array();
            $s["tm"] = substr($s["tm"], 0, 10);
            if (array_key_exists($s["tm"], $Stats)) {
                $sub_arr = $Stats[$s["tm"]];
            }
            array_push($sub_arr, $s);
            $Stats[$s["tm"]] = $sub_arr;
        }
       // echo(json_encode($Stats));
        $Stats2=array();
        foreach($Stats as &$s){
            $sub_arr = array(
                "tm"=>""
            );

            foreach($s as &$s_x){
                $sub_arr["tm"]=$s_x["tm"];
                $stats_key = $s_x["key"]."_".$s_x["gender"];

                $sub_arr[$stats_key]=$s_x["sum"];

                }
                 foreach($Config as &$c) {
                        if ($c["id"]=="follow_users") {
                            $sub_arr[$c["id"] . "_0"] = $sub_arr[$c["id"] . "_lc_0_0"];
                            $sub_arr[$c["id"] . "_1"] = $sub_arr[$c["id"] . "_lc_0_1"];
                            $sub_arr[$c["id"] . "_2"] = $sub_arr[$c["id"] . "_lc_0_2"];
                        } else {
                            $sub_arr[$c["id"] . "_0"] = $sub_arr[$c["id"] . "_0"];
                            $sub_arr[$c["id"] . "_1"] = $sub_arr[$c["id"] . "_1"];
                            $sub_arr[$c["id"] . "_2"] = $sub_arr[$c["id"] . "_2"];
                        }
                    }

            array_push($Stats2,$sub_arr);
        }


        $page_info =  FPager::getPagerInfo($total, $page, $page_size);

        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign('page_info', $page_info);
        $this->assign('Stat', $Stats2);
        $this->assign('Config', $Config);
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('user_type', $user_type);
        $this->assign('stats_date', $stats_date);

        $this->display('admin/stats_wxw');
    }


    /**
     * 按小时查询详情
     * @throws Exception
     */
    public function hoursDetailAction(){
        //global $_F;
        //$_F["debug"] = true;

        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);
        $stats_date = FRequest::getString('stats_date');

        $where = array(
            "s.interval"=>"hour"
        );
        if ($c_uid !="" ) {
            $where["channel"] = $c_uid;
        }
        if ($c_sid !="") {
            $where["sub_channel"] = $c_sid;
        }
        if ($user_type>=0) {
            // $where["user_type"] = $user_type;
        }
        if ($stats_date&&$stats_date!=""){
            $where["tm"] = array('like'=> $stats_date);
        }
        $table1 = new FTable("Config","c",FDB::$DB_MUMU_STAT);
        $Config = $table1  ->order(array("c.id"=>"asc"))->select();
        foreach($Config as &$c){
            $c["id_1"] = $c["id"]."_1";
            $c["id_2"] = $c["id"]."_2";
        }
        $fields = array(
            "s.tm",
            "s.key",
            "s.gender",
            "sum(s.value) as sum"
        );



        $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $Stat = $table->fields($fields)
            ->where($where)->groupBy("s.tm,s.key,s.gender")
            ->order(array("s.tm"=>"asc"))->select();
        $Stats=array();
        foreach($Stat as &$s) {
            $sub_arr = array();

            if (array_key_exists($s["tm"], $Stats)) {
                $sub_arr = $Stats[$s["tm"]];
            }
            array_push($sub_arr, $s);
            $Stats[$s["tm"]] = $sub_arr;
        }
        $Stats2=array();
        foreach($Stats as &$s){
            $sub_arr = array(
                "tm"=>""
            );

            foreach($s as &$s_x){
                $sub_arr["tm"]=$s_x["tm"];
                $stats_key = $s_x["key"]."_".$s_x["gender"];
                foreach($Config as &$c){
                    if ($s_x["key"]==$c["id"]) { $sub_arr[$stats_key]=$s_x["sum"]; }
                }

            }
            array_push($Stats2,$sub_arr);
        }


        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign('Stat', $Stats2);
        $this->assign('Config', $Config);
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('user_type', $user_type);
        $this->assign('stats_date', $stats_date);


        $this->display('admin/stats_wxw_hours_detail');
      //  echo(json_encode($logList));
    }


    /**
     * 按省查询人数
     */
    public function provinceAction(){
        //global $_F;
        //$_F["debug"] = true;

        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);
        $stats_date = FRequest::getString('stats_date');
        $sc_config = FRequest::getString('sc_config');

        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('sc_config', $sc_config);
        $this->assign('sc_config_1', $sc_config."_1");
        $this->assign('sc_config_2', $sc_config."_2");

        $where = array(
            "s.interval"=>"day"
        );
        if ($c_uid !="" ) {
            $where["channel"] = $c_uid;
        }
        if ($c_sid !="") {
            $where["sub_channel"] = $c_sid;
        }
        if ($sc_config !="") {
        $where["s.key"] = $sc_config;
        }
        if ($user_type>=0) {
            // $where["user_type"] = $user_type;
        }
        if ($stats_date&&$stats_date!=""){
            $where["tm"] =  $stats_date;
        }
        $table1 = new FTable("Config","c",FDB::$DB_MUMU_STAT);
        $Config = $table1  ->order(array("c.id"=>"asc"))->select();
        foreach($Config as &$c){
            $c["id_1"] = $c["id"]."_1";
            $c["id_2"] = $c["id"]."_2";
        }
        $fields = array(
            "s.tm",
            "s.key",
            "s.province",
            "s.gender",
            "sum(s.value) as sum"
        );


        $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $Stat = $table->fields($fields)
            ->where($where)->groupBy("s.province,s.gender")
            ->order(array("sum"=>"desc"))->select();

        $Stats=array();
        foreach($Stat as &$s) {
            $sub_arr = array();

            if (array_key_exists($s["province"], $Stats)) {
                $sub_arr = $Stats[$s["province"]];
            }
            array_push($sub_arr, $s);
            $Stats[$s["province"]] = $sub_arr;
        }
        $Stats2=array();
        foreach($Stats as &$s){
            $sub_arr = array();

            foreach($s as &$s_x){
                $sub_arr["province"]=$s_x["province"];
                $stats_key = $s_x["key"]."_".$s_x["gender"];
                 $sub_arr[$stats_key]=$s_x["sum"];


            }
            array_push($Stats2,$sub_arr);
        }
        //echo(json_encode($Stats2));
        /*foreach($Stat as &$s){
            $where["province"] = $s["province"];

            $table2 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
            $datas = $table2->fields(array(
                "s.key",
                "s.gender",
                "sum(s.value) as sum"
            )) ->where($where)->groupBy("s.gender")->select();
            foreach($datas as &$data) {
                $s[$data["key"]."_".$data["gender"]] = $data["sum"];
            }

        }*/



        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign('Stat', $Stats2);
        $this->assign('Config', $Config);

        $this->assign('user_type', $user_type);
        $this->assign('stats_date', $stats_date);


        $this->display('admin/stats_wxw_province_detail');
        //  echo(json_encode($logList));
    }
    /**
     * 按时间地区在线人数
     */
    public function zaixianAction(){
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $stats_date = FRequest::getString('stats_date');
        $province = FRequest::getString('province');
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);

        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('stats_date', $stats_date);
        $this->assign('province', $province);
        $this->assign('user_type', $user_type);

        $table = new FTable("user_province_area");
        $user_province = $table ->groupBy("province")  ->order(array("id"=>"asc"))->select();

        $this->assign('user_province', $user_province);

        $data=array();
        $data_1=array();
        $data_2=array();

        $where = array(
            "s.key"=>"on_top_users"
        );

        if ($c_uid !="" ) {
            $where["channel"] = $c_uid;
        }
        if ($c_sid !="") {
            $where["sub_channel"] = $c_sid;
        }
        if ($province) {
            $where["province"] = $province;
        }
        if ($user_type>=0) {
            // $where["user_type"] = $user_type;
        }
        if ($stats_date&&$stats_date!=""){
            $where["tm"] = array('like'=> $stats_date);
            $where["s.interval"] = "hour";
        } else {
            $where["s.interval"] = "day";
        }

        $fields = array(
            "s.tm",
            "s.key",
            "s.gender",
            "sum(s.value) as sum"
        );

        $table2 = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $total_rs = $table2->fields($fields)->where($where)->groupBy("s.tm")->order(array("s.tm"=>"desc"))->select();
        $total = count($total_rs);
        $kaishi_time=$total_rs[30][tm];
        $jieshu_time=$total_rs[0][tm];
       /* if ($total>30) {
            $jieshu_time=$total_rs[29][tm];
        } else {
            $jieshu_time=$total_rs[$total-1][tm];
        }*/


        // echo($kaishi_time.$jieshu_time);
        if ($total>0) {
            $query_str= " s.tm >= '".$kaishi_time."' and  s.tm <= '".$jieshu_time."'   ";
            $where["str"] = $query_str;
        }



        $table = new FTable("Stat","s",FDB::$DB_MUMU_STAT);
        $Stat = $table->fields($fields)
            ->where($where)->groupBy("s.tm,s.key,s.gender")
            ->order(array("s.tm"=>"desc"))->select();
        $Stats=array();
        foreach($Stat as &$s) {
            $sub_arr = array();
            $s["tm"] =$s["tm"];
            if (array_key_exists($s["tm"], $Stats)) {
                $sub_arr = $Stats[$s["tm"]];
            }
            array_push($sub_arr, $s);
            $Stats[$s["tm"]] = $sub_arr;
        }
        $Stats2=array();
        foreach($Stats as &$s){
            $sub_arr = array(
                "tm"=>""
            );

            foreach($s as &$s_x){
                $sub_arr["tm"]=$s_x["tm"];
                $stats_key = $s_x["key"]."_".$s_x["gender"];
                $sub_arr[$stats_key]=$s_x["sum"];
            }
            $data[$sub_arr["tm"]]=$sub_arr["tm"];
            if ($sub_arr["on_top_users_1"]) {
                $data_1[$sub_arr["tm"]]=$sub_arr["on_top_users_1"];
            } else {
                $data_1[$sub_arr["tm"]]=0;
            }
            if ($sub_arr["on_top_users_2"]) {
                $data_2[$sub_arr["tm"]]=$sub_arr["on_top_users_2"];
            } else {
                $data_2[$sub_arr["tm"]]=0;
            }

            array_push($Stats2,$sub_arr);
        }
        $data1=array();
        $i=0;
        foreach($data as $d){
            if ($stats_date&&$stats_date!="") {
                $data1[$i] = substr(substr($d,0,13),-2);
            } else {
                $data1[$i] = substr($d,0,10);
            }
            $i++;
        }
        $data1_1=array();
        $i=0;
        foreach($data_1 as $d){
            $data1_1[$i]=$d;
            $i++;
        }
        $data1_2=array();
        $i=0;
        foreach($data_2 as $d){
            $data1_2[$i]=$d;
            $i++;
        }

        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign("data_1",json_encode(array_reverse($data1_1)));
        $this->assign("data_2",json_encode(array_reverse($data1_2)));
        $this->assign("data",json_encode(array_reverse($data1)));
        $this->display('admin/user_spread_zaixian');
    }

//wxw

}