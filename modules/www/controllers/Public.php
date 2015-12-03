<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-9
 * Time: 下午8:26
 */
class Controller_Www_Public extends Controller_Www_Abstract
{
//    /**
//     * 用户注册
//     */
//    public function regAction()
//    {
//        global $_F;
//
//        if ($this->isPost()) {
//            $username = FRequest::getPostString('username');
//            $password = FRequest::getPostString('password');
//            $gender = FRequest::getPostInt('gender');
//
//            $param = array(
//                'username' => $username,
//                'password' => $password,
//                'gender' => $gender
//            );
//            //"username={$username}&password={$password}&gender={$gender}";
//            $http = new FHttp();
//            $html = $http->_post("http://api2.app.yuanfenba.net/user2/reg", $param);
//            echo($html);
//            exit;
//        }
//        $this->display('registered');
//    }
//
//    /**
//     * 用户登录
//     */
//    public function loginAction()
//    {
//        global $_F;
//
//        // {{{ POST 操作
//        if ($this->isPost()) {
//            $username = FRequest::getPostString('username');
//            $password = FRequest::getPostString('password');
//
//            $param = array(
//                'username' => $username,
//                'password' => $password,
//            );
//            //"username={$username}&password={$password}";
//            $http = new FHttp();
//            $html = $http->_post("http://api2.app.yuanfenba.net/user2/login", $param);
//
//            $json = json_decode($html, true);
//            if ($json['result'] == 'success') {
//                FCookie::set('mumu_auth', $json['content'] . "\t" . $check_auth = md5("{$json['content']}|{$username}"), 7 * 24 * 3600);
//            }
//
//            echo($html);
//            exit;
//        }
//        // }}}
//        $this->display('sign');
//    }

    /**
     * 用户协议
     */
    public function protocolAction()
    {
        $this->display('protocol');
    }

}
