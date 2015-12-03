<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_WeixinHuodong extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        //global $_F;
        //$_F["debug"] = true;

        $table = new FTable("weixin_huodong");
        $weixin_huodongs = $table->fields(array(
            "id",
            "title",
            "text",
            "pic",
            "url",
            "position"
        ))
           ->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

        foreach($weixin_huodongs as &$weixin_huodong){

            $weixin_huodong["pic"] = CommonUtil::getMoreSizeImg($weixin_huodong["pic"],280,280);
            $weixin_huodong["text"] = mb_substr($weixin_huodong["text"],0,50,"utf-8");
        }


        $this->assign('weixin_huodong', $weixin_huodongs);

        $this->assign('title','微信活动-慕慕');
        $this->display('weixin_huodong');
    }
}