<?php

class Controller_Admin_Public {

    public function authCodeAction() {
        session_start();
//生成验证码图片
        Header("Content-type: image/PNG ");

        srand((double)microtime() * 1000000);
        $authnum = rand(1000, 9999);
        $_SESSION['rand_code'] = $authnum;
        $im = imagecreate(62, 20);

        ImageColorAllocate($im, 0, 0, 0);
        $white = ImageColorAllocate($im, 255, 255, 255);
        //将五位整数验证码绘入图片
        imagestring($im, 5, 10, 3, $authnum, $white);
        //加入干扰象素
        for ($i = 0; $i < 200; $i++) {
            $randcolor = ImageColorallocate($im, rand(0, 255), rand(0, 255), rand(0, 255));
            imagesetpixel($im, rand() % 70, rand() % 30, $randcolor);
        }
        ImagePNG($im);
        ImageDestroy($im);
    }


    public function test1Action() {
        $_SESSION['aaaa'] = array('test1');
    }

    public function test2Action() {
        var_dump($_SESSION);
    }
}