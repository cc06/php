<?php
/**
 * Created by PhpStorm.
 * User: john
 * Date: 2015/10/23
 * Time: 16:31
 */

class Service_Menus {

    public static function getTopMenus() {

        global $_F;
        $manager_table = new FTable("manager");
        $manager = $manager_table->where(array('uid' =>$_F["uid"]))->find();

        $top_menus_ids = explode(",", $manager['top_menus_id']);
        $top_menus=array();
        foreach($top_menus_ids as &$top_menus_id) {

            $top_menus_table = new FTable("top_menus");
            $top_menus1 = $top_menus_table->fields(array("name", "id","menu"))->where(array("id" => $top_menus_id))->find();
            array_push($top_menus,$top_menus1);
        }


        return $top_menus;
    }
    public static function getLeftMenus($top) {

        global $_F;
        $manager_table = new FTable("manager");
        $manager = $manager_table->where(array('uid' =>$_F["uid"]))->find();

        $top_menus_ids = explode(",", $manager['top_menus_id']);
        $left_menus_ids = explode(",", $manager['left_menus_id']);



        /*$left_menus=array();
        $left_menus['default'] =array(
            array('name' => '创建幕幕帐号', 'url' => '/admin/YUser/add', 'url_jian' => '/admin/YUser/add'),
            array('name' => '在线用户', 'url' => '/admin/Online/default', 'url_jian' => '/admin/Online/default')
        );
        foreach($top_menus_ids as &$top_menus_id) {
            $left_menus_x=array();
            $top_menus_table = new FTable("top_menus");
            $top_menus1 = $top_menus_table->fields(array("name", "id","menu"))->where(array("id" => $top_menus_id))->find();
            $left_menus_table = new FTable("left_menus");
            $left_menus1 = $left_menus_table->fields(array("name", "url"))->where(array("top_menus_id" => $top_menus1['id'],"id"=>array('in' => $left_menus_ids)))->select();
            // $left_menus_x[$top_menus1['menu']]=$left_menus1;
            // array_push($left_menus[$top_menus1['menu']],$left_menus1);

            foreach($left_menus1 as &$left_menus12){
                $left=explode("/",$left_menus12["url"]);
                $left_menus12["url_jian"] = "/".$left[1]."/".$left[2]."/";
            }
            $left_menus[$top_menus1['menu']]=$left_menus1;
        }
         echo(json_encode($left_menus));
        $menuArray =$left_menus;




        $menuItems = $menuArray[$top];*/

        $left_menus_table = new FTable("left_menus");
        $left_menus1 = $left_menus_table->fields(array("name", "url"))->where(array("menu" => $top,"id"=>array('in' => $left_menus_ids)))->select();

        foreach($left_menus1 as &$left_menus12){
            $left=explode("/",$left_menus12["url"]);
            $left_menus12["url_jian"] = "/".$left[1]."/".$left[2]."/";
        }
        $menuItems = $left_menus1;


        return $menuItems;
    }
}