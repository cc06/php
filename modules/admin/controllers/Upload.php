<?php

class Controller_Admin_Upload extends Controller_Admin_Abstract {
    public function saveAction() {

//        $fLogger = new FLogger('debug');
        //$fLogger->append('enter save...');

        //创建阿里云工具类,并上传到阿里云
       /* $aliyunUtil = new AliyunUtil();
        $ret = $aliyunUtil->upload();

        if ($ret['status'] == 200) {
            $retData = array(
                "state" => true,
                "code"  => 200,
                "url"   => $ret['url'],
            );
        } else {
            $retData = array(
                "state"   => false,
                "code"    => $ret['status'],
                "message" => $ret['msg'],
            );
        }*/
        $retData = null;


        if($this->isPost()) {
            /*$url = "http://upload.img.yuanfenba.net/Index/upload?type=photo&flag=1&uid=1000";
            $res = FHttp::doPost($url,$param, nil);
            FResponse::output($res);*/
            echo(FRequest::getPostString("hh"));
            echo(FRequest::getPostString("hhh"));
          //  echo(json_encode($res));
            return;
        }
        $this->display("admin/test_upload");
    }
}