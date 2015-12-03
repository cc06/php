<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/13
 * Time: 下午13:00
 */
class Controller_Admin_FocusList extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 添加地址
     */
        function  listAction(){
            //global $_F;
           // $_F["debug"] = true;

            $page = max(1, FRequest::getInt('page'));
            $type = CommonUtil::getDefStr(FRequest::getString('type'),"main");
            $this->assign('type', $type);
            $where = array();

            $shanchu_id = FRequest::getInt('shanchu_id');
            if ($shanchu_id) {
                $focus = new FTable('focus');
                $focus->where(array('id' => $shanchu_id))->remove(true);
            }

            $xiaxian_id = FRequest::getInt('xiaxian_id');
            if ($xiaxian_id) {
                $events_table = new FTable("focus");
                $events_table->where(array("id"=>$xiaxian_id))->update(array("status"=>0));
            }

            $shangxian_id = FRequest::getInt('shangxian_id');
            if ($shangxian_id) {
                $events_table = new FTable("focus");
                $events_table->where(array("id"=>$shangxian_id))->update(array("status"=>1));
            }

            if ($type) {
                $where['type']=$type;
            }

            $table = new FTable("focus");
            $focus = $table->fields(array(
                "id",
                "type",
                "text",
                "pic",
                "action",
                "position",
                "status"
            ))
                ->where($where)->page($page)->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

            foreach($focus as &$focu){

                $focu["pic"] = CommonUtil::getMoreSizeImg($focu["pic"],100,100);
                $focu["action"] = json_decode($focu["action"]);
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('focus', $focus);
            $this->display('admin/focus_list');
        }

    /**
     * 修改焦点图
     */
    function  updateAction(){

        $id = FRequest::getInt("id");
        $type = FRequest::getString('type');
        $this->assign('type', $type);
        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $pic = FRequest::getPostString('pic');
            $anniu_caozuo = FRequest::getPostInt('anniu_caozuo');

            $type = FRequest::getPostString('type');
            $position =  CommonUtil::getComParam(FRequest::getPostInt('position'),0);
            $events_id = FRequest::getPostInt('events_id');

            if (!$pic) {
                $this->showMessage("图片不能为空" ,error);
                return;
            }

            //打开网页
            $url = FRequest::getPostString('url');

            //打开游戏
            $gid = FRequest::getPostString('gid');
            $area_id = FRequest::getPostString('area_id');

            $buts=array();

            if ($anniu_caozuo==1) {
                $data = array("url"=>$url);
                if (!$url) {
                    $this->showMessage("链接地址不能为空" ,error);
                    return;
                }
                $buts=array(
                    "cmd"=>"cmd_open_web",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==2) {
                $data = array();

                $buts=array(
                    "cmd"=>"cmd_open_actlist",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==3) {
                $data = array("id"=>$events_id);

                $buts=array(
                    "cmd"=>"cmd_open_act",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==4) {
                $data = array();

                $buts=array(
                    "cmd"=>"cmd_open_actaward",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==5) {
                $data = array("gid"=>$gid,"area_id"=>$area_id);

                $buts=array(
                    "cmd"=>"cmd_entry_game",
                    "data"=> $data
                );
            }

            $text=str_replace("<p>","",$text);
            $text=str_replace("</p>","<br>",$text);
            $action=self::decodeUnicode(json_encode($buts));

            //print_r($content);

            $data2 = array(
                'type' => $type,
                'text' => $text,
                'pic' => $pic,
                'action' =>  $action,
                'position' =>  $position

            );

            $events_table = new FTable("focus");
            $events_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改成功","success","/FocusList/list?type=".$type."");
            return;
        }
        $focus_table = new FTable("focus");
        $focus = $focus_table->where(array('id' => $id))->find();
        $focus["action"] = json_decode($focus["action"]);

        $this->assign("focus",$focus);
        $this->assign("id",$id);


        $this->display('admin/focus_update');
    }
    /**
     * 添加焦点图
     */
    function  addAction(){

        $type = FRequest::getString('type');
        $this->assign('type', $type);
        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $pic = FRequest::getPostString('pic');
            $anniu_caozuo = FRequest::getPostInt('anniu_caozuo');
            $events_id = FRequest::getPostInt('events_id');

            $type = FRequest::getPostString('type');
            $position =  CommonUtil::getComParam(FRequest::getPostInt('position'),0);

            if (!$pic) {
                $this->showMessage("图片不能为空" ,error);
                return;
            }

            //打开网页
            $url = FRequest::getPostString('url');

            //打开游戏
            $gid = FRequest::getPostString('gid');
            $area_id = FRequest::getPostString('area_id');



            $buts=array();

            if ($anniu_caozuo==1) {
                $data = array("url"=>$url);
                if (!$url) {
                    $this->showMessage("链接地址不能为空" ,error);
                    return;
                }
                $buts=array(
                    "cmd"=>"cmd_open_web",
                    "data"=> $data
                );
            }

            if ($anniu_caozuo==2) {
                $data = array();

                $buts=array(
                    "cmd"=>"cmd_open_actlist",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==3) {
                $data = array("id"=>$events_id);

                $buts=array(
                    "cmd"=>"cmd_open_act",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==4) {
                $data = array();

                $buts=array(
                    "cmd"=>"cmd_open_actaward",
                    "data"=> $data
                );
            }
            if ($anniu_caozuo==5) {
                $data = array("gid"=>$gid,"area_id"=>$area_id);

                $buts=array(
                    "cmd"=>"cmd_entry_game",
                    "data"=> $data
                );
            }


            $text=str_replace("<p>","",$text);
            $text=str_replace("</p>","<br>",$text);
            $action=self::decodeUnicode(json_encode($buts));

            //print_r($content);

            $data2 = array(
                'type' => $type,
                'text' => $text,
                'pic' => $pic,
                'action' =>  $action,
                'position' =>  $position,
                'status' => 1

            );

            $events_table = new FTable("focus");
            $events_table->insert($data2);

            $this->showMessage("添加成功","success","/FocusList/list?type=".$type."");
            return;
        }

        $this->display('admin/focus_add');
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