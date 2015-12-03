<?php

class Controller_Runreport extends FController {

        public function doReportAction() {
        global $_F;
            $_F["debug"]= true;
            $report_log = new FLogger("report_log");
            // 获取统计的日期
            $time_str = FRequest::getString('time');
            $report_log->append("～～～～～统计开始,时间:".$time_str);
            $b = time();

            Service_Edit::statistics();

            // $m = Service_Edit::getAllChargeSum("2015-01-01 00:00:00","2015-06-06 00:00:00");
            // $m = Service_Edit::getUserByTm("2015-01-01 00:00:00","2015-06-06 00:00:00");
            //echo(json_encode($m));
            $e = time();
            $report_log->append("～～～～～统计结束,时间:".$time_str."---- cost : ".($e-$b));
            echo("～～～～～统计结束,时间:".$time_str."---- cost : ".($e-$b));
    }

    public function doReportByHoursAction() {
        global $_F;
        $_F["debug"]= true;
        $report_log = new FLogger("report_log");
        // 获取统计的日期
        $time_str = FRequest::getString('time');
        $report_log->append("～～～～～统计开始,小时统计:".$time_str);
        $b = time();
        $etm = date("Y-m-d H:00:00");
        $stm = date("Y-m-d H:00:00",strtotime($etm . "-1 hours"));

        Service_Edit::statistics($stm,$etm);
        // $m = Service_Edit::getAllChargeSum("2015-01-01 00:00:00","2015-06-06 00:00:00");
        // $m = Service_Edit::getUserByTm("2015-01-01 00:00:00","2015-06-06 00:00:00");
        //echo(json_encode($m));
        $e = time();
        $report_log->append("～～～～～统计结束,小时统计:".$stm."".$etm."---- cost : ".($e-$b));
        echo("～～～～～统计结束,小时统计:".$stm."".$etm."---- cost :".($e-$b));
    }

    /**
     * 根据时间进行统计
     */
    public function doReportByTimeAction() {
        global $_F;
        $_F["debug"]= true;
        $report_log = new FLogger("report_log");
        // 获取统计的日期
        $time_str = FRequest::getString('time');
        $report_log->append("～～～～～统计开始 by time,时间:".$time_str);

        echo("～～～～～统计开始 by time,时间:".$time_str."<br>");

        $tm = date("Y-m-d 00:00:00",strtotime($time_str));
        echo($tm."<br>");
        $b = time();
        for($i=0;$i<24;$i++){
            $stm = date("Y-m-d H:00:00",strtotime($tm)+($i*3600));
            $etm = date("Y-m-d H:00:00",strtotime($tm)+(($i+1)*3600));
          //  echo($stm."----".$etm."<br>");
            Service_Edit::statistics($stm,$etm);
        }

        $e = time();
        $report_log->append("～～～～～统计结束,时间:".$time_str."---- cost : ".($e-$b));
        echo("～～～～～统计结束,时间:".$time_str."---- cost : ".($e-$b));
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


    public function testAction(){
        $time_str = date("Y-m-d");

        $stm = date('Y-m-d 00:00:00', strtotime($time_str));
        $etm = date('Y-m-d 00:00:00', strtotime($time_str)+86400);
        $stm = "2014-11-10 00:00:00";
        $etm = "2014-11-11 00:00:00";
       // $res = Service_Edit::getOldUserBid("web",$stm,$etm,Service_Edit::$REG_WEB);
      // $res = Service_Edit::getAllRemainCredit("web",Service_Edit::$REG_WEB);
      // $res = Service_Edit::getAllChangeChargeSum("web",$stm,$etm,Service_Edit::$REG_WEB);

       // $res= Service_Edit::getWinnerSum("web",$stm,$etm,Service_Edit::$REG_WEB);

       // $res = Service_Edit::getRetentionBySpm("web",$stm,Service_Edit::$REG_WEB,1);
      // $res= Service_Edit::getAllGoodsCast("web",$stm,$etm);
      // $res= Service_Edit::getRetentionBySpm("web",$stm,Service_Edit::$REG_WEB,1);
       $parms =  array("id"=>1,"uid"=>1000000);
        $res = FHttp::post("http://115.28.178.151:8083/s/plane/Invite",$parms);

        echo(json_encode($res));


    }

    /**
     * 进行临时统计
     */
    public function doTempReportAction(){
        $time_str = date("Y-m-d");
        $stm = date('Y-m-d 00:00:00', strtotime($time_str));
        $time = FRequest::getString("time");
        if(CommonUtil::parmIsEmpty($time)){
            $time = $stm;
        }
       // $time = "2014-11-15 00:00:00";
        $sql = "select count(*) as count from user where reg_time > '".$time."' ";   // 注册人数
        $sql2 = "select count(*) as count from user where reg_time > '".$time."' and cell_phone>0";  // 注册绑定
        $sql3 = "select count(*) as count from user where reg_time > '".$time."' and cell_phone>0 and common_status = 1 "; // 注帮领
        $sql4 = "select count(*) as count from user where reg_time > '".$time."' and cell_phone>0 and common_status = 1 and rename_reward = 2 ";
        $sql5 = "select count(*) as count from user where reg_time > '".$time."' and cell_phone>0 and common_status = 1 and addpic_reward = 2 ";
        $sql6 = "select count(distinct uid) as count from bid where uid in (select uid from user where reg_time>'".$time." and cell_phone>0 and common_status = 1') "; // 领出价
        $sql7 = "select count(*) as count from user where reg_time > '".$time."' and addpic_reward = 2 ";
        $sql8 = "select count(*) as count from user where reg_time > '".$time."' and rename_reward = 2 ";
        $sql9 = "select count(distinct uid) as count from bid where uid in (select uid from user where reg_time>'".$time."') "; // 领出价

        $reg_data = FDB::fetch($sql);
        $reg_bind_data = FDB::fetch($sql2);
        $reg_bind_ling = FDB::fetch($sql3);
        $reg_b_l_rename = FDB::fetch($sql4);
        $reg_b_l_addpic = FDB::fetch($sql5);
        $reg_b_l_bid = FDB::fetch($sql6);
        $reg_rename = FDB::fetch($sql7);
        $reg_addpic = FDB::fetch($sql8);
        $reg_bid = FDB::fetch($sql9);

        $reg_b_l_name_num = $reg_b_l_rename[0]["count"] ;
        $reg_b_l_num = $reg_bind_ling[0]["count"];
        $reg_b_l_pic_num = $reg_b_l_addpic[0]["count"];
        $reg_b_l_bid_num = $reg_b_l_bid[0]["count"];


        echo("注册人数 :".$reg_data[0]["count"]." <br>");
        echo("注册绑定人数 :".$reg_bind_data[0]["count"]."  <br>");
        echo("注册绑定领取礼包人数 :".$reg_b_l_num."  <br>");
        echo("注改昵称 :".$reg_rename[0]["count"]."  <br>");
        echo("注该头像 :".$reg_addpic[0]["count"]."  <br>");
        echo("注册出价 :".$reg_bid[0]["count"]."  <br>");
        echo("注绑领改昵称 :".$reg_b_l_name_num."  -----  ".sprintf("%.2f", ($reg_b_l_name_num*100/$reg_b_l_num))."%  <br>");
        echo("注绑领改头像 :".$reg_b_l_pic_num."  -----  ".sprintf("%.2f", ($reg_b_l_pic_num*100/$reg_b_l_num))."%  <br>");
        echo("注绑领出价 :".$reg_b_l_bid[0]["count"]."  -----  ".sprintf("%.2f", ($reg_b_l_bid_num*100/$reg_b_l_num))."%  <br>");

    }

}