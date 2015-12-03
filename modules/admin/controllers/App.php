<?php

class Controller_Admin_App extends Controller_Admin_Abstract {
        /*
         * 上包版本
         */
        public function editAppVersionAction(){

           if($this->isPost()){

               $title = trim(FRequest::getPostString("title"));
               $ver = CommonUtil::getComParam(FRequest::getPostInt("ver"),0);
               $is_force = FRequest::getPostInt("is_force")==1?1:0;
               $summary = trim(FRequest::getPostString("summary"));

               if($title==""){
                   $this->error('更新失败，title未填写', '');
                   return;
               }
               if($ver==0){
                   $this->error('更新失败，版本号未填写', '');
                   return;
               }
               if($summary==""){
                   $this->error('更新失败，升级说明未填写', '');
                   return;
               }
               $table = new FTable("app_version_config");
               $app_data = $table->where(array("ver"=>$ver))->find();

               $data = array(
                   'title' => $title,
                   'ver' => $ver,
                   'summary'=>$summary,
                   'status'=>1,
                   'is_force'=>$is_force,
                   'tm'=>date('Y-m-d H:i:s')
               );
               if($app_data){
                   $table = new FTable("app_version_config");
                   $table->where(array("ver"=>$ver))->update($data);
               }else{
                   FDB::insert("app_version_config", $data);
               }
              // FDB::insert("app_version_config", $data);
               $this->showMessage("更新成功","success","/admin/app/appList");
              // $this->success('更新成功', '/admin/app/appList');
               exit;
           }
            $ver = FRequest::getInt("ver");
            $where = array(
                'ver' => $ver
            );
            $table = new FTable("app_version_config");
            $app_data = $table->where($where)->find();
           $this->assign("app_version",$app_data);

           $this->display("edit_version");
        }


    /*
         * 上包版本列表
         */
    public function appListAction(){
        $page = max(1, FRequest::getInt('page'));
        $table = new FTable("app_version_config");
        $app_data = $table->order(array("ver"=>"desc"))->page($page)->limit(5)->select();

        foreach($app_data as &$app){
            $summary_arr =  explode("\n",$app["summary"]);
            $app["summary"] = $summary_arr;
        }
        $page_info = $table->getPagerInfo();
        $this->assign("page_info",$page_info);
        $this->assign("app_version",$app_data);
        $this->display("app_version");
    }

     /*
      * 上包版本列表
      */
    public function addUpdateAction(){

        if($this->isPost()){

            return;
        }

        $ver = CommonUtil::getComParam(FRequest::getInt("ver"),0);
        if($ver==0){
            $this->error("ver 版本错误");
            return;
        }
        $table = new FTable("app_version_config");
        $app_data = $table->where(array("ver"=>$ver))->find();

        $summary_arr =  explode("\n",$app_data["summary"]);
        $app_data["summary"] = $summary_arr;

        $table2 = new FTable("app_version");
        $update_data = $table2->where(array("ver"=>$ver))->order(array("tm"=>"desc"))->select();



        $this->assign("update_data",$update_data);
        $this->assign("app_version",$app_data);

        $spmList = Service_Edit::getAllSpm();

        $this->assign('spmarr', json_encode($spmList));
        $c_names = Service_Edit::getSpmMap($spmList);
        $this->assign('spmList', $c_names);

        $this->display("add_version");
    }

    /*
        * 上包版本
        */
    public function doAddAction(){

            $c_uid = trim(FRequest::getString("c_uid"));
            $ver = FRequest::getInt("ver");
            $c_sid = trim(FRequest::getString("c_sid"));

            $data = array(
                'ver' => $ver,
                'c_uid'=>$c_uid,
                'c_sid'=>$c_sid,
                'status'=>1
            );

            $t = new FTable("app_version");
            $t->insert($data);

            FResponse::output(CommonUtil::GetDefRes(200,"操作成功"));
            return;
    }

    /*
        * 修改上包版本
        */
    public function updateAction(){
        $c_uid = trim(FRequest::getString("c_uid"));
        $ver = FRequest::getInt("ver");
        $status = FRequest::getInt("status");
        $c_sid = trim(FRequest::getString("c_sid"));

        $data = array(
            'status'=>$status
        );
        $where = array(
            'ver' => $ver,
            'c_uid'=>$c_uid,
            'c_sid'=>$c_sid,
        );

        $t = new FTable("app_version");
        $t->update($data,$where);

        FResponse::output(CommonUtil::GetDefRes(200,"操作成功"));
        return;
    }
}
