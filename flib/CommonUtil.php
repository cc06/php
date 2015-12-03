<?php
/**
 * Created by PhpStorm.
 * User: zijunna
 * Date: 14-9-13
 * Time: 上午11:47
 */
class CommonUtil {
    /**
     *
     * @param $list
     * @param null $filterSunAttributeList
     * @return mixed
     */
    public static function evalSubAttributeJsonToObj($list,$filterSunAttributeList=null){
        for($i = 0 ; $i < count($list) ; $i++){
            foreach($list[$i] as $k => $v){
                if($filterSunAttributeList){
                    foreach($filterSunAttributeList as $filterItem){
                        if($k == $filterItem){
                            $tmp = json_decode($list[$i][$k],true);
                            if($tmp != null){
                                $list[$i][$k] = is_numeric($tmp) ? $tmp : (array)$tmp;
                            }
                        }
                    }
                }else{
                    $tmp = json_decode($list[$i][$k],true);
                    if($tmp != null){
                        $list[$i][$k] = is_numeric($tmp) ? $tmp : (array)$tmp;
                    }
                }
            }
        }
        return $list;
    }


    /**
     * 将手机号过滤
     * @param $list
     * @return mixed
     */
    public static function formatPhone($list){
        //将手机号转换过滤
        for($i = 0 ; $i < count($list) ; $i++){
            foreach($list[$i]["winners_user"] as $k => $v){
                if($k == "cell_phone"){
                    $cell_phone =  $list[$i]["winners_user"][$k];
                    $list[$i]["winners_user"][$k] = substr($cell_phone,0,3)."*****".substr($cell_phone,8,3);
                }
            }
        }
        return $list;
    }

    /**
     * 将手机号过滤(适用于list中的所有一维数组)
     * @param $list
     * @return mixed
     */
    public static function formatAllFiledPhone($list){
        //将手机号转换过滤
        for($i = 0 ; $i < count($list) ; $i++){
            $keys  = array_keys($list[$i]);
            for($j = 0 ; $j < count($keys) ; $j++){
                if($keys[$j]=="cell_phone"){
                    $cell_phone =  $list[$i]["cell_phone"];
                    $list[$i]["cell_phone"] = substr($cell_phone,0,3)."*****".substr($cell_phone,8,3);
                }
            }
        }
        return $list;
    }
    /**
     * 用于参数非空校验
     */
    public  static function parmIsEmpty($p){
        if(empty($p) || !isset($p) || $p=='' || $p==null){
            return true;
        }
        return false;
    }

    /**
     * @param $pic 原头像图片
     * @param $flag 返回默认头像图片大小
     * @return string 返回头像，如果有头像则返回，否则返回$flag的默认头像
     */
    public static function getUserPicByPic($pic,$flag="M"){
        if(self::parmIsEmpty($pic)){
            if("S"== $flag){
                return "http://res.cdn.51caijia.com/img/logo50x50.jpg";
            }elseif("M"== $flag){
                return "http://res.cdn.51caijia.com/img/logo100x100.jpg";
            }elseif("B"== $flag){
                return "http://res.cdn.51caijia.com/img/logo200x200.jpg";
            }
        }
        return $pic;
    }

    /**
     * @param $tm  返回stm 和etm，但没有传入参数，表示查询全部时间段，today ,yestertody
     */
    public static function getTimeLine($tm){
        if("all"==$tm){
            $stm = date('Y-m-d 00:00:00', strtotime("1970-01-01 00:00:00"));
            $etm = date('Y-m-d 00:00:00', strtotime("2070-01-01 00:00:00"));
        }elseif("yesterday"==$tm){
            $stm = date("Y-m-d 00:00:00",strtotime("last days")); // 昨天凌晨
            $etm = date("Y-m-d 00:00:00");
        }elseif("today"==$tm){
            $stm = date("Y-m-d 00:00:00");  //今天0晨
            $etm = date("Y-m-d 00:00:00",strtotime("next days")); // 明天凌晨
        }
        return array("stm"=>$stm,"etm"=>$etm);
    }

