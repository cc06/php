<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/17
 * Time: 上午10:20
 */
class Controller_Admin_YUserAddress extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 添加地址
     */
        function  addAction(){
            //global $_F;
           // $_F["debug"] = true;
            $uid = FRequest::getInt("uid");
            if ($this->isPost()) {

                $username = FRequest::getPostString('username');
                $phone = FRequest::getPostString('phone');
                $province = FRequest::getPostString('province');
                $city = FRequest::getPostString('city');
                $address = FRequest::getPostString('address');
                $data2 = array(
                    'uid' => $uid,
                    'username' => $username,
                    'phone' => $phone,
                    'province' => $province,
                    'city' => $city,
                    'address' => $address
                );
                $user_detail_table = new FTable("user_address");
                $user_detail_table->insert($data2);

                $this->showMessage("创建成功" ,$messageType = 'success' ,"/YUserAddress/list?uid=".$uid);
                return;
            }

                $this->assign("uid",$uid);
            $this->display('admin/y_user_address_add');
        }

    //获取当前用户的名下的所有地址
    function listAction(){
        global $_F;
        //$_F["debug"] = true;



        $admin_uid = FSession::get('manager_uid');
        $uid = FRequest::getInt("uid");

        $page = max(1, FRequest::getInt('page'));

        $user_table = new FTable("user_detail");
        $user_nickname = $user_table->fields(array("nickname"))->where(array("uid"=>$uid))->find();


        $where = array(
            'uadd.uid'=> $uid
        );


        $table = new FTable("user_address","uadd");
        $useradds = $table->fields(array(
            "uadd.uid",
            "uadd.addrid",
            "uadd.phone",
            "uadd.province",
            "uadd.city",
            "uadd.address",
            "uadd.username"
        )) ->where($where)->page($page)->limit(20)->order(array("uadd.addrid"=>"desc"))->select();

        $page_info = $table->getPagerInfo();
        $this->assign('page_info', $page_info);
        $this->assign("useradds",$useradds);
        $this->assign("uid",$uid);
        $this->assign("user_nickname",$user_nickname['nickname']);
        $this->display('admin/y_user_address_list');
    }

    /**
     * 修改地址
     */
    function  updateAction(){
        //global $_F;
       // $_F["debug"] = true;
        $uid = FRequest::getInt("uid");
        $addrid = FRequest::getInt("addrid");
        if ($this->isPost()) {

            $username = FRequest::getPostString('username');
            $phone = FRequest::getPostString('phone');
            $province = FRequest::getPostString('province');
            $city = FRequest::getPostString('city');
            $address = FRequest::getPostString('address');
            $data2 = array(
                'uid' => $uid,
                'username' => $username,
                'phone' => $phone,
                'province' => $province,
                'city' => $city,
                'address' => $address
            );
            $user_detail_table = new FTable("user_address");
            $user_detail_table->where(array('addrid' => $addrid))->update($data2);

            $this->showMessage("修改成功" ,$messageType = 'success' ,"/YUserAddress/list?uid=".$uid);
            return;
        }

        $useradd_table = new FTable("user_address");
        $useradd = $useradd_table->where(array('addrid' => $addrid))->find();

        $this->assign("useradd",$useradd);
        $this->assign("uid",$uid);
        $this->assign("addrid",$addrid);
        $this->display('admin/y_user_address_update');
    }

    public function deleteAction() {
        $useradds = new FTable('user_address');
        $addrid = FRequest::getInt('addrid');
        $useradds->where(array('addrid' => $addrid))->remove(true);
        FResponse::redirect('r');
    }

}