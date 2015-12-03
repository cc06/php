<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午9:17
 */
class Controller_Upload_Abstract extends FController {

    public function beforeAction() {
        global $_F;

        $this->assign('top_nav', $_F['uri']);

        return true;
    }



    /**
     * 返回用户是登录状态
     * @return bool
     */
    protected function isLogin() {
        global $_F;

        return $_F['uid'] ? true : false;
    }

    function showMessage($message, $url = null)
    {
        // TODO: Implement showMessage() method.
    }
}