<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/13
 * Time: 下午13:00
 */
class Controller_Admin_MumuYouxi extends  Controller_Admin_Abstract{
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
                $mumu_youxis = new FTable('mumu_youxi');
                $mumu_youxis->where(array('id' => $shanchu_id))->remove(true);
            }


            $table = new FTable("mumu_youxi");
            $mumu_youxis = $table->fields(array(
                "id",
                "title",
                "text",
                "pic",
                "url",
                "position"
            ))
                ->where($where)->page($page)->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

            foreach($mumu_youxis as &$mumu_youxi){

                $mumu_youxi["pic"] = CommonUtil::getMoreSizeImg($mumu_youxi["pic"],100,100);
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('mumu_youxi', $mumu_youxis);
            $this->assign('text', $text);
            $this->display('admin/mumu_youxi_list');
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

            $mumu_youxi_table = new FTable("mumu_youxi");
            $mumu_youxi_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改成功","success","/MumuYouxi/list");
            return;
        }
        $mumu_youxi_table = new FTable("mumu_youxi");
        $mumu_youxi = $mumu_youxi_table->where(array('id' => $id))->find();

        $this->assign("mumu_youxi",$mumu_youxi);
        $this->assign("id",$id);


        $this->display('admin/mumu_youxi_update');
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

            $mumu_youxi_table = new FTable("mumu_youxi");
            $mumu_youxi_table->insert($data2);

            $this->showMessage("添加成功","success","/MumuYouxi/list");
            return;
        }

        $this->display('admin/mumu_youxi_add');
    }


}