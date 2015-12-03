<?php

// 线上环境
/*$_config ['db'] = array(
    'table_pre'   => '',
    'charset'     => 'utf8',
    'mumu_write' => array(   //配置写库
        'default' => array(
           // 'dsn'      => 'mysql:dbname=mumu;host=master.main.mysql.docker:13306',
            'dsn'      => 'mysql:dbname=mumu;host=192.168.1.92:13306',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'mumu_read' => array(  //配置读库
        'default'  => array(
           // 'dsn'      => 'mysql:dbname=mumu;host=slave1.main.mysql.docker:13306',
            'dsn'      => 'mysql:dbname=mumu;host=192.168.1.90:13306',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'stats_write' => array(  // 配置统计写库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_stat;host=192.168.1.78:13307',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'stats_read' => array(  // 配置统计读库（统计专属读库..）
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_stat;host=192.168.1.78:13307',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'message_read' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_message;host=192.168.1.78:13308',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'sort_write' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_sort;host=192.168.1.86:13306',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    ),
    'sort_read' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_sort;host=192.168.1.87:13306',
            'user'     => 'mumu',
            'password' => 'jkwen2k3x',
        )
    )
);*/
// 测试环境

$_config ['db'] = array(
    'table_pre'   => '',
    'charset'     => 'utf8',
    'mumu_write' => array(   //配置写库
        'default' => array(
            'dsn'      => 'mysql:dbname=mumu;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'mumu_read' => array(  //配置读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'stats_write' => array(  // 配置统计写库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_stat;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'stats_read' => array(  // 配置统计读库
        'default'  => array(
           // 'dsn'      => 'mysql:dbname=mumu_stat;host=mysql.mumu:13306',
            'dsn'      => 'mysql:dbname=mumu_stat;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'message_read' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_message;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'sort_write' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_sort;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    ),
    'sort_read' => array(  // 配置统计读库
        'default'  => array(
            'dsn'      => 'mysql:dbname=mumu_sort;host=120.131.64.91:13306',
            'user'     => 'root',
            'password' => 'root',
        )
    )
);