    /**
     * 但参数不为空，则返回值，否则返回0
     * @param $param
     * @return int
     */
    public static function getCommonNum($param){
        if(CommonUtil::parmIsEmpty($param)){
            return 0;
        }
        return $param;
    }

    /**
     * 获取指定长度的字符串，多余的用...替换
     * @param $or_str
     * @param $num
     * @return string
     */
    public static function getShortStr($or_str,$num){
        $str_cut = $or_str;
        if(strlen($or_str)>$num){
            $str_cut =  mb_substr($str_cut, 0,$num, 'utf-8');
        }
        return $str_cut;
    }

    /**
     * 用户获取参数值，如果没有或为空， 则返回默认值
     * @param $param
     * @param int $def
     * @return int
     */
    public static function getComParam($param,$def=20){
        $value = $def;
        if(!CommonUtil::parmIsEmpty($param)){
            $value = intval($param);
        }
        return $value;
    }

    /**
     * 获取更多总类的图片
     * @param $img_url
     * @param $width
     * @param $height
     * @return string
     */
    public  static function getMoreSizeImg($img_url,$width,$height){
        if($img_url){
            $index = strrpos($img_url,"@",0);
            if($index){
                $img_url = strstr($img_url, '@', TRUE);
            }
        }
        $p = pathinfo($img_url);
        $ext = $p["extension"];
        $img_url .= "@1e_" . $width . "w_" . $height . "h_1c_0i_1o_95Q_1x.".$ext;
        return $img_url;
    }


    /**
     * 获取限定一边大小的图片，同比压缩
     * @param $img_url
     * @param $size
     * @return string
     */
    public  static function getImgBySize($img_url,$size){
        if($img_url){
            $index = strrpos($img_url,"@",0);
            if($index){
                $img_url = strstr($img_url, '@', TRUE);
            }
        }
        $p = pathinfo($img_url);
        $ext = $p["extension"];
        $img_url .= "@".$size."w_90Q_1x.".$ext;
        return $img_url;
    }

    /**
     * 获取压缩图片的原图
     * @param $img_url
     * @return string
     */
    public  static function getOriginImg($img_url){
        if($img_url){
            $index = strrpos($img_url,"@",0);
            if($index){
                $img_url = strstr($img_url, '@', TRUE);
            }
        }
        return $img_url;
    }

    /**
     * 更具情况获取默认值
     */
    public  static function getDefStr($or_str,$def){
        if($or_str&&strlen($or_str)>0){
            return $or_str;
        }
        return $or_str?$or_str:$def;
    }

    /**
     * 年龄到生日
     */
    public static function ageToBirthday($age){
        return date("Y-m-d", mktime(0,0,0,date("d"),date("m"), date("Y")-$age));
    }

    /**
     * 生日到年龄
     */
    public static function birthdayToAge($birthday){
        $tm = strtotime($birthday);
        return date("Y") - date("Y",$tm);
    }
    /**
     * 把unicode转成汉字
     * @param $str
     * @return mixed
     */
    public static function decodeUnicode($str)
    {
        $str = str_replace("\/","/",$str);
        return preg_replace_callback('/\\\\u([0-9a-f]{4})/i',
            create_function(
                '$matches',
                'return mb_convert_encoding(pack("H*", $matches[1]), "UTF-8", "UCS-2BE");'
            ),
            $str);
    }

    /**
     * @param $str
     * @return bool|mix|mixed|string
     */
    function unicode2utf8($str){
        if(!$str) return $str;
        $decode = json_decode($str);
        if($decode) return $decode;
        $str = '["' . $str . '"]';
        $decode = json_decode($str);
        if(count($decode) == 1){
            return $decode[0];
        }
        return $str;
    }


    /**
     * @param $code
     * @param $msg
     * @param array $data
     * @return array
     */
    public  static  function  GetDefRes($code,$msg,$data=array()){
        $res = array("code"=>$code,"msg"=>$msg,"res"=>$data);
        return $res;
    }

}