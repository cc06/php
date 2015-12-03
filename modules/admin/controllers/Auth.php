<?php

/**
 *
 * 作者: 范圣帅(fanshengshuai@gmail.com)
 * 时间: 2012-07-02 01:22:18
 *
 * vim: set expandtab sw=4 ts=4 sts=4
 * $Id: $
 */
class Controller_Admin_Auth extends FController {

    public function loginAction() {
        global $_F;
       // $_F['debug'] = 1;
        if ($this->isPost()) {
            $username = trim($_POST['username']);
            $password = trim($_POST['password']);

            /*$checkCode = FRequest::getPostString('check_code');

            if (!$checkCode) {
                return $this->error('请输入验证码！');
            }*/

            session_start();
//            if ($checkCode != $_SESSION['rand_code']) {
//                return $this->error('验证码错误！');
//            }

            $refer = trim($_POST['refer']);
            if (strpos($refer, 'login')) {
                $refer = null;
            }

            $managerTable = new FTable('manager');

            $encryptPassword = Service_Manager::getEncryptPassword($password);
            $managerData = $managerTable->where(array('username' => $username))->find();

            $managerLoginLogTable = new FTable('manager_login_log');

            $newLoginLogData = array(
                'username' => $username,
                'login_time' => date('Y-m-d H:i:s'),
                'login_ip' => FRequest::getClientIP(),
            );

            if (!$managerData) {
                $newLoginLogData['result'] = 2;
                $newLoginLogData['comment'] = '用户名不存在';
                $managerLoginLogTable->insert($newLoginLogData);

                return $this->error('用户名不存在！');
            } else {
                if ($managerData['password'] == $encryptPassword) {
                    $user_id = $managerData['user_id'];
                    // 获取管理员user_id 和 密钥
                    $user_table = new FTable("user_main");
                    $user = $user_table->where(array("uid"=>$user_id))->find();

//                    $auth_str = md5("{$managerData['username']}|{$managerData['password']}|{$managerData['gid']}");
                    FSession::set('manager_uid', $managerData['uid']);
                    FSession::set('user_id', $user_id);
                    FSession::set('sid', $user['sid']);

                    // 更新登录时间
                    $managerTable->where(array("uid" => $managerData['uid']))
                        ->update(array('last_login_time' => date('Y-m-d H:i:s')));

                    $newLoginLogData['uid'] = $managerData['uid'];
                    $newLoginLogData['result'] = 1;
                    $managerLoginLogTable->insert($newLoginLogData);

//                    FCookie::set('manager_auth', "{$managerData['uid']}\t{$auth_str}", 3600000);

                    FResponse::redirect('/');
                    return true;
                } else {

                    $newLoginLogData['result'] = 2;
                    $newLoginLogData['comment'] = '密码错误';
                    $managerLoginLogTable->insert($newLoginLogData);

                    return $this->error('对不起，密码错误！');
                }

            }
        }
       $this->display('admin/login');
    }

    public function logoutAction() {
        Service_Manager::removeSession();
        FResponse::redirect('/');
    }

    function showMessage($message, $messageType = 'success', $jumpUrl = null) {

        $this->assign('messageType', $messageType);
        $this->assign('message_content', $message);
        $this->assign('jump_url', $jumpUrl);
        $this->display('admin/message');
    }

    function display($tpl) {
        parent::display(str_replace('admin/', '', $tpl));
    }
}
