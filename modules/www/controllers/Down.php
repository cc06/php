<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Down extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        global $_F;

        $url = "http://down.mumu123.cn/mumu/MuMu_1617_1000_6_1.005.apk";
        $mumu_auth = FCookie::get('mumu_auth');
        $v = FRequest::getString('v');
        if ($v) {
            FResponse::redirect($url);
        } else {
            if ($mumu_auth) {
                FResponse::redirect($url);
            } else {
                FResponse::redirect('/public/reg');
            }
        }

    }
}