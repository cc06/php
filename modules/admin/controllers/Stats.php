<?php

class Controller_Stats extends FController {

    public function cntAction() {
        global $_F;
        $tm = date("Y-m-d");
        $c_uid = FRequest::getString('c_uid');
        $c_sid = FRequest::getString('c_sid');
        if($c_uid == "" || $c_sid=="" ){
            $rs = array("msg"=>"参数错误,必选参数c_uid,c_sid","code"=>201);
            FResponse::output($rs);
            return;
        }
        $fields = array(
            "stats_date",
            "c_uid",
            "c_sid",
            "sum(reg_cnt) as reg_cnt"
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
        $where["stats_date"] = $tm;
        $logList  = $stats_table->where($where)->select();
        $empty = array("stats_date"=>$tm,"c_uid"=>$c_uid,"c_sid"=>$c_sid,"reg_cnt"=>0);
        if(count($logList)>0){
            FResponse::output($logList[0]);
            return;
        }
        FResponse::output($empty);
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
}