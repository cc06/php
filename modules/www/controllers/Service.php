<?php

/**
 * Created by PhpStorm.
 * User: wyr
 * Date: 14-10-8
 * Time: 下午10:14
 */
class Controller_Www_Service extends FController
{
    /**
     *处理微信服务器消息
     */
    public function defaultAction()
    {
        global $_F;
        $this->openDebug();

        require_once(APP_ROOT . 'lib/weixin/WeixinChat.class.php');

        $options = array(
            'token' => 'mumu2015api',
            'appid' => 'wxe3ae7e3cf42d0825',
            'appsecret' => '2d7b39fcb0813e7b07830683cc3caa50'
        );
        $weixin = new WeixinChat($options);

//        $weixin->valid();

        $logger = new FLogger("weixn");

        $logger->append('==============开始：===============');

        $getRev = $weixin->getRev();

        $logger->append($getRev->getRevText());

        if ($weixin->getRevType()) {


            $logger->append('getRevType:' . $weixin->getRevType());
            $eventData = $weixin->getRevEvent();

            $logger->append('eventData:' . var_export($eventData, true));

            if ($eventData) {

                $openid = $weixin->getRevFrom();

                if ($eventData['event'] == 'click') {
                    switch ($eventData['key']) {
                        case 'V1001_FREE':
                            $type = 1;
                            break;
                        case 'V1001_TODAY_ACTIVITY':
                            $type = 2;
                            break;
                        case 'V1001_FOUND':
                            $type = 3;
                            break;
                        default:
                            $type = 1;
                            break;
                    }
                    $data = $this->getNewsMsgData($type);
                } else {

                    if ($eventData['event'] == 'subscribe') //关注
                    {
//                        $upData = array(
//                            'subscribe' => 1,
//                            'subscribe_time' => date('Y-m-d H:i:s', time())
//                        );

                        $userInfo = $weixin->getUserInfo($openid);
                        FLogger::write($userInfo, 'subscribe');

                        Service_UserWechat::reg($userInfo, $openid);

//                        $data = $this->getNewsMsgData(2);
                        $data = '欢迎关注缘分吧';
                    }

                    if ($eventData['event'] == 'unsubscribe') //取消关注
                    {
//                        $upData = array(
//                            'subscribe' => 0
//                        );
                    }

                }
            }


            if ($data) {

                $logger->append(var_export($data, true));
                $logger->append(FRequest::getClientIP());
//                $logger->append(json_encode($weixin->getRevData()));
                $weixin->text($data);
                $weixin->reply();

            }
        } else {
            $logger->append('getRevType为空' . $weixin->getRevType());
        }

        $logger->append('==============结束：===============');
    }


    function showMessage($message, $msgType, $url = null)
    {
        // TODO: Implement showMessage() method.
    }
}