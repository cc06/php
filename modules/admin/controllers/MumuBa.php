<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/27
 * Time: 10:00
 */
class Controller_Admin_MumuBa extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 列表
     */
        function  listAction(){
           // global $_F;
           // $_F["debug"] = true;

            $page = max(1, FRequest::getInt('page'));
            $where = array();

            $shanchu_id = FRequest::getInt('shanchu_id');
            if ($shanchu_id) {
                $mumu_bas = new FTable('mumu_ba');
                $mumu_bas->where(array('id' => $shanchu_id))->remove(true);
            }


            $table = new FTable("mumu_ba");
            $mumu_bas = $table->fields(array(
                "id",
                "title",
                "text",
                "pic",
                "riqi",
                "position"
            ))
                ->where($where)->page($page)->limit(20)->order(array("id"=>"desc"))->select();

            foreach($mumu_bas as &$mumu_ba){

                $mumu_ba["pic"] = CommonUtil::getMoreSizeImg($mumu_ba["pic"],100,100);
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('mumu_ba', $mumu_bas);
            $this->display('admin/mumu_ba_list');
        }

    /**
     * 修改
     */
    function  updateAction(){

        $id = FRequest::getInt("id");
        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $pic = FRequest::getPostString('pic');
            $riqi = date("Y-m-d", time());
            $title = FRequest::getPostString('title');

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
                'riqi' =>  $riqi

            );

            $mumu_ba_table = new FTable("mumu_ba");
            $mumu_ba_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改成功","success","/MumuBa/list");
            return;
        }
        $mumu_ba_table = new FTable("mumu_ba");
        $mumu_ba = $mumu_ba_table->where(array('id' => $id))->find();

        $this->assign("mumu_ba",$mumu_ba);
        $this->assign("id",$id);


        $this->display('admin/mumu_ba_update');
    }
    /**
     * 添加
     */
    function  addAction(){


        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $riqi = date("Y-m-d", time());
            $pic = FRequest::getPostString('pic');

            $title = FRequest::getPostString('title');


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
                'riqi' =>  $riqi

            );

            $mumu_ba_table = new FTable("mumu_ba");
            $mumu_ba_table->insert($data2);

            $this->showMessage("添加成功","success","/MumuBa/list");
            return;
        }

        $this->display('admin/mumu_ba_add');
    }


}