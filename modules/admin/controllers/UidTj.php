<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/20
 * Time: 17:40
 */
class Controller_Admin_UidTj extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

        $this->display('admin/uidtj_list');
    }

    function listAction(){
        //global $_F;
        //$_F["debug"] = true;

        $uid = CommonUtil::getDefStr(FRequest::getPostString('uid'),"");

        $tj25=json_decode(FRequest::getPostString('tj25'));
        $tj26=json_decode(FRequest::getPostString('tj26'));
        $tj27=json_decode(FRequest::getPostString('tj27'));
        $tj28=json_decode(FRequest::getPostString('tj28'));
        $tj30=json_decode(FRequest::getPostString('tj30'));
        $tj31=json_decode(FRequest::getPostString('tj31'));
        $tj32=json_decode(FRequest::getPostString('tj32'));

        $stats_date = FRequest::getString('stats_date');


        if (!$stats_date) {
            $this->showMessage("请输入统计日期" ,error);
            return;
        }

        $url =  FConfig::get('global.service_mumu_url')."/user/AdminTjInfo";

       /* $params = array("uid"=>$uid,"date"=>$stats_date);
        $params=Service_Common::post($url,json_encode($params));
        $params=json_decode($params);

        if($params->status=="ok"){
           $this->assign("tj",$params->res);
        } else{
            $this->showMessage("查找失败",$messageType = 'success');
            return;
        }*/
      if (!$uid||$uid==25) {
          $params25 = array("uid"=>25,"date"=>$stats_date);
          $params25=Service_Common::post($url,json_encode($params25));
          $params25=json_decode($params25);
          if($params25->status=="ok"){
              $tj25=$params25->res;
          }
      }
        if (!$uid||$uid==26) {
        $params26 = array("uid"=>26,"date"=>$stats_date);
        $params26=Service_Common::post($url,json_encode($params26));
        $params26=json_decode($params26);
        if($params26->status=="ok"){
            $tj26=$params26->res;
        }
        }
        if (!$uid||$uid==27) {
        $params27 = array("uid"=>27,"date"=>$stats_date);
        $params27=Service_Common::post($url,json_encode($params27));
        $params27=json_decode($params27);
        if($params27->status=="ok"){
            $tj27=$params27->res;
        }
    }
        if (!$uid||$uid==28) {
        $params28 = array("uid"=>28,"date"=>$stats_date);
        $params28=Service_Common::post($url,json_encode($params28));
        $params28=json_decode($params28);
        if($params28->status=="ok"){
            $tj28=$params28->res;
        }
}
        if (!$uid||$uid==30) {
        $params30 = array("uid"=>30,"date"=>$stats_date);
        $params30=Service_Common::post($url,json_encode($params30));
        $params30=json_decode($params30);
        if($params30->status=="ok"){
            $tj30=$params30->res;
        }
}
        if (!$uid||$uid==31) {
        $params31 = array("uid"=>31,"date"=>$stats_date);
        $params31=Service_Common::post($url,json_encode($params31));
        $params31=json_decode($params31);
        if($params31->status=="ok"){
            $tj31=$params31->res;
        }
}
        if (!$uid||$uid==32) {
        $params32 = array("uid"=>32,"date"=>$stats_date);
        $params32=Service_Common::post($url,json_encode($params32));
        $params32=json_decode($params32);
        if($params32->status=="ok"){
            $tj32=$params32->res;
        }
}
        $this->assign("tj25",$tj25);
        $this->assign("tj26",$tj26);
        $this->assign("tj27",$tj27);
        $this->assign("tj28",$tj28);
        $this->assign("tj30",$tj30);
        $this->assign("tj31",$tj31);
        $this->assign("tj32",$tj32);
        $this->assign("tj25_jd",json_encode($tj25));
        $this->assign("tj26_jd",json_encode($tj26));
        $this->assign("tj27_jd",json_encode($tj27));
        $this->assign("tj28_jd",json_encode($tj28));
        $this->assign("tj30_jd",json_encode($tj30));
        $this->assign("tj31_jd",json_encode($tj31));
        $this->assign("tj32_jd",json_encode($tj32));
        $this->assign("uid",$uid);
        $this->assign("stats_date",$stats_date);
        $this->display('admin/uidtj_list');
    }


}