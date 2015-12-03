<?php

/**
 * Abstract
 * 作者: 范圣帅(fanshengshuai@gmail.com)
 * Time-stamp: <root 07/25/2014 16:53:34>
 */
class Controller_Admin_Abstract extends FController {

    public function beforeAction() {
        global $_F;
       // $_F["debug"] = true;
//        phpinfo();exit;

//        if ($_GET['session_id']) {
////            session_destroy();
//            session_write_close();
//
//            session_id($_GET['session_id']);
//            session_start();
//        }


        $_F['domain'] = "/";

        $setting_keys = array('www_url', 'static_url');
        $settings = Service_Setting::get($setting_keys);

        $_F['s_url'] = $settings['static_url'] ? trim($settings['static_url'], '/') : '';
        $_F['www_url'] = $settings['www_url'];
        if (
            $_F['controller'] != 'Controller_Admin_Auth'
            &&
            ($_F['controller'] != 'Controller_Admin_Video' && $_F['action'] != 'quickAdd')
        ) {
            $this->checkAuth();
        }
        if (!$_F['permits']['admin']) {
            return $this->error('没有 ADMIN 权限');
        }

        $menuInit = FRequest::getString('menu');
        $query = $_SERVER['REQUEST_URI'];
        //echo($query);
        $left=explode("/",$query);
        $left="/".$left[1]."/".$left[2]."/";
        //$query_str= " url like '%".$left."%'  ";
        //$where["str"] = " name like %".$left."% ";
        if ($menuInit||$query=="/"||$query=="/admin") {
            $menuInit = explode('/', $menuInit);

            if (!$menuInit[0]||$query=="/"||$query=="/admin") {
                $menuInit[0] = 'default';
            }
        } else {
            $where = array();
            $where["url"] = array('like'=> $left);
            $left_menus_table = new FTable("left_menus");
            $left_menus1 = $left_menus_table->fields(array("top_menus_id"))->where($where)->find();

            $top_menus_table = new FTable("top_menus");
            $top_menus1 = $top_menus_table->fields(array("name", "id","menu"))->where(array("id" => $left_menus1['top_menus_id']))->find();
            $menuInit[0] = $top_menus1['menu'];
            //echo($menuInit[0]);
        }
        //echo($menuInit[0]);
        $top_menus = Service_Menus::getTopMenus();
        $menuItems = Service_Menus::getLeftMenus($menuInit[0]);
        $query = $_SERVER['REQUEST_URI'];

        $this->assign('top_menus', $top_menus);
        $this->assign('menuItems', $menuItems);
//echo(FRequest::getString('menu'));

        if (FRequest::getString('menu')) {
            $top_class= "sidebar-left-opened";
        } else {
            $top_class="";
        }
        //echo($top_class);
        $this->assign('top_class', $top_class);
        $this->assign('menu', $menuInit[0]);
        $this->assign('left', $left);
        return true;
    }

    protected function checkAuth() {
        $auth_info = Service_Manager::getSessionData();
        if (!$auth_info) {
            FResponse::redirect('/admin/auth/login');
        }
        return true;
    }

    function showMessage($message, $messageType = 'success', $jumpUrl = null) {

        if ($messageType == 'error') {
            $messageType = 'warning';
        }

        $this->assign('messageType', $messageType);
        $this->assign('message_content', $message);
        $this->assign('jump_url', $jumpUrl);
        $this->display('admin/message');

        return true;
    }

    function display($tpl = null) {
        parent::display(str_replace('admin/', '', $tpl));
    }

    /**
     * 客户端接口统一输出json结构
     */
    function print_com($results,$msg="success",$code=200,$res=array()) {
        $result = array('result' => $results);
        $result['msg'] = $msg;
        $result['code'] = $code;
        $result['content'] = $res;
        // 获取系统时间
        //$sysTm =  Service_Common::getSysTm();
        //$result["sys_tm"] = $sysTm;
        ob_clean();
        //header("Content-Type: application/json; charset=UTF-8");
        //echo '{"result":"failed","items":{"real_name":"\u4e0d\u80fd\u4e3a\u7a7a","username":"\u4e0d\u80fd\u4e3a\u7a7a","id_card":"\u4e0d\u80fd\u4e3a\u7a7a","phone":"\u4e0d\u80fd\u4e3a\u7a7a","email":"\u4e0d\u80fd\u4e3a\u7a7a","good_at":"\u4e0d\u80fd\u4e3a\u7a7a","join_date":"\u4e0d\u80fd\u4e3a\u7a7a","comment":"\u4e0d\u80fd\u4e3a\u7a7a","teacher_Frade":"\u4e0d\u80fd\u4e3a\u7a7a"}}';
        //exit;
        FResponse::output(json_encode($result));
        exit;
    }

}
