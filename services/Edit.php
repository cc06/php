<?php

/**
 * 用于编辑后台使用的service释放
 * User: cf
 * Date: 14-10-17
 * Time: 22:13
 */
class Service_Edit {
    public static   $REG_QQ = "qq";
    public static   $REG_WB = "wb";
    public static   $REG_WEB = "web";
    public static   $REG_APP = "app";

    public static   $USER_TYPE = array(
            array("user_type"=>0,"type_name"=>"其他"),
            array("user_type"=>1,"type_name"=>"web"),
            array("user_type"=>2,"type_name"=>"android"),
            array("user_type"=>3,"type_name"=>"ios"),
    );


    /**
     * 获取所有渠道
     *
     * @return array
     */
    public static function getAllSpm(){
        //$spmT = new FTable('spm');
        //$spmList = $spmT->select();
        $spmList = Service_Common::getAllSpm();
        $item = array("c_uid"=>"2","c_sid"=>"888","c_name"=>"缺省","c_s_name"=>"缺省");
        array_push($spmList,$item);
        return $spmList;
    }

    /**
     * 获取渠道map对象
     */
    public static function getSpmMap($spmList){
        $rs = array();
        foreach($spmList as $item){
            $rs[$item["c_uid"]] = $item["c_name"];
        }
        return $rs;
    }

    /**
     * 获取子渠道map对象
     */
    public static function getSubSpmMap($spmList){
        $rs = array();
        foreach($spmList as $item){
            if(!$item["c_sid"]||$item["c_sid"]=="" ){
                continue;
            }
            $rs[$item["c_sid"]] = $item["c_s_name"];
        }
        return $rs;
    }

    /**
     * 初始化用户
     */
    public  static function formatArr($rs){
        $res = array();
        foreach($rs as $item){
            $s_uid = "";
            if($item["c_sid"]&&$item["c_sid"]!=""){
                $s_uid = $item["c_sid"];
            }
            $key = $item["user_type"]."-".$s_uid;
            $res[$key] = $item;
        }
        return $res;
    }

    /**
     * 根据渠道，时间和用户类型获取用户信息
     */
    public static function getUserByTm($stm,$etm){
        $report_log = new FLogger("report_log");
        $sql = "select user_client_type as user_type,channel_uid as c_uid,channel_sid as c_sid, count(*) as reg_cnt from user_main where  kf_id = 0 and uid >= 5000001";
        $sql = $sql." and reg_time >= '".$stm."' and reg_time <'".$etm."'  group by user_type, c_uid, c_sid";
        $report_log->append("getUserByTm-sql:".$sql);
       // echo($sql);
        $rs = FDB::fetch($sql);
        return self::formatArr($rs);
    }

    /**
     * 根据渠道，时间和用户类型获取用户信息
     */
    public static function getAllUserNewSpm(){
        $report_log = new FLogger("report_log");
        $sql = "select channel_uid as c_uid,channel_sid as c_sid from user_main where  kf_id = 0 and uid >= 5000001 group by  c_uid, c_sid";
        $report_log->append("getUserByTm-sql:".$sql);
        $rs = FDB::fetch($sql);
        return $rs;
    }

    /**
     * 获取某段时间内 某渠道，某类型用户 充值总额
     */
    public static function getAllChargeSum($stm,$etm){
        $report_log = new FLogger("report_log");

        $sql = "select um.user_client_type as user_type,um.channel_uid as c_uid,um.channel_sid as c_sid,um.uid,sum(c.paymoney) as charge_sum,count(distinct(um.uid)) as charge_user_cnt ";
        $sql .= "from charge as c left join user_main as um on c.uid = um.uid where c.change_tm >='".$stm."' and c.change_tm <'".$etm."' and c.stat = 1 ";
        $sql .= "group by um.channel_sid,um.user_client_type; ";

        $report_log->append("getUserByTm-sql:".$sql);
         //echo($sql);
        $rs = FDB::fetch($sql);
        return self::formatArr($rs);
    }

