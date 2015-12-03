<?php

/**
 * Created by PhpStorm.
 * User: fanshengshuai
 * Date: 14-7-2
 * Time: 16:37
 */
class Controller_Admin_Manager extends Controller_Admin_Abstract {

    public function beforeAction(){
        parent::beforeAction();
        $this->db_manager=new  FTable('manager');
        $this->db_manager_group=new  FTable('manager_group');

        return true;
    }

    public function listAction() {
        global $_F;
        /*$top_menus = Service_Menus::getTopMenus();
        $menuItems = Service_Menus::getLeftMenus();

        $this->assign('top_menus', $top_menus);
        $this->assign('menuItems', $menuItems);*/

        $page = FRequest::getInt('page');

        $where = "status=1";

        $w = trim($_REQUEST['search']);

        $where = "status=1";
        if ($w) {
            if (preg_match('#^\d+$#', $w)) {
                $where .= " and uid='{$w}'";
            } else {
                $where .= " and username like '%{$w}%'";
            }
        }
       // $managerTable = new FTable('manager');
        $managerList = $this->db_manager->page($page)->where($where)->limit(30)->select();

        $pagerInfo = $this->db_manager->getPagerInfo();

        $this->assign('page_info', $pagerInfo);

        $this->assign('managerList', $managerList);

        $this->display('admin/manager-list');
    }
    public function checkusernameAction() {
        $where = array( 'username' => $_POST['manager']['username']);
        $isreal = $this->db_manager->where($where)->find();
        if($isreal){
            $arr=array(
                'state'=>0,
                'message'=>'用户名已存在'
            );
            echo json_encode($arr);
        }else{
            $arr=array(
                'state'=>1,
                'message'=>'可以注册'
            );
            echo json_encode($arr);
        }
        die;

    }

    public function addAction() {
        global $_F;
        $_F["debug"] = true;
        if($this->isPost()){
            $manager=$_POST['manager'];
            $password=FRequest::getPostString('password');
            $manager['password']=md5($password);
            if(trim($manager[username])==''){
                return $this->error('用户名不能为空！','/admin/manager/edit');
            }
            if(trim($manager[email])==''){
                return $this->error('邮箱不能为空！','/admin/manager/edit');
            }
            if($password==''){
                return $this->error('密码不能为空！','/admin/manager/edit');
            }
            $username = FDB::fetch("select username from manager where username ='".$manager[username]."'");
            if($username){
                return $this->error('用户名重复！','/admin/manager/edit');
            }
            $email = FDB::fetch("select email from manager where email ='".trim($manager[email])."'");
            if($email){
                return $this->error('邮箱重复！','/admin/manager/edit');
            }
            // 添加管理员用户
            $user_id = Service_Edit::addUser();
            if($user_id <=0){
                return $this->error('添加管理员失败','/admin/manager/edit');
            }
            $manager["user_id"] = $user_id;
            $quanxianid = FRequest::getPostString('quanxianid');
            $quanxianidx = FRequest::getPostString('quanxianidx');

            if($quanxianid&&count($quanxianid)>0){
                $top_menus_id = implode(",",$quanxianid);
            }

            if($quanxianidx&&count($quanxianidx)>0){
                $left_menus_id = implode(",",$quanxianidx);
            }

            $manager['top_menus_id']=$top_menus_id;
            $manager['left_menus_id']=$left_menus_id;
            $result=$this->db_manager->insert($manager);
            if($result){
                return $this->success('添加成功！','/admin/manager/list');
            }
        }
    }

    public function deleteAction() {
        $uid = FRequest::getInt('uid');
        $where = array('uid' => $uid);
        $managerList = $this->db_manager->where($where)->remove(true);

        FResponse::redirect('/admin/manager/list');
    }
    public function editAction() {


        if(FRequest::isPost()){
            $manager=$_POST['manager'];
            $id=FRequest::getPostInt('id');
            $password=FRequest::getPostString('password');
            if($password){
                $manager['password']=md5($password);
            }
             $quanxianid = FRequest::getPostString('quanxianid');
             $quanxianidx = FRequest::getPostString('quanxianidx');

           if($quanxianid&&count($quanxianid)>0){
                 $top_menus_id = implode(",",$quanxianid);
             }

             if($quanxianidx&&count($quanxianidx)>0){
                 $left_menus_id = implode(",",$quanxianidx);
             }

             $manager['top_menus_id']=$top_menus_id;
             $manager['left_menus_id']=$left_menus_id;

            $result=$this->db_manager->update($manager, array('uid'=>$_POST['id']));
            if($result){
                return $this->success('修改成功！','/admin/manager/list');
            }else{
                return $this->error("342");
            }
        }else{
            $uid = FRequest::getInt('uid');
            $status=array(
                '启用'=>'1',
                '禁用'=>'0'
            );
            //获取用户组
            $group=array();
            $manager_group = $this->db_manager_group->select();
            foreach($manager_group as $v){
                $group[$v['name']]=$v['gid'];
            }
            $this->assign('group',$group);
            $this->assign('status',$status);
            $action='add';
            if($uid){
                $action='edit';
                $where = array('uid' => $uid);
                $manager = $this->db_manager->where($where)->find();
                $this->assign('manager',$manager);
            }

            /*$top_menus_table = new FTable("top_menus");
            $top_menus = $top_menus_table->fields(array("name","id"))->select();

            foreach($top_menus as &$top_menu){

                $left_menus_table = new FTable("left_menus");
                $left_menus = $left_menus_table->fields(array("name","id"))->where(array("top_menus_id"=>$top_menu["id"]))->select();
                $top_menu["left_menus"]=$left_menus;

            }
            // echo(json_encode($top_menus));
            $this->assign('top_menus',$top_menus);*/


             $top_menus_ids = explode(",", $manager['top_menus_id']);
             $left_menus_ids = explode(",", $manager['left_menus_id']);
            $top_menus_table = new FTable("top_menus");
            $top_menus = $top_menus_table->fields(array("name","id"))->select();

            foreach($top_menus as &$top_menu){

                $isin = in_array($top_menu['id'],$top_menus_ids);
                if($isin){
                    $top_menu["checked"]="checked";
                } else {
                    $top_menu["checked"]="";
                }

                $left_menus_table = new FTable("left_menus");
                $left_menus = $left_menus_table->fields(array("name","id"))->where(array("top_menus_id"=>$top_menu["id"]))->select();
                foreach($left_menus as &$left_menu) {

                    $isin = in_array($left_menu['id'],$left_menus_ids);
                    if($isin){
                        $left_menu["checked"] = "checked";
                    } else {
                        $left_menu["checked"] = "";
                    }
                }
                $top_menu["left_menus"]=$left_menus;

            }
            // echo(json_encode($top_menus));
            $this->assign('top_menus',$top_menus);



            $this->assign('action',$action);
            $this->display('admin/manager-add');
        }
    }

	public function groupAction() {
		global $_F;

        $groupTable = new  FTable('manager_group');
        $groupList = $groupTable->select();

		$this->assign('groupList', $groupList);
		$this->display('admin/manager-group-list');
	}
}
