<?php

$_config['router'] = array(
    '/(\d+?)/(\d+?)' => array('controller' => 'Index', 'action' => 'default','params' => "c_uid,c_sid"),
    '/S/u(\d+?)' => array('controller' => 'UserShare', 'action' => 'default','params' => "uid"),
    '/sharearticles/(\d+?)' => array('controller' => 'sharearticles', 'action' => 'default','params' => "id"),
    '/shareDynamic/(\d+?)' => array('controller' => 'shareDynamic', 'action' => 'default','params' => "id"),
    '/sharePuzzle/(\d+?)' => array('controller' => 'sharePuzzle', 'action' => 'default','params' => "id"),
    '/' => array('controller' => 'Index', 'action' => 'default'),
);