<?php

/**
 * Created by PhpStorm.
 * User: cf
 * Date: 14-10-8
 * Time: 下午10:14
 * 商城相关接口
 */
class Controller_Www_Mall extends Controller_Www_Abstract
{
    /**
     * 商品列表
     *
     */
    public function listAction()
    {
        $goldcoin = 0;
        $uid = FCookie::get("uid");
        if($uid&&$uid>0){
            $table2 = new FTable("user_main");
            $u = $table2->fields(array("goldcoin"))->where(array("uid"=>$uid))->find();
            $goldcoin = $u["goldcoin"];
        }
        $table = new FTable("mall");
        $r = $table->fields(array("id","title","pic","price","gold","tip"))->where(array("status"=>1))->select();

        $this->assign("goldcoin",$goldcoin);
        $this->assign("goods_list",$r);
        $this->assign("base_url",FConfig::get('global.base_url')."/mall/info");
        $this->display('mall_list');
    }

    /**
     * 某商品详情
     * @throws Exception
     */
    public  function infoAction(){
        $id = FRequest::getInt("id");
        $table = new FTable("mall");
        $r = $table->where(array("id"=>$id))->find();

        //查询库存
        $table2 = new FTable("mall_inventory");
        $balance = $table2->where(array("goods_id"=>$id,"status"=>0))->count();

        $detail = json_decode($r["detail"],true);
        $this->assign("detail",$detail);
        $this->assign("goods_info",$r);
        $this->assign("balance",$balance);
        $this->display('mall_info');
    }

    /**
     * 某商品结果（二维码，密码）
     * @throws Exception
     */
    public  function detailAction(){
        global $_F;
        /*echo "cookie: ".json_encode($_COOKIE)."<br>";*/
        if(!$this->isLogin()){
            return;
        }
        $id = FRequest::getInt("id");
        $table = new FTable("mall_buy_history","mb");
        $buy = $table->where(array("id"=>$id))->find();
        if($buy["uid"]!=$_F["uid"]){
           /* echo  "信息不符".json_encode($buy)."---".$_F["uid"]."---".json_encode($_COOKIE);*/
            return;
        }
        if(!$buy["item_id"]||$buy["item_id"]<=0){
            return;
        }
        $this->assign("buy",$buy);

        $table = new FTable("mall_inventory","mi");
        $r = $table->fields(array("mall.title","mall.pic","mi.goods_id","mi.secrete","mi.status"))->leftJoin("mall","mall","mi.goods_id = mall.id")->where(array("mi.id"=>$buy["item_id"]))->find();

        $secrete = json_decode($r["secrete"],true);
        $this->assign("secrete",$secrete);
        $this->assign("buy_info",$r);

        $this->assign("base_url",FConfig::get('global.base_url')."/mall/info");
        $this->display('mall_detail');
    }
}