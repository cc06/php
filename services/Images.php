<?php

/**
 * Class Service_Images
 * 图片认证和入库
 */
class Service_Images{

    /**
     * @param $url  图片url
     * @param $md5  图片md5
     */
    public static function doAddCheckImage($url,$md5){
        $images = array();
        array_push($images,$url);
        $md5_map = array();
        $md5_map[$url] = $md5;
        $res  = Service_TupuTech::doCheckImages($images,1);
        if($res["code"]==0){
            self::addImagesRecord($res,$md5_map);
        }
    }


    /**
     * 保存图片地址和url
     * @param $url 图片地址
     * @param $md5 图片md5
     */
    public static function addImageMd5($url,$md5,$type="chat",$uid=0){
        $img =array("url"=>$url,"md5"=>$md5,"type"=>$type,"uid"=>$uid);
        $image_table = new FTable("image_md5");
        $image_table->insert($img);
    }


    /**
     * 图谱科技的相关数据插入到数据库中
     * 色情+人物类型：
     */
   public static  function addImagesRecord($data,$item){
       $ok = 0;  // 内容为空
       $date_empty = 1;  // 内容为空
       $log = new FLogger("images_log");
       $data = json_decode($data,true);
        if($data&&$data["code"]==0){  // 检测成功
            $images = array();

            if($item==Service_TupuTech::$SEXY_AND_AD){
                //“通用广告”的返回值，“5588dba4c7ee53a04b5fad7d”是“通用广告”的识别任务的TaskID
                $ad_data = $data["5588dba4c7ee53a04b5fad7d"];
                if($ad_data){
                    $file_list = $ad_data["fileList"];
                    foreach($file_list as $file){
                        $name = CommonUtil::getOriginImg($file["name"]);
                        $arr = array();
                        if(array_key_exists($name,$images)){
                            $arr = $images[$name];
                        }
                        $arr["ad_rate"] = 100*$file["rate"];
                        $arr["ad_flag"] = $file["label"];
                        $review = 1;
                        if(!$file["review"]){
                            $review = 0;
                        }
                        $arr["ad_review"] = $review;
                        $arr["human_review"] = 0;
                        $images[$name]=$arr;
                    }
                }
            }

            if($item==Service_TupuTech::$SEXY_AND_HUMAN){
                //“任务识别”的返回值，“dbd1d2c23705e7102070e6”是“色情+人物”的识别任务的TaskID
                $ad_data = $data["554202c4b01bd8ee3b6c005c"];
                if($ad_data){
                    $file_list = $ad_data["fileList"];
                    foreach($file_list as $file){
                        $name = CommonUtil::getOriginImg($file["name"]);
                        $arr = array();
                        if(array_key_exists($name,$images)){
                            $arr = $images[$name];
                        }
                        $arr["human_rate"] = 100*$file["rate"];
                        $arr["human_flag"] = $file["label"];
                        $review = 1;
                        if(!$file["review"]){
                            $review = 0;
                        }
                        $arr["human_review"] = $review;
                        $arr["ad_review"] = 0;
                        $images[$name]=$arr;
                    }
                }
            }

            // “是否色情”的返回值，“54bcfc6c329af61034f7c2fc”是“是否色情”的识别任务的TaskID
            $sexy_data = $data["54bcfc6c329af61034f7c2fc"];
            if($sexy_data){
                $file_list = $sexy_data["fileList"];
                foreach($file_list as $file){
                    $name = CommonUtil::getOriginImg($file["name"]);
                    $arr = array();
                    if(array_key_exists($name,$images)){
                        $arr = $images[$name];
                    }
                    $arr["sexy_rate"] = 100*$file["rate"];
                    $arr["sexy_flag"] = $file["label"];
                    $review = 1;
                    if(!$file["review"]){
                        $review = 0;
                    }
                    $arr["sexy_review"] = $review;
                    $arr["item"] = $item;
                    $images[$name]=$arr;
                }
            }
            $db_data = self::doCheck($images,$item);
            self::addIntoDb($db_data);

            $res_data = array();
            foreach($db_data as $img){
                $item = array();
                $item["url"] = $img["url"];
                $item["status"] = $img["status"];
                array_push($res_data,$item);
            }
            $log->append("tuputech is ok ".json_encode($db_data));
            return CommonUtil::GetDefRes($ok,"success",$res_data);
        }else {
            $log->append("[ERROR] tuputech is error ".json_encode($data));
            return CommonUtil::GetDefRes($date_empty," data is empty or code is not 0");
        }
   }

    /**
     * 插入数据库
     */
    private static function addIntoDb($images){
        $log = new FLogger("images_log");
        if($images){
            foreach($images as $img){
                $url = $img["url"];
                $image_table = new FTable("image_md5");
                $ok =  $image_table->where(array("url"=>$url))->save($img);
                if(!$ok){
                    $log->append("[ERROR] addIntoDb is error, r : ".$ok." ,url :".$url."--img: ".json_encode($img));
                   continue;
                }
            }
        }
    }

    /**
     * @param $images 图片map
     * @param $type 检测类型
     * @return array
     * 对图片结果进行判断
     *  `sexy_rate` double DEFAULT '0' COMMENT '色情识别概率',
        `sexy_flag` tinyint(1) DEFAULT '0' COMMENT '色情等级， 0：色情； 1：性感； 2：正常；',
        `sexy_review` tinyint(1) DEFAULT 0 COMMENT '是否需要人工复审 0 无 1 需要',
        `ad_rate` double DEFAULT '0' COMMENT '广告识别概率',
        `ad_flag` tinyint(1) DEFAULT '0' COMMENT '广告兴致 0：正常； 1：二维码； 2：带文字图片；',
        `ad_review` tinyint(1) DEFAULT 0 COMMENT '是否需要人工复审 0 无 1 需要',
     *  `status` tinyint(1) not null DEFAULT 1 COMMENT '图片检查状态 -1 待处理 0 正常 1 不正常 2 待扩展',
     *  `human_flag` 是否任务， 0：男人； 1：女人； 2：其他； 3：多人；
     */
    private static function doCheck($images,$type){
        $log = new FLogger("images_log");
        $res = array();
        if($images&&count($images)>0){
            foreach($images as $url=>$img){
                $sexy_flag = $img["sexy_flag"];
                $ad_flag = $img["ad_flag"];
                $human_flag = $img["human_flag"];
                $item = $img;
                $item["url"] = $url;
                if(!$url||$url==""){
                    $log->append("[ERROR]--doCheck--url is empty ".$url."img:".json_encode($img));
                    continue;
                }
                $item["status"] = 1;  // 不正常
                if($type==Service_TupuTech::$SEXY_AND_AD&&$sexy_flag!=0&&$ad_flag==0){  // 色情 + 广告
                    $item["status"] = 0;  //正常
                }
                if($type==Service_TupuTech::$SEXY_AND_HUMAN&&$sexy_flag!=0&&$human_flag!=2){  // 色情 + 人物
                    $item["status"] = 0;  //正常
                }
                array_push($res,$item);
            }
        }
        return $res;
    }

}