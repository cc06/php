<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/17
 * Time: 上午10:20
 */
class Controller_Admin_LeftMenus extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 添加地址
     */
        function  addAction(){
            //global $_F;
           // $_F["debug"] = true;
            $topid = FRequest::getInt("topid");
            $top_menus = new FTable("top_menus");
            $top_menus_menu = $top_menus->fields(array("menu","name"))->where(array("id"=>$topid))->find();

            if ($this->isPost()) {


                $name = FRequest::getPostString('name');
                $url = FRequest::getPostString('url');

                $data2 = array(
                    'name' => $name,
                    'menu' => $top_menus_menu['menu'],
                    'url' => $url,
                    'top_menus_id' => $topid
                );
                $LeftMenus = new FTable("left_menus");
                $LeftMenus->insert($data2);

                $this->showMessage("创建成功" ,$messageType = 'success' ,"/LeftMenus/list?topid=".$topid);
                return;
            }

            $this->assign("topid",$topid);
            $this->assign("top_menus_menu",$top_menus_menu);
            $this->display('admin/left_menus_add');
        }


    function listAction(){
        //global $_F;
        //$_F["debug"] = true;

        $page = max(1, FRequest::getInt('page'));
        $topid = FRequest::getInt("topid");
        $top_menus = new FTable("top_menus");
        $top_menus_menu = $top_menus->fields(array("menu","name"))->where(array("id"=>$topid))->find();

        $table = new FTable("left_menus","fm");
        $left_menus = $table->fields(array(
            "fm.id",
            "fm.name",
            "fm.menu",
            "fm.url"
        )) ->where(array("top_menus_id"=>$topid ))->page($page)->limit(20)->order(array("fm.id"=>"asc"))->select();

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign("left_menus",$left_menus);

        $this->assign("topid",$topid);
        $this->assign("top_menus_menu",$top_menus_menu);
        $this->display('admin/left_menus_list');
    }

    /**
     * 修改
     */
    function  updateAction(){
        //global $_F;
       // $_F["debug"] = true;
        $topid = FRequest::getInt("topid");
        $top_menus = new FTable("top_menus");
        $top_menus_menu = $top_menus->fields(array("menu","name"))->where(array("id"=>$topid))->find();

        $leftid = FRequest::getInt("leftid");
        if ($this->isPost()) {

            $name = FRequest::getPostString('name');
            $url = FRequest::getPostString('url');
            $data2 = array(
                'name' => $name,
                'menu' => $top_menus_menu['menu'],
                'url' => $url
            );
            $left_menus = new FTable("left_menus");
            $left_menus->where(array('id' => $leftid,'top_menus_id' => $topid ))->update($data2);

            $this->showMessage("修改成功" ,$messageType = 'success' ,"/LeftMenus/list?topid=".$topid);
            return;
        }

        $left_menus = new FTable("left_menus");
        $left_menu = $left_menus->where(array('id' => $leftid))->find();

        $this->assign("left_menu",$left_menu);
        $this->assign("topid",$topid);
        $this->assign("leftid",$leftid);
        $this->assign("top_menus_menu",$top_menus_menu);
        $this->display('admin/left_menus_update');
    }

    public function deleteAction() {
        $left_menus = new FTable('left_menus');
        $topid = FRequest::getInt("topid");
        $leftid = FRequest::getInt('leftid');
        $left_menus->where(array('id' => $leftid,'top_menus_id' =>$topid))->remove(true);
        FResponse::redirect('r');
    }

}