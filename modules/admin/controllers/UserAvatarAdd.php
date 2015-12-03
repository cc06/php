<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/6/26
 * Time: 上午10:30
 */
class Controller_Admin_UserAvatarAdd extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }




    //获取所有有头像未审核用户
    function listAction(){
        global $_F;
        //$_F["debug"] = true;
        $province = FRequest::getString('province');
        $city = FRequest::getString('city');

        $gender = CommonUtil::getComParam(FRequest::getInt('gender'),2);
        $age = FRequest::getInt('age');

        $table = new FTable("user_province_area");
        $provinces = $table->order(array("region_id"=>"asc"))->select();
        if ($province) {

            $where = array(
                "city"=>$province
            );
            $user_province = new FTable("user_province_area");
            $user_provinces = $user_province->where($where)->find();

            $stm_str = "-".$age." year";
            $etm_str = "-".($age-1)." year";
            $stm_birthday = date("Y-01-01 00:00:00",strtotime($stm_str));
            $etm_birthday = date("Y-01-01 00:00:00",strtotime($etm_str));
            $query_str= " ud.birthday >= '".$stm_birthday."'  and ud.birthday < '".$etm_birthday."'  ";
            $user_table = new FTable("user_main","um");
            $user=$user_table->where(array("um.gender"=>$gender,"str"=>$query_str))->leftJoin("user_detail","ud","um.uid=ud.uid")->find();

            $url = FConfig::get('global.service_mumu_url')."/s/discovery/IAdjacent";
            //$url = "http://yfservice.admin.docker:8081/s/discovery/IAdjacent";
//echo($url);
            $post_data = array (
                "lng" => $user_provinces['x'],
                "lat" => $user_provinces['y'],
                "cur" => 1,
                "refresh" => true,
                "ps" => 30,
                "uid"=>$user["uid"]
            );
            //$cookie = "sid=306123456;uid=5000513;key=306123456";
            $cookie = "sid=".FSession::get('sid').";uid=".FSession::get('user_id').";key=".FSession::get('sid');


            $output = FHttp::doPost($url,$post_data,$cookie);


           // print_r($output);
            $output=json_decode($output);

            $status=$output->status;
            $users= $output->res;
            $users= $users->users;
            $users= $users->list;


            if(count($users)<=30) {
                $post_data = array (
                    "lng" => $user_provinces['x'],
                    "lat" => $user_provinces['y'],
                    "cur" => 2,
                    "refresh" => true,
                    "ps" => 30,
                    "uid"=>$user["uid"]
                );
                $output2 = FHttp::doPost($url,$post_data,$cookie);
                $output2=json_decode($output2);
                $users2= $output2->res;
                $users2= $users2->users;
                $users2= $users2->list;
            }
            $users = array_merge($users,$users2);

            $ids = array();
            foreach($users as $u){
                array_push($ids,$u->uid);
            }
            if(count($ids)>0){
                $users_table = new FTable("user_main","um");
                $u_arr = $users_table->fields(array("um.uid","um.gender","ud.localtag","ud.birthday"))->where(array("um.uid"=>array("in"=>$ids)))->leftJoin("user_detail","ud","um.uid = ud.uid")->select();
            }
            $u_m = array();
            foreach($u_arr as $u){
                $u_m[$u["uid"]] = $u;
            }
            foreach($users as &$u){
                $uid = $u->uid;
                $r_u = $u_m[$uid];
                $u->age = CommonUtil::birthdayToAge($r_u["birthday"]);
                $u->tag = $r_u["localtag"];
                $u->gender = $r_u["gender"];
            }
            $this->assign('users', $users);
            $this->assign('status', $status);
            $this->assign('province', $province);
            $this->assign('city', $city);
            $this->assign('age', $age);

        }
        $this->assign('gender', $gender);

        $this->assign('provinces', $provinces);
        $this->display('admin/user_avataradd_list');

    }

    public function shenheAction() {
       // global $_F;
       // $_F["debug"] = true;

        $size = FRequest::getPostInt('size');

        $list =array();
        /*
        for($j=1;$j <$size;$j++) {
            $list[$j-1] =FRequest::getPostString('avatarlevel'.$j);
        }
        $list[$size-1] = FRequest::getPostString('avatarlevel'.$size);
        */

        $list[0] = FRequest::getPostString('avatarlevel'.$size);

        $params = array("list"=>$list);
        $params =json_encode($params);
        //$this->showMessage($params,$messageType = 'success');
       // exit;

        $url =  FConfig::get('global.service_mumu_url')."/user/AdminSetAvatarStat";

        $params=Service_Common::post($url,$params);

        $params=json_decode($params);

        if($params->status=="ok"){
        //$this->showMessage("审核成功",$messageType = 'success');
       } else{
            $this->showMessage("审核失败",$messageType = 'success');
        }
        return;

    }



}