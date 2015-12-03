<?php

/**
 * Created by PhpStorm.
 * User: caofei
 * Date: 14-7-2
 * Time: 16:42
 */
class Controller_Admin_Group extends Controller_Admin_Abstract {
    public function beforeAction(){
        parent::beforeAction();
        $this->db_group = new  FTable('manager_group');
    }

	public function deleteAction() {
        $gid = FRequest::getInt('gid');
        $where = array('gid' => $gid);
        $managerList =  $this->db_group->where($where)->remove(true);
        FResponse::refresh();
    }
    public function addAction() {
        if ($this->isPost()) {
            $group = $_POST['group'];
            $result=$this->db_group->insert($group);
                return $this->success('添加成功！','/admin/group/list');
        }else{
            echo("111");
           // $this->assign('action','add');
            //$this->display('admin/group-list');
        }
    }

    public function modifyAction() {
        if ($this->isPost()) {
            $group = $_POST['group'];
            $result=$this->db_group->update($group, array('gid'=>$_POST['gid']));
            if($result){
                return $this->success('修改成功！','/admin/group/list');
            }
        }
        $action='modify';
        $this->assign('action',$action);
        $where=array('gid'=>FRequest::getInt('gid'));
        $group_info = $this->db_group->where($where)->find();

        $this->assign('group_info', $group_info);
        $this->display('admin/group-add');
    }

}