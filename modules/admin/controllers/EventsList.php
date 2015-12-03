<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/2
 * Time: 上午18:00
 */
class Controller_Admin_EventsList extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 活动列表
     */
        function  listAction(){
            //global $_F;
           // $_F["debug"] = true;

            $page = max(1, FRequest::getInt('page'));
            $title = FRequest::getString('title');
            $where = array();

            $shanchu_id = FRequest::getInt('shanchu_id');
            if ($shanchu_id) {
                $events = new FTable('events');
                $events->where(array('id' => $shanchu_id))->remove(true);
            }


            if ($title) {
                $where["title"] = array('like'=> $title);
            }
            $table = new FTable("events");
            $events = $table->fields(array(
                "id",
                "style",
                "title",
                "pic",
                "content",
                "tm"
            ))
                ->where($where)->page($page)->limit(20)->order(array("id"=>"desc"))->select();

            foreach($events as &$event){

                $event["pic"] = CommonUtil::getMoreSizeImg($event["pic"],100,100);
                $event["content"] = json_decode($event["content"]);
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('events', $events);
            $this->assign('title', $title);
            $this->display('admin/events_list');
        }

    /**
     * 修改活动
     */
    function  updateAction(){

        $id = FRequest::getInt("id");
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
            $events_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改活动成功","success","/EventsList/list");
            return;
        }
        $events_table = new FTable("events");
        $events = $events_table->where(array('id' => $id))->find();
        $events["content"] = json_decode($events["content"]);

        $events["timeout"] = substr($events["timeout"], 0, -3);

        $this->assign("events",$events);
        $this->assign("id",$id);


        $this->display('admin/events_update');
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