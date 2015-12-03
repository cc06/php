<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/13
 * Time: 下午13:00
 */
class Controller_Admin_WeixinHuodong extends  Controller_Admin_Abstract{
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
            $text = FRequest::getString('text');
            $where = array();

            $shanchu_id = FRequest::getInt('shanchu_id');
            if ($shanchu_id) {
                $weixin_huodongs = new FTable('weixin_huodong');
                $weixin_huodongs->where(array('id' => $shanchu_id))->remove(true);
            }


            $table = new FTable("weixin_huodong");
            $weixin_huodongs = $table->fields(array(
                "id",
                "title",
                "text",
                "pic",
                "url",
                "position"
            ))
                ->where($where)->page($page)->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

            foreach($weixin_huodongs as &$weixin_huodong){

                $weixin_huodong["pic"] = CommonUtil::getMoreSizeImg($weixin_huodong["pic"],100,100);
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('weixin_huodong', $weixin_huodongs);
            $this->assign('text', $text);
            $this->display('admin/weixin_huodong_list');
        }

    /**
     * 修改焦点图
     */
    function  updateAction(){

        $id = FRequest::getInt("id");
        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $pic = FRequest::getPostString('pic');
            $url = FRequest::getPostString('url');
            $title = FRequest::getPostString('title');
            $position =  CommonUtil::getComParam(FRequest::getPostInt('position'),0);

            if (!$pic) {
                $this->showMessage("图片不能为空" ,error);
                return;
            }
            if (!$title) {
                $this->showMessage("标题不能为空" ,error);
                return;
            }



            $data2 = array(
                'title' => $title,
                'text' => $text,
                'pic' => $pic,
                'url' =>  $url,
                'position' =>  $position

            );

            $weixin_huodong_table = new FTable("weixin_huodong");
            $weixin_huodong_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改成功","success","/WeixinHuodong/list");
            return;
        }
        $weixin_huodong_table = new FTable("weixin_huodong");
        $weixin_huodong = $weixin_huodong_table->where(array('id' => $id))->find();

        $this->assign("weixin_huodong",$weixin_huodong);
        $this->assign("id",$id);


        $this->display('admin/weixin_huodong_update');
    }
    /**
     * 添加焦点图
     */
    function  addAction(){


        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $pic = FRequest::getPostString('pic');
            $url = FRequest::getPostString('url');

            $title = FRequest::getPostString('title');

            $position =  CommonUtil::getComParam(FRequest::getPostInt('position'),0);

            if (!$pic) {
                $this->showMessage("图片不能为空" ,error);
                return;
            }

            if (!$title) {
                $this->showMessage("标题不能为空" ,error);
                return;
            }
            //打开网页



            //print_r($content);

            $data2 = array(
                'title' => $title,
                'text' => $text,
                'pic' => $pic,
                'url' =>  $url,
                'position' =>  $position

            );

            $weixin_huodong_table = new FTable("weixin_huodong");
            $weixin_huodong_table->insert($data2);

            $this->showMessage("添加成功","success","/WeixinHuodong/list");
            return;
        }

        $this->display('admin/weixin_huodong_add');
    }


}