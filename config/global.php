<?php

$_config['global'] = array(
    'debug' => false,
    'session' => array('type' => 'db',
        'table' => 'sys_session',
        'cookie_domain'=>'imswing.cn',
        'life_time' => 0
    ),
    'sub_domain' => array(
        'status' => 'on',
        'default' => 'admin',
        'sub_domain_rewrite' => array(
            'a' => 'admin',
            'test.upload' => 'upload',
            'test.www' => 'www'
        ),
    ),
    //'service_mumu_url'=>"http://service.mumu123.cn"
    // 测试环境
     'service_mumu_url'=>"http://120.131.64.91:80",
     'base_url'=>"http://test.a.imswing.cn:10080"
);
