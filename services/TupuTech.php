<?php

/**
 * Class Service_TupuTech
 * 图谱科技，图片认证接口
 * （）
 */
class Service_TupuTech
{
    public static  $SEXY_AND_AD_SECRET_ID = "55d3fa6bf8792c3b54f67ff8";  // 色情+广告组合ID
    public static  $SEXY_AND_HUMAN_SECRET_ID = "55dbd1d2c23705e7102070e6";  // 色情+人物类型组合ID
    public static  $SEX_SECRET_ID = "55d2f805f8792c3b54f6751b";   // 色情ID
    public static  $AD_SECRET_ID = "55d2f82df8792c3b54f6751f";    // 广告ID
    //色情+广告任务url
    public static  $SEXY_AND_AD_TASK_URL = "http://api.open.tuputech.com/v2/pipe/558e37aca636676972c8ab91";
    //色情+人物任务url
    public static  $SEXY_AND_HUMAN_TASK_URL = "http://api.open.tuputech.com/v2/pipe/555421d0559246743e9f31f7";
    // 色情 任务url
    public static  $SEX_TASK_URL = "http://api.open.tuputech.com/v2/classification/54bcfc31329af61034f7c2f8/54bcfc6c329af61034f7c2fc";
    // 广告 任务url
    public static  $AD_TASK_URL = "http://api.open.tuputech.com/v2/classification/552cd30b687c202a0940d8cd/55b84cb66be856d869726d97";


    //自动检测组合类型，0 未检测任何类型，1 色情+广告 2 色情+是否人物 待扩展
    public static $SEXY_AND_AD = 1;
    public static $SEXY_AND_HUMAN = 2;

    /**
     * 执行图片检测任务
     * @return string
     */
    public static function doCheckImages($images,$item){
        $log = new FLogger("images_log");
        $secretid = ""; //你的secretid
        $timestamp = time(); //当前时间
        $nonce = rand(100,999999); //随机数
        $taskUrl = ""; //任务链接

        if($item==self::$SEXY_AND_HUMAN){
            $secretid = self::$SEXY_AND_HUMAN_SECRET_ID; //你的secretid
            $taskUrl = self::$SEXY_AND_HUMAN_TASK_URL; //任务链接
        }else if($item==self::$SEXY_AND_AD){
            $secretid = self::$SEXY_AND_AD_SECRET_ID; //你的secretid
            $taskUrl = self::$SEXY_AND_AD_TASK_URL; //任务链接
        }

        //得到参与签名的参数
        $sign_string = $secretid.",".$timestamp.",".$nonce;

        //读取私钥，并得到base64格式的签名$signature
        $private_key_pem = file_get_contents(APP_ROOT.'/lib/tuputech/rsa_private_key.pem');
        $pkeyid = openssl_get_privatekey($private_key_pem);
        openssl_sign($sign_string, $signature, $pkeyid, OPENSSL_ALGO_SHA256);
        $signature = base64_encode($signature);

        //添加上传参数
        $data = array(
            'secretId' => $secretid,
            'image' => $images,
            'timestamp' => $timestamp,
            'nonce' => $nonce,
            'signature' => $signature
        );
       // $log->append("doCheckImages data 1 -".json_encode($data));
        //以post方式提交参数
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $taskUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT,15);
        self::curl_setopt_custom_postfields($ch, $data);
        $output = curl_exec($ch);
        curl_close($ch);
        //解析返回的数据

        $data = json_decode($output, true);
        $log->append("doCheckImages data end -".json_encode($data));
        if( $data ){
            $signature = $data['signature'];
            $json = $data['json'];
            $public_key_pem = file_get_contents(APP_ROOT.'/lib/tuputech/open_tuputech_com_public_key.pem');
            $pkeyid2 = openssl_get_publickey($public_key_pem);
            //利用openssl_verify进行验证，结果1表示验证成功，0表示验证失败
            $result = openssl_verify($json, base64_decode($signature), $pkeyid2, "sha256WithRSAEncryption");
            if($result == 1){
                return $json;
            }else{
                return array("code"=>10,"message"=>" 签名失败");
            }
        }
        return array("code"=>10,"message"=>"data is ".json_encode($data));
    }

    //该方法的作用是通过$images生成post时的多个image参数
    function curl_setopt_custom_postfields($ch, $postfields, $headers = null) {
        $algos = hash_algos();
        $hashAlgo = null;
        foreach ( array('sha1', 'md5') as $preferred ) {
            if ( in_array($preferred, $algos) ) {
                $hashAlgo = $preferred;
                break;
            }
        }
        if ( $hashAlgo === null ) { list($hashAlgo) = $algos; }
        $boundary =
            '----------------------------' .
            substr(hash($hashAlgo, 'cURL-php-multiple-value-same-key-support' . microtime()), 0, 12);

        $body = array();
        $crlf = "\r\n";
        $fields = array();
        foreach ( $postfields as $key => $value ) {
            if ( is_array($value) ) {
                foreach ( $value as $v ) {
                    $fields[] = array($key, $v);
                }
            } else {
                $fields[] = array($key, $value);
            }
        }
        foreach ( $fields as $field ) {
            list($key, $value) = $field;
            if ( strpos($value, '@') === 0 ) {
                preg_match('/^@(.*?)$/', $value, $matches);
                list($dummy, $filename) = $matches;
                $body[] = '--' . $boundary;
                $body[] = 'Content-Disposition: form-data; name="' . $key . '"; filename="' . basename($filename) . '"';
                $body[] = 'Content-Type: application/octet-stream';
                $body[] = '';
                $body[] = file_get_contents($filename);
            } else {
                $body[] = '--' . $boundary;
                $body[] = 'Content-Disposition: form-data; name="' . $key . '"';
                $body[] = '';
                $body[] = $value;
            }
        }
        $body[] = '--' . $boundary . '--';
        $body[] = '';
        $contentType = 'multipart/form-data; boundary=' . $boundary;
        $content = join($crlf, $body);
        $contentLength = strlen($content);

        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Length: ' . $contentLength,
            'Expect: 100-continue',
            'Content-Type: ' . $contentType,
        ));

        curl_setopt($ch, CURLOPT_POSTFIELDS, $content);

    }

}