<?php

class Controller_Admin_Report extends Controller_Admin_Abstract {
    /**
     * 主报表查询
     */
    public function reportAction(){
        global $_F;
        //$_F["debug"] = true;
        $page_size = 14;
        $page = max(1, FRequest::getInt('page'));
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);
        $stats_date = FRequest::getString('stats_date');
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('user_type', $user_type);
        $this->assign('stats_date', $stats_date);
        $fields = array(
            "stats_date",
            "hours",
            "c_uid",
            "c_sid",
            "user_type",
            "sum(reg_cnt) as reg_cnt",
            "sum(charge_user_cnt) as charge_user_cnt",
            "sum(charge_sum) as charge_sum",
            "sum(gived_sum) as gived_sum"
        );
        $stats_table = new FTable("stats");
        $stats_table->fields($fields);
        $where = array();
        if ($c_uid !="" ) {
            $where["c_uid"] = $c_uid;
        }
        if ($c_sid !="") {
            $where["c_sid"] = $c_sid;
        }
        if ($user_type>=0) {
            $where["user_type"] = $user_type;
        }
        if ($stats_date&&$stats_date!=""){
            $where["stats_date"] = $stats_date;
        }
        $logList  = $stats_table->where($where)->groupBy("stats_date")
            ->order(array("stats_date"=>"desc","reg_cnt"=>"desc"))->page($page)->limit($page_size)->select();

        foreach($logList as &$item){
            $item["charge_sum"] = $item["charge_sum"]/100;
        }

        $stats_table2 = new FTable("stats");
        $total_rs = $stats_table2->fields(array("stats_date"))->where($where)->groupBy("stats_date")->select();

