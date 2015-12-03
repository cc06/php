<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15-08-18
 * Time: 下午10:14
 */
class Controller_Upload_Cron extends Controller_Upload_Abstract
{
    /**
     * 初始化avatar的md5值
     * 文件字段名为file_name
     */
    public function initAvatarAction()
    {
        $log2 = new FLogger("images_log");
        $t = new FTable("user_detail");
        $t->fields(array("uid","avatar","avatarlevel"))->where(array("avatarlevel"=>array('neq','-1'),"uid"=>array('gt'=>'5000000')))->order(array("uid"=>"asc"));
        //$data = $t->limit(10)->select();
        $data = $t->select();

        echo(json_encode($data));
       // $log2->append(json_encode($data));
        foreach($data as $ud){
            $url = $ud["avatar"];

            $md5 = self::downAndGetMd5($url);
            if($md5!=""){
                self::addDb($url,$md5,$ud["avatarlevel"]);
            }
            $log2->append("---".$ud["uid"]."--".$ud["avatar"]);
        }
      /*  echo json_encode($data);
        if(count($data)<=0) return false;

        $hArr = array();//handle array

        foreach($data as $pic){

            $h = curl_init();
            curl_setopt($h,CURLOPT_URL,$pic['avatar']);
            curl_setopt($h,CURLOPT_HEADER,0);
            curl_setopt($h,CURLOPT_RETURNTRANSFER,1);//return the image value

            array_push($hArr,$h);
        }

        $mh = curl_multi_init();
        foreach($hArr as $k => $h){
            curl_multi_add_handle($mh,$h);
        }
        $running = null;
        do{
            curl_multi_exec($mh,$running);
        }while($running > 0);

        // get the result and save it in the result ARRAY
       // $picsArr = array();
        foreach($hArr as $k => $h){
            $r = curl_multi_getcontent($h);
            $picsArr[$k]['data']  = $r;
            echo $k."--".json_encode($picsArr)."<br>";
        }

        //close all the connections
        foreach($hArr as $k => $h){
            $info = curl_getinfo($h);
            preg_match("/^image/(.*)$/",$info['content_type'],$matches);
          //  echo($info);
          echo $k."--".md5_file($info)."<br>";
            curl_multi_remove_handle($mh,$h);
        }
        curl_multi_close($mh);*/

        return true;
}

    /**
     * 下载并获取md5值
     * @param $url
     * @return string|void
     */
    public static function downAndGetMd5($url){
        if($url==""){
            return;
        }
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
        curl_close($ch);
        $md5 = md5($imageData);
        return $md5;
    }



    public static function addDb($url,$md5,$status){
        $image_t = new FTable("image_md5");
        $num = $image_t->where(array("url"=>$url))->count();
        if($num>0){
            return;
        }
        $t = 0;
        if($status==-1){
            $t = 1;
        }else if($status == -2){
            $t = -1;
        }
        $img =array("url"=>$url,"md5"=>$md5,"type"=>"avatar","status"=>$t);
        $image_table = new FTable("image_md5");
        $image_table->insert($img);
    }

}