    /**
     * 查询统计数据
     */
    public static function statistics($stm="",$etm=""){
        $report_log = new FLogger("report_log");
        $date = date("Y-m-d");
        $hours = date("H");
        if($stm!=""){
            $date = date("Y-m-d",strtotime($stm));
            $hours = date("H",strtotime($stm));
        }
        if($stm==""||$etm==""){
            $stm = date("Y-m-d H:00:00");
            $etm = date("Y-m-d H:00:00",strtotime($stm . "+1 hours"));
        }

        $report_log->append("--------statistics is begin-----".$stm."--".$etm."--".$date."--".$hours);
        echo("--------statistics is begin-----".$stm."--".$etm."--".$date."--".$hours);

        // 获取所有子渠道，用户类型
        $spm_list = self::getAllSpm();

        // 统计用户
        $user_m = self::getUserByTm($stm,$etm);
        // 统计充值
        $charge_m = self::getAllChargeSum($stm,$etm);

        $new_spm = self::getAllUserNewSpm();

        echo(json_encode($new_spm));
        echo("<br>");


       //stats_date | hours | c_uid | c_sid | user_type | reg_cnt | charge_user_cnt | charge_sum | gived_sum
        $data_arr = array();
        foreach($new_spm as $spm_item){
            foreach(self::$USER_TYPE as $type_item){
                $data = array();
                $c_uid = $spm_item["c_uid"];
                $c_sid = $spm_item["c_sid"];
                $user_type = $type_item["user_type"];
                $key = "".$user_type."-".$c_sid;

                $data["stats_date"] = $date;
                $data["hours"] = intval($hours);
                $data["c_uid"] = $c_uid;
                $data["c_sid"] = $c_sid;
                $data["user_type"] = $user_type;

                // 注册用户
                $data["reg_cnt"] = 0;
                if(array_key_exists($key,$user_m)){
                    $data["reg_cnt"] = intval($user_m[$key]["reg_cnt"]);
                }
                // 充值
                $data["charge_user_cnt"] = 0;
                $data["charge_sum"] = 0;
                if(array_key_exists($key,$charge_m)){
                    $data["charge_user_cnt"] = intval($charge_m[$key]["charge_user_cnt"]);
                    $data["charge_sum"] = intval($charge_m[$key]["charge_sum"]);
                }


                if ($data["c_uid"] == ""){
                    $data["c_uid"]= "default";
                }
                if ($data["c_sid"] == ""){
                    $data["c_sid"]= "default";
                }

                array_push($data_arr,$data);
            }
        }
        echo(json_encode($data_arr));
       self::insertTjData($data_arr);

        $report_log->append("--------statistics is end-----".$stm."--".$etm);
    }


    /**
     * 表数据入库
     * @param $tjdata
     */
    public static function insertTjData($tjdata){
        if($tjdata!=null&&count($tjdata)>0){
            $report_table = new FTable("stats");

            $old_data = $report_table->where(array("stats_date"=>$tjdata[0]["stats_date"],"hours"=>$tjdata[0]["hours"]))
                ->remove(true);
            foreach($tjdata as $tjItem){
                $report_table->insert($tjItem);
            }

        }
    }

    /**
     * 创建幕幕管理员用户
     */
    public static function addUser(){
        //判断5000000uid一下的最新一个
        $user_table = new FTable("user_main");
        $sql_str = " uid < 5000000 and uid > 1000000 ";
        $user = $user_table->fields(array("uid"))->where(array("str"=>$sql_str))->order(array("uid"=>"desc"))->find();
        $password = microtime();
        $sid = Service_Manager::getEncryptPassword($password);
        if(!$user){
            $user["uid"] = 1000000;
        }
        $data = array(
            'uid' => $user['uid']+1,
            'gender' => 1,
            'kf_id' => 0,
            'reg_time' => date('Y-m-d H:i:s'),
            'sid' => $sid
        );
        $user_table = new FTable("user_main");
        $uid = $user_table->insert($data);
        $data2 = array(
            'uid' => $uid,
            'nickname' => "admin_test",
            'age' => 1,
            'avatar' => ""
        );
        $user_detail_table = new FTable("user_detail");
        $user_detail_table->insert($data2);

        $admin_table = new FTable("admin");
        $data3 = array("uid"=>$uid);
        $admin_table->insert($data3);
        return $uid;
    }
}
