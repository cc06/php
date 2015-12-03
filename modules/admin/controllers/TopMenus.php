<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/17
 * Time: 上午10:20
 */
class Controller_Admin_TopMenus extends  Controller_Admin_Abstract{
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

            if ($this->isPost()) {

                $name = FRequest::getPostString('name');
                $menu = FRequest::getPostString('menu');

                $data2 = array(
                    'name' => $name,
                    'menu' => $menu
                );
                $TopMenus = new FTable("top_menus");
                $TopMenus->insert($data2);

                $this->showMessage("创建成功" ,$messageType = 'success' ,"/TopMenus/list");
                return;
            }

            $this->display('admin/top_menus_add');
        }


    function listAction(){
        //global $_F;
        //$_F["debug"] = true;

        $page = max(1, FRequest::getInt('page'));

        $table = new FTable("top_menus","tm");
        $top_menus = $table->fields(array(
            "tm.id",
            "tm.name",
            "tm.menu"
        )) ->page($page)->limit(20)->order(array("tm.id"=>"asc"))->select();

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign("top_menus",$top_menus);
        $this->display('admin/top_menus_list');
    }

    /**
     * 修改
     */
    function  updateAction(){
        //global $_F;
       // $_F["debug"] = true;

        $topid = FRequest::getInt("topid");
        if ($this->isPost()) {

            $name = FRequest::getPostString('name');
            $menu = FRequest::getPostString('menu');
            $data2 = array(
                'name' => $name,
                'menu' => $menu
            );
            $top_menus = new FTable("top_menus");
            $top_menus->where(array('id' => $topid))->update($data2);

            $this->showMessage("修改成功" ,$messageType = 'success' ,"/TopMenus/list");
            return;
        }

        $top_menus = new FTable("top_menus");
        $top_menu = $top_menus->where(array('id' => $topid))->find();

        $this->assign("top_menu",$top_menu);
        $this->assign("topid",$topid);
        $this->display('admin/top_menus_update');
    }

    public function deleteAction() {
        $top_menus = new FTable('top_menus');
        $topid = FRequest::getInt('topid');
        $top_menus->where(array('id' => $topid))->remove(true);
        FResponse::redirect('r');
    }

}