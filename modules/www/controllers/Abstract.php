<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午9:17
 */
class Controller_Www_Abstract extends FController {

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
        $uid = FCookie::get("uid");
        $sid = FCookie::get("key");
        $table = new FTable("user_main");
        $user = $table->fields(array("sid"))->where(array("uid"=>$uid))->find();
        $_F["uid"] =$uid;
        return $user["sid"] == $sid ;
    }

    function showMessage($message, $url = null)
    {
        // TODO: Implement showMessage() method.
    }
}