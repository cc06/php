<?php
/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15-7-14
 * Time: 上午9:31
 */
class Service_Common{
    private static  $API_SERVICE_URL = "http://api2.app.yuanfenba.net";
    /**
     * 获取系统时间
     * @return int
     */
    public static function getSysTm(){
        return time();
    }

    /**
     * 根据手机号码，换取默认用户昵称
     * @param $phone
     * @return string
     */
    public static function getNickNameByPhoneNum($phone){
        return "用户".substr($phone,0,4) ."****".substr($phone,8)."_".rand(10000,90000);
    }



    /**
     * 递归将数组中的值进行encode
     */
    public static function array_url_encode($data,$filter = null){
        foreach($data as $key => $val){
            if($filter){
                $bool = false;
                foreach($filter as $f_key){
                    if($key == $f_key){
                        $bool = true;
                        break;
                    }
                }
                if($bool){
                    $data[$key] = is_array($val) ? Service_Common::array_url_encode($val,$filter) : rawurlencode($val);
                }else{
                    $data[$key] = is_array($val) ? Service_Common::array_url_encode($val,$filter) : $val;
                }
            }else{
                $data[$key] = is_array($val) ? Service_Common::array_url_encode($val,$filter) : rawurlencode($val);
            }
        }
        return $data;
    }


    /**
     * 将分钟转化成多久以前
     * @param $minutes
     * @return float|int|string
     */
    public static function date_format_by_minutes($minutes){
        $day = (int)(floor($minutes / 1440));
        $hour = $day > 0 ? floor(($minutes - $day*1440)/60) :floor($minutes/60);
        $minute = $hour > 0 ? floor($minutes - $day * 1440 - $hour*60):$minutes;
        $time="";
        if ($day > 0) $time .= $day . "天";
        if ($hour > 0) $time .= $hour . "小时";
        if ($minute > 0) $time .= $minute . "分";
        return $time;
    }

    /**
     * 获取
     */
    public static function getNickName(){
        $url = FConfig::get('global.service_mumu_url')."/user/GetNick";
      //  $url = "http://yfservice.admin.docker:8081/user/GetNick";
        $ret = FHttp::get($url);
        return $ret;
    }
    /**
     * 获取
     */
    public static function post($url,$params){
        $ret = FHttp::post($url,$params);
        return $ret;
    }

    /**
     * 安全post请求，会追加当前登录用户cookie
     */
    public static function secPost($url,$params){
        $cookie = "sid=".FSession::get('sid').";uid=".FSession::get('user_id').";key=".FSession::get('sid');
        $res = FHttp::doPost($url,$params,$cookie);
        $params=json_decode($res);

        if($params->status=="ok"){
            $res=CommonUtil::GetDefRes(200,"正确");
        } else{
            $res=CommonUtil::GetDefRes(201,"错误");
        }


        echo("----".$res);
        return $res;
    }


    /**
     * 获取所有的统计子渠道
     */
    public static function getAllSpm(){
        /*$url = self::$API_SERVICE_URL."/user2/getCAllList";
        $ret = FHttp::get($url);
        $obj = json_decode($ret,true);
        $spm_arr = array();
        foreach($obj as $key => $value){
          //  echo("uid: ".$key."   name :".$value["username"]);
            $c_sid_arr = $value["c_sid"];
            if($c_sid_arr){
                foreach($c_sid_arr as $sub_id => $sub_v){
                  //  echo("sid: ".$sub_id."   name :".$sub_v["username"]);
                   // $spm = array("c_uid"=>$key,"c_sid"=>$sub_id,"c_name"=>$value["username"],"c_s_name"=>$sub_v["username"]);
                    $spm = array("c_uid"=>$key,"c_sid"=>$sub_id,"c_name"=>$key,"c_s_name"=>$sub_v["username"]);
                    array_push($spm_arr,$spm);
                }
            }else{
                // $spm = array("c_uid"=>$key,"c_sid"=>"","c_name"=>$value["username"],"c_s_name"=>"");
                $spm = array("c_uid"=>$key,"c_sid"=>"","c_name"=>$key,"c_s_name"=>"");
                array_push($spm_arr,$spm);
            }
        }*/
        $spm_arr = array();
        $table = new FTable("stats_spm");
        $res = $table->select();

        foreach($res as $key => $value){
            $item = array();
            $item["c_uid"] = $value["cid"];
            $item["c_sid"] = $value["sid"];
            $item["c_name"] = $value["spm_name"];
            $item["c_s_name"] =$value["spm_name"];
            array_push($spm_arr,$item);
        }
        return $spm_arr;
    }

    /**
     * 清除用户缓存
     * @param $uid
     * @return bool
     */
    public static function clearUserCache($uid){
        $params = array("uid"=>$uid);
        $params =json_encode($params);
        $url = FConfig::get('global.service_mumu_url')."/user/ClearUserCache";
        $ret = FHttp::post($url,$params);
        return $ret;
    }


    /**
     * 清除用户缓存
     * @param $uid
     * @return bool
     */
    public static function clearUserCache2($uid){
        $params = array("uid"=>$uid);
        $params =json_encode($params);
        $url = "http://yfservice.admin.docker:8081/user/ClearUserCache";
        $ret = FHttp::post($url,$params);
        return $ret;
    }
}