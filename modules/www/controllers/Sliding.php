<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-9
 * Time: 下午8:26
 */
class Controller_Www_Sliding extends Controller_Www_Abstract
{

    public function defaultAction()
    {
        //global $_F;
        //$_F["debug"] = true;

        $url = FRequest::getString('url');
        $this->assign('url', $url);
        $this->display('sliding');
    }

}
