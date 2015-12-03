<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_MumuYouxi extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        //global $_F;
        //$_F["debug"] = true;

        $table = new FTable("mumu_youxi");
        $mumu_youxis = $table->fields(array(
            "id",
            "title",
            "text",
            "pic",
            "url",
            "position"
        ))
           ->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

        foreach($mumu_youxis as &$mumu_youxi){

            $mumu_youxi["pic"] = CommonUtil::getMoreSizeImg($mumu_youxi["pic"],280,280);
          $mumu_youxi["text"] = mb_substr($mumu_youxi["text"],0,50,"utf-8");
        }


        $this->assign('mumu_youxi', $mumu_youxis);

        $this->assign('title','慕慕游戏');
        $this->display('mumu_youxi');
    }
}