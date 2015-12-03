<?php

/**
 * Created by PhpStorm.
 * User: fanshengshuai
 * Date: 14-7-2
 * Time: 16:45
 */
class Controller_Admin_Auction extends Controller_Admin_Abstract {
    public function listAction() {
        global $_F;

        $this->display('admin/auction-list');
    }

    public function logAction() {
        global $_F;

        $page = FRequest::getInt('page');


        $actionLogTable = new FTable('auction_log');

        $where = array('status' => 1);
        $actionList = $actionLogTable->where($where)->page($page)->limit(50)->select();
        $pagerInfo = $actionLogTable->getPagerInfo();

        $this->assign('page_info', $pagerInfo);

        $this->assign('auction_logs', $actionList);
        $this->display('admin/auction-log');
    }

}