        $total = count($total_rs);

        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign('logList', $logList);
        $this->assign('page_info', FPager::getPagerInfo($total, $page, $page_size));
        $this->display('admin/stats');
    }

    /**
     * 按小时查询详情
     * @throws Exception
     */
    public function hoursDetailAction(){
        global $_F;
        $page_size = 24;
        //$flag == 1 获取时间段相主渠道数据， flag ==2 获取时间段某子渠道时间段数据
        $flag = FRequest::getInt('flag');
        $page = max(1, FRequest::getInt('page'));

        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $user_type =  CommonUtil::getComParam(FRequest::getInt('user_type'),-1);
        $stats_date = FRequest::getString('stats_date');
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('user_type', $user_type);
        $this->assign('stats_date', $stats_date);

        $this->assign('flag', $flag);

        $fields = array(
            "stats_date",
            "hours",
            "c_uid",
            "c_sid",
            "user_type",
            "sum(reg_cnt) as reg_cnt",
            "sum(charge_user_cnt) as charge_user_cnt",
            "sum(charge_sum) as charge_sum",
            "sum(gived_sum) as gived_sum"
        );
        $stats_table = new FTable("stats");
        $stats_table->fields($fields);
        $where = array();
        if ($c_uid !="") {
            $where["c_uid"] = $c_uid;
        }
        if ($c_sid!="") {
            $where["c_sid"] = $c_sid;
        }
        if ($stats_date&&$stats_date!=""){
            $where["stats_date"] = $stats_date;
        }
        if ($user_type>=0) {
            $where["user_type"] = $user_type;
        }
        $group_by = "stats_date,hours";
        if($flag==2){
            $group_by = "stats_date,hours";
        }
        $logList  = $stats_table->where($where)->groupBy($group_by)->order(array("hours"=>"asc"))
            ->page($page)->limit($page_size)->select();

        $stats_table2 = new FTable("stats");
        $total_rs = $stats_table2->fields(array("id"))->where($where)->groupBy($group_by)->select();

        $total = count($total_rs);

        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmList', $spmList);

        $c_name = Service_Edit::getSpmMap($spmList);
        $c_s_name = Service_Edit::getSubSpmMap($spmList);

        $this->assign('spmarr', json_encode($spmList));
        $this->assign('spmList', $c_name);

        foreach($logList as &$item){
            $item["c_name"] = "";
            if(array_key_exists($item["c_uid"],$c_name)){
                $item["c_name"] = $c_name[$item["c_uid"]];
            }
            $item["c_s_name"] = "";
            if(array_key_exists($item["c_sid"],$c_s_name)){
                $item["c_s_name"] = $c_s_name[$item["c_sid"]];
            }
            $item["charge_sum"] = $item["charge_sum"]/100;
        }

        $this->assign('logList', $logList);
        $this->assign('page_info', FPager::getPagerInfo($total, $page, $page_size));
        $this->display('admin/stats_hours_detail');
      //  echo(json_encode($logList));
    }

    /**
     * 用户地区分部或者年龄分部
     */
    public function spreadAction(){
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $stats_date = FRequest::getString('stats_date');
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('stats_date', $stats_date);

        $where = array("um.uid"=>array("gt"=>5000000));
        if($c_uid!=""){
            $where["um.channel_uid"] = $c_uid;
        }
        if($c_sid!=""){
            $where["um.channel_sid"] = $c_sid;
        }
        if($stats_date){
            $stm = date("Y-m-d 00:00:00",strtotime($stats_date)); // 昨天凌晨
            $etm = date("Y-m-d 00:00:00",strtotime($stats_date . "+1 day"));
            $where["str"] = " um.reg_time > '".$stm."' and um.reg_time < '".$etm."'";
        }
        // 查询用户省份数据
        $user_table = new FTable("user_main","um");
        $data = $user_table->fields(array("ud.province","um.gender","count(*) as num"))->leftJoin("user_detail","ud","um.uid = ud.uid")->groupBy("ud.province,um.gender")->where($where)->select();

        $user_table2 = new FTable("user_main","um");
        $province_arr = $user_table2->fields(array("ud.province","count(*) as num"))->leftJoin("user_detail","ud","um.uid = ud.uid")->groupBy("ud.province")->where($where)->order(array("num"=>"desc"))->limit(35)->select();

        $p_arr = array();
        foreach($province_arr as $p){
            $province = $p["province"];
            if(!$province||empty($province)){
                $province = "default";
            }
            array_push($p_arr,$province);
        }

       // echo(json_encode($data));
        $rs = array("default"=>array("1"=>0,"2"=>0));
        foreach($data as $d){
            $rm = array("1"=>0,"2"=>0);
            $province = $d["province"];
            if(!$province||empty($province)){
                $province = "default";
            }
            $gender = $d["gender"];

            if(array_key_exists($province,$rs)){
                $rm = $rs[$province];
            }
            $rm[$gender] += $d["num"];
            $rs[$province] = $rm;
        }
        $data_1 = array();
        $data_2 = array();
        foreach($p_arr as $p){
            $d =  $rs[$p];
            $d_1 = 0;
            $d_2 = 0;
            if($d&&$d["1"]){
                $d_1 = $d["1"];
            }
            if($d&&$d["2"]){
                $d_2 = $d["2"];
            }
            $data_1[count($data_1)]= $d_1;
            $data_2[count($data_2)]= $d_2;
        }
        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign("data_1",json_encode($data_1));
        $this->assign("data_2",json_encode($data_2));
        $this->assign("province",json_encode($p_arr));
        $this->display('admin/user_spread');
    }

    /**
     * 用户地区分部或者年龄分部
     */
    public function ageSpreadAction(){
        $c_uid = CommonUtil::getDefStr(FRequest::getString('c_uid'),"");
        $c_sid = CommonUtil::getDefStr(FRequest::getString('c_sid'),"");
        $stats_date = FRequest::getString('stats_date');
        $this->assign('sc_uid', $c_uid);
        $this->assign('sc_sid', $c_sid);
        $this->assign('stats_date', $stats_date);

        $where = array("um.uid"=>array("gt"=>5000000));
        if($c_uid!=""){
            $where["um.channel_uid"] = $c_uid;
        }
        if($c_sid!=""){
            $where["um.channel_sid"] = $c_sid;
        }
        if($stats_date){
            $stm = date("Y-m-d 00:00:00",strtotime($stats_date)); // 昨天凌晨
            $etm = date("Y-m-d 00:00:00",strtotime($stats_date . "+1 day"));
            $where["str"] = " um.reg_time > '".$stm."' and um.reg_time < '".$etm."'";
        }
        // 查询用户省份数据
        $user_table = new FTable("user_main","um");
        $data = $user_table->fields(array("(YEAR(curdate())-YEAR(ud.birthday)) as age","um.gender","count(*) as num"))->leftJoin("user_detail","ud","um.uid = ud.uid")->groupBy("um.gender,YEAR(ud.birthday)")->where($where)->select();
        // echo(json_encode($data));

        $user_table2 = new FTable("user_main","um");
        $data2 = $user_table2->fields(array("(YEAR(curdate())-YEAR(ud.birthday)) as age","count(*) as num"))->leftJoin("user_detail","ud","um.uid = ud.uid")->groupBy("YEAR(ud.birthday)")->where($where)->order(array("num"=>"desc"))->limit(30)->select();

        $rs = array("default"=>array("1"=>0,"2"=>0));
        $p_arr = array();

        foreach($data2 as $ages){
            $age = $ages["age"];
            if(!$age||empty($age)){
                $age = "缺省";
            }
            array_push($p_arr,$age);
        }

        foreach($data as $d){
            $rm = array("1"=>0,"2"=>0);
            $age = $d["age"];
            if(!$age||empty($age)){
                $age = "缺省";
            }
            $gender = $d["gender"];

            if(array_key_exists($age,$rs)){
                $rm = $rs[$age];
            }
            $rm[$gender] += $d["num"];
            $rs[$age] = $rm;
        }
        $data_1 = array();
        $data_2 = array();
        foreach($p_arr as $p){
            $d =  $rs[$p];
            $d_1 = 0;
            $d_2 = 0;
            if($d&&$d["1"]){
                $d_1 = $d["1"];
            }
            if($d&&$d["2"]){
                $d_2 = $d["2"];
            }
            $data_1[count($data_1)]= $d_1;
            $data_2[count($data_2)]= $d_2;
        }
        $spmList = Service_Edit::getAllSpm();
        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);

        $this->assign('spmList', $c_names);

        $this->assign("data_1",json_encode($data_1));
        $this->assign("data_2",json_encode($data_2));
        $this->assign("ages",json_encode($p_arr));
        $this->display('admin/user_age_spread');
    }


      public function testAction(){
          global $_F;
          $_F["debug"] = true;
         //  $parms =  array("id"=>1,"uid"=>1000005);
          //$res = FHttp::post("http://yfservice.admin.docker:8081/s/discovery/Adjacent",$parms);
       //   $res =  FHttp::Post("http://yfservice.admin.docker:8081/s/discovery/Adjacent");
        //  $res = FHttp::post("http://service.mumu123.cn/s/discovery/Adjacent",$parms);
         // $this->display('admin/stats_cuid_detail');
        // $rs= Service_Edit::getAllChargeSum("2015-06-25 00:00:00","2015-06-26 00:00:00");
        //  echo(json_encode($rs));

        //   $res = FHttp::get("http://yfservice.admin.docker:8081/s/discovery/IAdjacent");
          // $res = FHttp::get("http://service.mumu123.cn/s/discovery/Adjacent");
         //$res = Service_Common::getAllSpm();
        //  $user_id = Service_Edit::addUser();
       //   echo(json_encode($res));
       /*  echo FSession::get('manager_uid');
         echo FSession::get('user_id');
         echo FSession::get('sid');*/
          //$url = FConfig::get('global.service_mumu_url');

         /* $stat_table = new FTable("Config","c",FDB::$DB_MUMU_STAT);
          $res = $stat_table->select();
          echo(json_encode($res));*/

         /* $stat_table = new FTable("message","c",FDB::$DB_MUMU_MESSAGE);
          $res = $stat_table->where(array("c.from"=>5000762))->limit(10)->select();
          echo(json_encode($res));*/

          $arr = array("name"=>"我恩家具","url"=>"http://a.mumu123.cn/admin/report/test");

            echo(json_encode($arr));




        //  echo("age: ".CommonUtil::birthdayToAge("1991-08-26 00:00:00"));
      }

}