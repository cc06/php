<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_MumuBa extends Controller_Www_Abstract
{
    public function defaultAction()
    {
        //global $_F;
        //$_F["debug"] = true;

        $table = new FTable("mumu_ba");
        $mumu_bas = $table->fields(array(
            "id",
            "title",
            "text",
            "pic",
            "riqi",
            "position"
        ))
           ->limit(20)->order(array("position"=>"asc","id"=>"desc"))->select();

        $domList=  array();
        foreach($mumu_bas as &$mumu_ba){

            $riqi=explode("-",$mumu_ba["riqi"]);
            $mumu_ba["pic"] = CommonUtil::getMoreSizeImg($mumu_ba["pic"],400,450);
            $mumu_ba["riqi_nian"] =$riqi[0];
            $mumu_ba["riqi_yue"] =$riqi[1];
            $mumu_ba["riqi_ri"] =$riqi[2];
            $sub_arr = array(
                "height"=>"100%",
                "width"=>"100%",
                "content"=>'<div><div style="line-height:30px; text-align:left; padding-left: 20px; font-size: 18px; font-weight: bold;">'.$mumu_ba["title"].'</div><div style=" text-align:center;"><img src="'.$mumu_ba["pic"].'"></div><div style="height:100px;overflow: hidden;"><div style="float:left; width:100px; margin-right:10px;"><div style=" line-height:45px;font-size:36px; font-weight:bold; color:#0099FF; text-align:center;">'.$riqi[2].'</div><div style="line-height:25px; text-align:center;">'.self::NumChinese(intval($riqi[1])).' '.$riqi[0].'</div></div><div style="line-height:25px;overflow: hidden; padding-right: 15px;">'.$mumu_ba["text"].'</div></div></div>'
            );
            array_push($domList,$sub_arr);
        }

//echo( json_encode($domList));



        $this->assign('domList', json_encode($domList));

        $this->assign('title','慕慕语录-慕慕');
        $this->display('mumu_ba');
    }


    public static function  NumChinese($str)
    {
        $Month_E = array(
            1  => "Jan",
            2  => "Feb",
            3  => "Mar",
            4  => "Apr",
            5  => "May",
            6  => "Jun",
            7  => "Jul",
            8  => "Aug",
            9  => "Sep",
            10 => "Oct",
            11 => "Nov",
            12 => "Dec"
        );
        return  $Month_E[$str];
    }
}