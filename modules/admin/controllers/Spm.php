<?php

class Controller_Admin_Spm extends Controller_Admin_Abstract {
    public function indexAction() {
        global $_F;
//        $_F['debug'] = 1;
        $page = max(1, FRequest::getInt('page'));
        $spmT = new FTable('stats_spm');
        $spmList = $spmT->order(array('id' => 'desc'))->page($page)->limit(20)->select();
        $this->assign('page_info', $spmT->getPagerInfo());
        $this->assign('spmList', $spmList);
        $this->display('admin/spm-index');
    }

    public function addAction() {
        $spmT = new FTable('stats_spm');
        if ($this->isPost()) {
            $auto_id = FRequest::getPostInt('id');
            $spm = FRequest::getPostString('spm');
            $url = FRequest::getPostString('url');
            $spm_name = FRequest::getPostString('spm_name');
            $text = "";
            if ($auto_id) {
                $spmT->where(array('id' => $auto_id))->update(array('spm' => $spm, 'url' => $url, 'spm_name' => $spm_name));
                $text = "修改成功";
            } else {
                $spmT->insert(array('spm' => $spm, 'url' => $url,  'spm_name' => $spm_name));
                $text = "添加成功";
            }
            return $this->success($text, '/admin/spm/index');
        }
        $auto_id = FRequest::getInt('id');
        $spmData = $spmT->where(array('id' => $auto_id))->find();
        if ($spmData) {
            $this->assign('spmData', $spmData);
        }
        $this->display('admin/spm-add');
    }

    public function deleteAction() {
        $spmT = new FTable('stats_spm');
        $auto_id = FRequest::getInt('id');
        $spmT->where(array('id' => $auto_id))->remove(true);
        FResponse::redirect('r');
    }

}