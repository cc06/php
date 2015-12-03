<?php
/**
 * Created by PhpStorm.
 * User: zijunna
 * Date: 14-9-26
 * Time: 下午4:34
 */

class Logger{
    public static $LOG_NAME = "debug";
    public static function append($str){
        file_put_contents('debug.log', date('Y-m-d H:i:s')." : ".$str.PHP_EOL , FILE_APPEND);
    }

    public static function appendLog($LOG_NAME,$str){
        file_put_contents($LOG_NAME.'.log', date('Y-m-d H:i:s')." : ".$str.PHP_EOL , FILE_APPEND);
    }
}