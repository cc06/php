<?php

$_config['router'] = array(
    '/(\d+?)/(\d+?)' => array('controller' => 'Index', 'action' => 'default','params' => "c_uid,c_sid"),
    '/' => array('controller' => 'Main', 'action' => 'index'),
    '/admin' => array('controller' => 'Main', 'action' => 'index'),
    '/upload' => array('controller' => 'Index', 'action' => 'default'),
);