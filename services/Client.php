<?php
/**
 * Created by PhpStorm.
 * User: cf
 * Date: 15-11-14
 * Time: 上午9:31
 */
class Service_Client{

    /**
     * 根据用户uid
     * @param $uid
     * @return array
     * @throws Exception
     */
    public static function getUserByUid($uid){
        $table = new FTable("user_main","um");
        $user = $table->leftJoin("user_detail","ud","um.uid=ud.uid")->where(array("um.uid"=>$uid))->find();
        return $user;
    }

}