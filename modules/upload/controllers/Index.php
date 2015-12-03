<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15-08-18
 * Time: 下午10:14
 */
class Controller_Upload_Index extends Controller_Upload_Abstract
{
    /**
     * 秋千图片，头像，语音上传接口
     * post提交
     * 文件字段名为file_name
     * type 类型，如头像avatar，大头像avatar_big,相册photo,语音voice，动态 dynamic
     * uid 用户ID
     * flag: 1 type和uid通过get方式获取 否则通过post获取
     */
    public function defaultAction()
    {
        global $_F;
        $log = new FLogger("images_log");
        $log->append("---being---".time());
        if ($this->isPost()) {
            $_F['s_url_oss'] = 'http://image1.yuanfenba.net';
            //FConfig::get('global.s_url_oss');
            $flag = FRequest::getInt('flag');
            if ($flag == 1) {
                $type = FRequest::getString('type');
                $uid = FRequest::getString('uid');
            } else {
                $type = FRequest::getPostString('type');
                $uid = FRequest::getPostString('uid');
            }
            $return_arr = array();
          //  $log->append("---being-2--".($type));
            if ($type) {
                $log2 = new FLogger("images_log");
                $log2->append("---being-1--".time());
                if ($type == 'voice') {
                    $_F['s_url_oss'] = 'http://dl.yuanfenba.net';
                    $return_arr = Service_AttachMumu::getInstance()->uploadOSS('file_name', $type, 'amr');
                } else {
                    $return_arr = Service_AttachMumu::getInstance()->uploadOSS('file_name', $type);
                }
                $file_path = $return_arr['object'];
                if ($file_path) {
                    $file_http_path = Service_AttachMumu::getInstance()->getThumbUrl($file_path);
                    // 保存图片
                   // if($type=="avatar"||$type=="avatar_big"||$type=="photo"||$type=="chat"||$type=="topic"){
                    if($type=="avatar"||$type=="avatar_big"||$type=="chat"||$type == "photo"){
                        Service_Images::addImageMd5($file_http_path,$return_arr["md5"],$type,$uid);
                    }
                    $log2->append("---being--retun---".json_encode($return_arr));
                    FResponse::output(array(
                        'status' => 'ok',
                        'msg' => '上传成功',
                        'code' => '00',
                        'res' => array(
                            'file_s_path' => $file_path,
                            'file_http_path' => $file_http_path,
                            'md5' => $return_arr["md5"],
                        ),
                    ));

                } else {
                    FResponse::output(array(
                        'status' => 'error',
                        // 'file_path' => $file_path,
                        'msg' => '上传失败！'
                    ));
                }
            } else {
                FResponse::output(array(
                    'status' => 'error',
                    'msg' => '参数错误！'
                ));
            }
        } else {
            $this->display('upload');
        }
        $log->append("---end---".time());
    }

    /**
     * 图片检测接口
     * img 图片url
     */
    public function checkImgAction(){
        //sleep(50);
        $log = new FLogger("images_log");
        $url = FRequest::getString('imgs');
        $item = FRequest::getInt("type");
        if(!$url){
            FResponse::output(array('status' => 'fail','msg' => 'parm img is empty'));
            return;
        }
        if(!$item||$item<=0){
            FResponse::output(array('status' => 'fail','msg' => 'parm type is empty'));
            return;
        }
        $images = explode(",",$url);
        if(!$images||count($images)<=0){
            FResponse::output(array('status' => 'fail','msg' => 'the length of images is less than 0'));
            return;
        }
        // 检测图片域名
        foreach($images as &$url){
            $S = parse_url($url);
            $S = strtolower($S['host']); //取域名部分

            if($item==Service_TupuTech::$SEXY_AND_AD && !(strpos($S,"yuanfenba.net")||strpos($S,"mumu123.cn"))){
                FResponse::output(array('status' => 'fail','msg' => 'the host of image is error'));
                return;
            }
            if(strpos($S,"yuanfenba.net")||strpos($S,"mumu123.cn")){
                $url = CommonUtil::getImgBySize($url,256);
            }
        }
        $log->append("checkImgAction - begin :".time().json_encode($images));
        $res  = Service_TupuTech::doCheckImages($images,$item);
        $log->append("checkImgAction - 1 :".time());
        if($res["code"]==0){
            $data = Service_Images::addImagesRecord($res,$item);

            FResponse::output($data);
        }else{
            $log->append("[ERROR] checkImgAction is error".json_encode($res));
            FResponse::output(array('status' => 'fail','msg' => 'check img is error'));
        }
        $log->append("checkImgAction - end :".time());
    }



