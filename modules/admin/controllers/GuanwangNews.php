<?php

/**
 * Created by PhpStorm.
 * User: wxw
 * Date: 15/7/13
 * Time: 下午13:00
 */
class Controller_Admin_GuanwangNews extends  Controller_Admin_Abstract{
    /**
     *
     */
    function defaultAction(){

    }


    /**
     * 添加地址
     */
        function  listAction(){
            //global $_F;
           // $_F["debug"] = true;

            $page = max(1, FRequest::getInt('page'));
            $text = FRequest::getString('text');
            $where = array();

            $shanchu_id = FRequest::getInt('shanchu_id');
            if ($shanchu_id) {
                $guanwang_newss = new FTable('guanwang_news');
                $guanwang_newss->where(array('id' => $shanchu_id))->remove(true);
            }


            $table = new FTable("guanwang_news");
            $guanwang_newss = $table->fields(array(
                "id",
                "title",
                "text",
                "riqi"
            ))
                ->where($where)->page($page)->limit(20)->order(array("id"=>"desc"))->select();

            foreach($guanwang_newss as &$guanwang_news){
                $query = explode("-",$guanwang_news['riqi']);
                $guanwang_news["yue"] =  self::NumChinese(intval($query[1]));
                $guanwang_news["ri"] = $query[2];
            }

            $page_info = $table->getPagerInfo();
            $this->assign('page_info', $page_info);
            $this->assign('guanwang_news', $guanwang_newss);
            $this->display('admin/guanwang_news_list');
        }

    /**
     * 修改焦点图
     */
    function  updateAction(){

        $id = FRequest::getInt("id");
        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $text=str_replace("<p>","",$text);
            $text=str_replace("</p>","<br>",$text);
            $riqi = FRequest::getPostString('riqi');
            $title = FRequest::getPostString('title');

            if (!$title) {
                $this->showMessage("标题不能为空" ,error);
                return;
            }
            if (!$riqi) {
                $this->showMessage("日期不能为空" ,error);
                return;
            }



            $data2 = array(
                'title' => $title,
                'text' => $text,
                'riqi' => $riqi

            );

            $guanwang_news_table = new FTable("guanwang_news");
            $guanwang_news_table->where(array("id"=>$id))->update($data2);

            $this->showMessage("修改成功","success","/GuanwangNews/list");
            return;
        }
        $guanwang_news_table = new FTable("guanwang_news");
        $guanwang_news = $guanwang_news_table->where(array('id' => $id))->find();

        $this->assign("guanwang_news",$guanwang_news);
        $this->assign("id",$id);


        $this->display('admin/guanwang_news_update');
    }
    /**
     * 添加焦点图
     */
    function  addAction(){


        if ($this->isPost()) {

            $text = FRequest::getPostString('text');
            $text=str_replace("<p>","",$text);
            $text=str_replace("</p>","<br>",$text);
            $riqi = FRequest::getPostString('riqi');
            $title = FRequest::getPostString('title');


            if (!$title) {
                $this->showMessage("标题不能为空" ,error);
                return;
            }
            if (!$riqi) {
                $this->showMessage("日期不能为空" ,error);
                return;
            }


            //print_r($content);

            $data2 = array(
                'title' => $title,
                'text' => $text,
                'riqi' => $riqi

            );

            $guanwang_news_table = new FTable("guanwang_news");
            $guanwang_news_table->insert($data2);

            $this->showMessage("添加成功","success","/GuanwangNews/list");
            return;
        }

        $this->display('admin/guanwang_news_add');
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