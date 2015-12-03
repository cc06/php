<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 14-10-8
 * Time: 下午10:14
 * 客户端相关页面
 */
class Controller_Www_Client extends Controller_Www_Abstract
{
    /**
     * 约会说明
     */
    public function dateAction()
    {
        global $_F;
        //$_F["debug"] = true;
        $uid = FCookie::get("uid");
        $user = Service_Client::getUserByUid($uid);

        if($user["province"]=="北京"||$user["province"]=="天津"||$user["province"]=="上海"||$user["province"]=="重庆"){
            $user["city"] = $user["province"];
        }

        $table = new FTable("date_place");
        $place_num = $table->where(array("city"=>$user["city"]))->count();

        $table = new FTable("date_request","dr");
        $query_sql = " ( ud.province = '".$user["city"]."' or  ud.city = '".$user["province"]."' )";
        $date_num = $table->leftJoin("user_detail","ud","dr.uid1=ud.uid")->where(array("dr.available"=>1,"str"=>$query_sql))->count();

        $this->assign("base_url", FConfig::get('global.base_url'));
        $this->assign("place_num",$place_num);
        $this->assign("user",$user);
        $this->assign("date_num",$date_num);
         $this->display('client_date');
    }
    /**
     * 约会详情
     */
    public function dateInfoAction()
    {
        $this->display('client_dateinfo');
    }

    /**
     * 约会说明
     */
    public function date2Action()
    {
        global $_F;
        //$_F["debug"] = true;

        echo(json_encode(FRequest::getAllParams()));
    }
}