<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Index extends Controller_Www_Abstract
{
    public function defaultAction()
    {
       // global $_F;
        //$_F["debug"] = true;

        $c_uid = FRequest::getString('c_uid');
        $c_sid = FRequest::getString('c_sid');

        if ($c_uid&&$c_sid) {
            $this->assign('xiazai', 'http://service.imswing.cn/common/Download?c_uid='.$c_uid.'&c_sid='.$c_sid);
        } else {
            $this->assign('xiazai', 'http://service.imswing.cn/common/Download?c_uid=8000&c_sid=1001');
        }



        $this->assign('c_uid', $c_uid);
        $this->assign('c_sid', $c_sid);
        if (self::isMobile()) {
            $this->display('m');
        } else {
            $this->display('index');
        }

    }
    /**

     *判断是否是通过手机访问
     *

     */

    public static function isMobile() {

// 如果有HTTP_X_WAP_PROFILE则一定是移动设备

        if (isset ($_SERVER['HTTP_X_WAP_PROFILE'])) {

            return true;

        }

//如果via信息含有wap则一定是移动设备,部分服务商会屏蔽该信息

        if (isset ($_SERVER['HTTP_VIA'])) {

//找不到为flase,否则为true

            return stristr($_SERVER['HTTP_VIA'], "wap") ? true : false;

        }

//判断手机发送的客户端标志,兼容性有待提高

        if (isset ($_SERVER['HTTP_USER_AGENT'])) {

            $clientkeywords = array (

                'nokia',

                'sony',

                'ericsson',

                'mot',

                'samsung',

                'htc',

                'sgh',

                'lg',

                'sharp',

                'sie-',

                'philips',

                'panasonic',

                'alcatel',

                'lenovo',

                'iphone',

                'ipod',

                'blackberry',

                'meizu',

                'android',

                'netfront',

                'symbian',

                'ucweb',

                'windowsce',

                'palm',

                'operamini',

                'operamobi',

                'openwave',

                'nexusone',

                'cldc',

                'midp',

                'wap',

                'mobile'

            );

// 从HTTP_USER_AGENT中查找手机浏览器的关键字

            if (preg_match("/(" . implode('|', $clientkeywords) . ")/i", strtolower($_SERVER['HTTP_USER_AGENT']))) {

                return true;

            }

        }

//协议法，因为有可能不准确，放到最后判断

        if (isset ($_SERVER['HTTP_ACCEPT'])) {

// 如果只支持wml并且不支持html那一定是移动设备

// 如果支持wml和html但是wml在html之前则是移动设备

            if ((strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') !== false)
                && (strpos($_SERVER['HTTP_ACCEPT'], 'text/html') === false ||
                    (strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') <
                        strpos($_SERVER['HTTP_ACCEPT'], 'text/html')))) {

                return true;

            }

        }

        return false;

    }


    /**
     * 统计
     */
   /* function WebStatAction(){
        $c_uid = FRequest::getString("c_uid");
        $c_sid = FRequest::getString("c_sid");
        $action = FRequest::getInt("action"); //1  包下载点击，10  pc官网曝光  www.imswing.cn，11  wap官网曝光
        if ($c_uid) {
            if (!$c_sid) {
                $c_sid=0;
            }
        } else {
            $c_uid=8000;
            $c_sid=1001;
        }

        //请求服务端接口
        $url =  FConfig::get('global.service_mumu_url')."/admin/WebStat";
        $res = FHttp::get($url."?cuid=".$c_uid."&csid=".$c_sid."&action=".$action);
         FResponse::output(json_encode($res));
    }*/
}
