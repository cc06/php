<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Pipei2 extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        global $_F;

        $url = FRequest::getString('url');
        $gender = FRequest::getString('gender');

        $this->assign('url',$url);
        $this->assign('gender',$gender);
        $this->assign('title','匹配');
        $this->display('zhanbu2');
    }
}