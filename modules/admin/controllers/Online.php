<?php

class Controller_Admin_Online extends Controller_Admin_Abstract {
    /**
     * 主报表查询
     */
    public function defaultAction(){

        //global $_F;
        //$_F["debug"] = true;

        $user_online_table = new FTable("user_online","uo");
        $user_online_man = $user_online_table->leftJoin("user_main","um","uo.uid=um.uid")->where(array("um.gender" => 1,"uo.tm" => array('gte'=>date("Y-m-d H:i:s", time())),'uo.uid' => array('gte'=> '5000000')))->count();
        $user_online_table = new FTable("user_online","uo");
        $user_online_woman = $user_online_table->leftJoin("user_main","um","uo.uid=um.uid")->where(array("um.gender" => 2,"uo.tm" => array('gte'=>date("Y-m-d H:i:s", time())),'uo.uid' => array('gte'=> '5000000')))->count();


        $user_online_table = new FTable("user_main");
        $reg_data = $user_online_table->fields(array("gender","count(*) as num"))->where(array('uid' => array('gte'=> '5000000')))->groupBy("gender")->select();
        foreach($reg_data as $data){
            $gender = $data["gender"];
            if($gender==1){
                $man_num  = $data["num"];
            }else if($gender==2){
                $woman_num  = $data["num"];
            }
        }
        $this->assign('user_online_man', $user_online_man);
        $this->assign('user_online_woman', $user_online_woman);
        $this->assign('man_num', $man_num);
        $this->assign('woman_num', $woman_num);

        $this->display('admin/online');
    }


//wxw

}