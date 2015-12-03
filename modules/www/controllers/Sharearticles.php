<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Sharearticles extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        //global $_F;
        //$_F["debug"] = true;


        $id = FRequest::getInt('id');


        $this->assign('id',$id);
        $this->display('sharearticles');
    }
}