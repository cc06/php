<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/2
 * Time: 上午18:00
 */
class Controller_Admin_Events extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 添加活动
     */
        function  addAction(){
            //global $_F;
           // $_F["debug"] = true;
            if ($this->isPost()) {

                $text = FRequest::getPostString('text');
                $textlong = FRequest::getPostString('textlong');
                $pic = FRequest::getPostString('pic');
                $picda = FRequest::getPostString('picda');

                $tip = FRequest::getPostString('tip');
                $anniu_caozuo = FRequest::getPostInt('anniu_caozuo');
                $timeout = FRequest::getPostString('timeout');

                if (!$text) {
                    $this->showMessage("活动标题不能为空" ,error);
                    return;
                }
                if (!$textlong) {
                    $this->showMessage("活动内容不能为空" ,error);
                    return;
                }
                if (!$pic) {
                    $this->showMessage("活动图片不能为空" ,error);
                    return;
                }
                if (!$tip) {
                    $this->showMessage("按钮文字不能为空" ,error);
                    return;
                }
                $textlong=str_replace("<p>","",$textlong);
                $textlong=str_replace("</p>","<br>",$textlong);
                //打开网页
                $url = FRequest::getPostString('url');

                //打开圈子
                $topic_id = FRequest::getPostString('topic_id');

                //打开游戏
                $gid = FRequest::getPostString('gid');
                $area_id = FRequest::getPostString('area_id');

                $buts=array();

                $buts[0]=array(
                    "tip"=> "忽略",
                    "cmd"=> "cmd_close",
                    "def"=>false
                  );

                if ($anniu_caozuo==1) {
                    $data = array("url"=>$url);
                    if (!$url) {
                        $this->showMessage("链接地址不能为空" ,error);
                        return;
                    }
                    $buts[1]=array(
                        "tip"=>$tip,
                        "cmd"=>"cmd_open_web",
                        "def"=>true,
                        "data"=> $data
                    );
                 }

                if ($anniu_caozuo==2) {
                    $data = array("tid"=>$topic_id);
                    if (!$topic_id) {
                        $this->showMessage("圈子话题ID不能为空" ,error);
                        return;
                    }
                    $buts[1]=array(
                        "tip"=>$tip,
                        "cmd"=>"cmd_open_topic",
                        "def"=>true,
                        "data"=> $data
                    );
                }

                if ($anniu_caozuo==3) {
                    $data = array("gid"=>$gid,"area_id"=>$area_id);

                    $buts[1]=array(
                        "tip"=>$tip,
                        "cmd"=>"cmd_entry_game",
                        "def"=>true,
                        "data"=> $data
                    );
                }
                $content=array(
                    "text"=>$textlong,
                    "pic"=>$picda,
                    "buts"=> $buts
                );
                $content=self::decodeUnicode(json_encode($content));

                //print_r($content);

                $data2 = array(
                    'title' => $text,
                    'pic' => $pic,
                    'timeout' => $timeout.":00",
                    'content' =>  $content
                );
                if ($picda) {
                    $data2["style"] =2;
                } else {
                    $data2["style"] =1;
                }

                $events_table = new FTable("events");
                $events_table->insert($data2);

                $this->showMessage("创建成功" ,$messageType = 'success');
                return;
            }


            $this->display('admin/events_add');
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
}