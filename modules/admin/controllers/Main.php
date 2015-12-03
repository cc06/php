<?php

/**
 * 创建: 2012-08-05 16:16:30
 * vim: set expandtab sw=4 ts=4 sts=4 *
 */
class Controller_Admin_Main extends Controller_Admin_Abstract {

    public function indexAction() {

        /*$top_menus = Service_Menus::getTopMenus();
        $menuItems = Service_Menus::getLeftMenus();

        $this->assign('top_menus', $top_menus);
        $this->assign('menuItems', $menuItems);*/
        $this->display('admin/index');
    }

    public function mainAction() {
        $this->display('admin/main');
    }

    public function borderAction() {
        $this->display('admin/border');
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