    public function imagesAction(){
        //$images = array('http://image.zzd.sm.cn/18053189379075177102.jpg','http://image.zzd.sm.cn/14984010053067146833.jpg');
       /* $url = 'http://image.zzd.sm.cn/18053189379075177102.jpg';
        $md5="2312312321321312";
        $images = array();
        array_push($images,$url);
        $md5_map = array();
        $md5_map[$url] = $md5;
        $res  = Service_TupuTech::doCheckImages(1,$images);
        if($res["code"]==0){
         //   Service_Images::addImagesRecord($res,$md5_map);
        }
        FResponse::output($res);*/
    }

    public function doSleepAction(){
       /* $Url = 'http://image1.yuanfenba.net/uploads/oss/photo/201508/20/20000561547.jpg@%20256w_90Q_1x.jpg';
        $S = parse_url($Url);

        if($Url){
            $index = strrpos($Url,"@",0);
            if($index){
                $Url = strstr($Url, '@', TRUE);
            }
        }
        echo $Url."<br>";

        echo json_encode($S)."<br>";
        $S = strtolower($S['host']) ; //取域名部分

        $re = pathinfo($Url);
        echo json_encode($re)."<br>";
        if(!strpos($S,"yuanFenba.net")){
            echo"no error path";
        }else{
            echo "yes";
        }
\
        echo $S;*/
        /*for($i =0;$i<=100;$i++){
            $r = rand(0,20);
            echo (rand(0,20)-10)."<br>";
        }*/


        /*$url = "http://image2.yuanfenba.net/uploads/oss/photo/201506/19/13072474951.jpg";
        //获取图片二进制流
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        // curl_setopt($ch, CURLOPT_GET, 1);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch,CURLOPT_HEADER,0);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);//return the image value

        //  curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
        // curl_setopt($ch, CURLOPT_TIMEOUT, 15);

        curl_setopt($ch,CURLINFO_CONTENT_LENGTH_DOWNLOAD,1);//content 下载原大小
        curl_setopt($ch,CURLINFO_SIZE_DOWNLOAD,1);//实际下载大小

        $imageData = curl_exec($ch);
        $info = curl_getinfo($ch);
        curl_close($ch);

       // dfsdaf
       var_dump($info);
        echo("-------".$info["size_download"]!=$info["download_content_length"]);
        if($info["size_download"]!=$info["download_content_length"]){
            // 实际下载大小于源文件大小不符
          //  echo("-------");

        }
        $md5 = md5($imageData);*/

        $stm = time();
        $log2 = new FLogger("images_log");
        $log2->append("---begin----".$stm);

        $t = new FTable("user_detail");
        $t->fields(array("uid","avatar","avatarlevel"))->where(array("avatarlevel"=>array('neq','-1'),"uid"=>array('gt'=>'5025587')))->order(array("uid"=>"asc"));
//$data = $t->limit(100)->select();
        $res = $t->select();

        $data = $res;

        $log2->append("---begin----".count($data));
        $i = 0;
        foreach($data as $ud){
            $url = $ud["avatar"];
            if($url==""){
                continue;
            }

            $image_table = new FTable("image_md5");
            $n = $image_table->where(array("url"=>$url))->count();
            if($n>0){
                $log2->append("-ok--".$ud["uid"]."--".$ud["avatar"]);
                continue;
            }
            // sleep(1);
            //获取图片二进制流
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            // curl_setopt($ch, CURLOPT_GET, 1);
            // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch,CURLOPT_HEADER,0);
            curl_setopt($ch,CURLOPT_RETURNTRANSFER,1);//return the image value
            //  curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
            // curl_setopt($ch, CURLOPT_TIMEOUT, 15);

            $imageData = curl_exec($ch);
            $info = curl_getinfo($ch);
            curl_close($ch);
            // 判断是否全部下载完成
            if($info["size_download"]!=$info["download_content_length"]){ // 实际下载大小于源文件大小不符
                $log2->append("-下载不完整-".$ud["uid"]."--".$ud["avatar"]."---实际：-".$info["size_download"]."-源文件：-".$info["download_content_length"]);
                continue;
            }

            $md5 = md5($imageData);
            /*if($i%20==0){
                $log2->append("---".$ud["uid"]."--".$ud["avatar"]."md5: ".$md5);
            }*/
            $log2->append("---".$ud["uid"]."--".$ud["avatar"]."md5: ".$md5);

            $t = 0;
            $img =array("url"=>$url,"md5"=>$md5,"type"=>"avatar","status"=>$t);

            $image_table2 = new FTable("image_md5");
            try{
                $image_table2->insert($img);
            }catch (Exception $e){
                $log2->append("重复key :".$url."e: ".$e->getTraceAsString());
            }

            $i++;
        }

    }
}