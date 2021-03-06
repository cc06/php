<?php

/**
 * CURL HTTP请求工具，
 * 支持以下功能：
 * 1：支持ssl连接和proxy代理连接
 * 2: 对cookie的自动支持
 * 3: 简单的GET/POST常规操作
 * 4: 支持单个文件上传或同字段的多文件上传,支持相对路径或绝对路径.
 * 5: 支持返回发送请求前和请求后所有的服务器信息和服务器Header信息
 * 6: 自动支持lighttpd服务器
 * 7: 支持自动设置 REFERER 引用页
 * 8: 自动支持服务器301跳转或重写问题
 * 9: 其它可选项,如自定义端口，超时时间，USERAGENT，Gzip压缩等.
 */
class FHttp {

    /**
     * 下载网络文件
     *
     * @param string $http_file 网络文件地址
     * @param string $save_path 保存路径
     *
     * @return object
     */
    public static function download($http_file, $save_path = null) {
        $http_file_raw = file_get_contents($http_file);

        if ($save_path) {
            file_put_contents($save_path, $http_file_raw);
        } else {
            return $http_file_raw;
        }

        return true;
    }

    public static function get($url) {
        $fHttp = new self;

        return $fHttp->getByCurl($url);
    }

    public static function post($url,$params) {
        $fHttp = new self;

        return $fHttp->_post_String($url,$params);
    }

    //CURL句柄
    private $ch = null;
    //CURL执行前后所设置或服务器端返回的信息
    private $info = array();
    //CURL SET OPT 信息
    private $set_opt = array(
        //访问的端口,http默认是 80
        'port' => 80,
        //客户端 USERAGENT,如:"Mozilla/4.0",为空则使用用户的浏览器
        'userAgent' => '',
        //连接超时时间
        'timeOut' => 30,
        //是否使用 COOKIE 建议打开，因为一般网站都会用到
        'useCookie' => false,
        //是否支持SSL
        'ssl' => false,
        //客户端是否支持 gzip压缩
        'gzip' => true,

        //是否使用代理
        'proxy' => false,
        //代理类型,可选择 HTTP 或 SOCKS5
        'proxyType' => 'HTTP',
        //代理的主机地址,如果是 HTTP 方式则要写成URL形式如:"http://www.proxy.com"
        //SOCKS5 方式则直接写主机域名为IP的形式，如:"192.168.1.1"
        'proxyHost' => 'http://www.proxy.com',
        //代理主机的端口
        'proxyPort' => 1234,
        //代理是否要身份认证(HTTP方式时)
        'proxyAuth' => false,
        //认证的方式.可选择 BASIC 或 NTLM 方式
        'proxyAuthType' => 'BASIC',
        //认证的用户名和密码
        'proxyAuthUser' => 'user',
        'proxyAuthPwd' => 'password',
    );

    private $header = array(
        "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Charset: GBK,utf-8;q=0.7,*;q=0.3",
        //"Accept-Encoding: gzip,deflate,sdch",
        "Accept-Language: zh-CN,zh;q=0.8",
        "Cache-Control: max-age=0",
        "Connection: keep-alive",
    );

    /**
     * 构造函数
     *
     * @param array $set_opt :请参考 private $set_opt 来设置
     */
    public function __construct($set_opt = array()) {


        //合并用户的设置和系统的默认设置
        $this->set_opt = array_merge($this->set_opt, $set_opt);
        //如果没有安装CURL则终止程序
        function_exists('curl_init') || die('CURL Library Not Loaded');
        //初始化
        $this->ch = curl_init();
        //设置CURL连接的端口
        //curl_setopt($this->ch, CURLOPT_PORT, $this->set_opt['port']);
        //使用代理
        if ($this->set_opt['proxy']) {
            $proxyType = $this->set_opt['proxyType'] == 'HTTP' ? CURLPROXY_HTTP : CURLPROXY_SOCKS5;
            curl_setopt($this->ch, CURLOPT_PROXYTYPE, $proxyType);
            curl_setopt($this->ch, CURLOPT_PROXY, $this->set_opt['proxyHost']);
            curl_setopt($this->ch, CURLOPT_PROXYPORT, $this->set_opt['proxyPort']);
            //代理要认证
            if ($this->set_opt['proxyAuth']) {
                $proxyAuthType = $this->set_opt['proxyAuthType'] == 'BASIC' ? CURLAUTH_BASIC : CURLAUTH_NTLM;
                curl_setopt($this->ch, CURLOPT_PROXYAUTH, $proxyAuthType);
                $user = "[{$this->set_opt['proxyAuthUser']}]:[{$this->set_opt['proxyAuthPwd']}]";
                curl_setopt($this->ch, CURLOPT_PROXYUSERPWD, $user);
            }
        }
        //启用时会将服务器服务器返回的“Location:”放在header中递归的返回给服务器
        curl_setopt($this->ch, CURLOPT_FOLLOWLOCATION, true);
        //打开的支持SSL
        if ($this->set_opt['ssl']) {
            //curl_setopt($this->ch, CURLOPT_FOLLOWLOCATION, 1);
            //curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
            //不对认证证书来源的检查
            curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, false);
            //从证书中检查SSL加密算法是否存在
            curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, true);
        }

        //设置http头,支持lighttpd服务器的访问
        $header[] = 'Expect:';
        curl_setopt($this->ch, CURLOPT_HTTPHEADER, $header);
        //设置 HTTP USER AGENT
        $userAgents = array(
            'Mozilla/5.0'
//            'chrome' => 'Mozilla/5.0 (X11; Linux i686) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.202 Safari/535.1',
//            'firefox' => 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1',
//            'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB6; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; OfficeLiveConnector.1.4; OfficeLivePatch.1.3)',
        );
        $userAgent = $this->set_opt['userAgent'] ? $this->set_opt['userAgent'] : $_SERVER['HTTP_USER_AGENT'];
        if (!$userAgent) {
            $userAgent = $userAgents[array_rand($userAgents)];
        }
        curl_setopt($this->ch, CURLOPT_USERAGENT, $userAgent);
        //设置连接等待时间,0不等待
        curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT, $this->set_opt['timeOut']);
        //设置curl允许执行的最长秒数
        curl_setopt($this->ch, CURLOPT_TIMEOUT, $this->set_opt['timeOut']);
        //设置客户端是否支持 gzip压缩
        if ($this->set_opt['gzip']) {
            curl_setopt($this->ch, CURLOPT_ENCODING, 'gzip');
        }
        //是否使用到COOKIE
        if ($this->set_opt['useCookie']) {
            //生成存放临时COOKIE的文件(要绝对路径)
            $cookfile = tempnam(sys_get_temp_dir(), 'cuk');
            //连接关闭以后，存放cookie信息
            curl_setopt($this->ch, CURLOPT_COOKIEJAR, $cookfile);
            curl_setopt($this->ch, CURLOPT_COOKIEFILE, $cookfile);
        }
        //是否将头文件的信息作为数据流输出(HEADER信息),这里保留报文
        curl_setopt($this->ch, CURLOPT_HEADER, true);
        //获取的信息以文件流的形式返回，而不是直接输出。
        curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($this->ch, CURLOPT_BINARYTRANSFER, true);
    }

    public function setHeader($key, $value) {

        $this->unsetHeader($key);

        $this->header[] = "$key: $value";
    }

    public function unsetHeader($key) {

        foreach ($this->header as $header_key => $header_value) {
            if (strpos(strtolower($header_value), strtolower($key)) === 0) {
                unset($this->header[$header_key]);
            }
        }
    }


    /**
     * 以 GET 方式执行请求
     *
     * @param string $url :请求的URL
     * @param array $params ：请求的参数,格式如: array('id'=>10,'name'=>'yuanwei')
     * @param array|string $referer :引用页面,为空时自动设置,如果服务器有对这个控制的话则一定要设置的.
     *
     * @return bool :false 正确返回:结果内容
     */
    public function getByCurl($url, $params = array(), $referer = '') {

//        if ($host) {
//            $this->setHeader('Host', $host);
//        }

        return $this->_request('GET', $url, $params, array(), $referer);
    }

    /**
     * 以 POST 方式执行请求
     *
     * @param string $url :请求的URL
     * @param array $params ：请求的参数,格式如: array('id'=>10,'name'=>'yuanwei')
     * @param array $uploadFile :上传的文件,支持相对路径,格式如下
     * 单个文件上传:array('img1'=>'./file/a.jpg')
     * 同字段多个文件上传:array('img'=>array('./file/a.jpg','./file/b.jpg'))
     * @param array|string $referer :引用页面,引用页面,为空时自动设置,如果服务器有对这个控制的话则一定要设置的.
     *
     * @return bool :false 正确返回:结果内容
     */
    public function _post($url, $params = array(), $uploadFile = array(), $referer = '') {
        return $this->_request('POST', $url, $params, $uploadFile, $referer);
    }

    public function _post_String($url, $params, $uploadFile = array(), $referer = '') {
        return $this->_request_String('POST', $url, $params, $uploadFile, $referer);
    }


    /**
     * 得到错误信息
     *
     * @return string
     */
    public function getError() {

        return curl_error($this->ch);
    }

    /**
     * 得到错误代码
     *
     * @return int
     */
    public function getErrCode() {

        return curl_errno($this->ch);
    }

    /**
     * 得到发送请求前和请求后所有的服务器信息和服务器Header信息,其中
     * [before] ：请求前所设置的信息
     * [after] :请求后所有的服务器信息
     * [header] :服务器Header报文信息
     *
     * @return array
     */
    public function getHeader() {

        return $this->info;
    }


    /**
     * 析构函数
     *
     */
    public function __destruct() {

        //关闭CURL
        curl_close($this->ch);
    }

    /**
     * 私有方法:执行最终请求
     *
     * @param string $method :HTTP请求方式
     * @param string $url :请求的URL
     * @param array $params ：请求的参数
     * @param array $uploadFile :上传的文件(只有POST时才生效)
     * @param array|string $referer :引用页面
     *
     * @return bool :false 正确返回:结果内容
     */
    private function _request($method, $url, $params = array(), $uploadFile = array(), $referer = '') {
        //如果是以GET方式请求则要连接到URL后面
        if ($method == 'GET') {
            $url = $this->_parseUrl($url, $params);
        }
        //设置请求的URL
        curl_setopt($this->ch, CURLOPT_URL, $url);

        curl_setopt($this->ch, CURLOPT_HTTPHEADER, $this->header);
        //设置了引用页,否则自动设置
        if ($referer) {
            curl_setopt($this->ch, CURLOPT_REFERER, $referer);
        } else {
            curl_setopt($this->ch, CURLOPT_AUTOREFERER, true);
        }
        curl_setopt($this->ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)");

        $urlInfo = parse_url($url);
        $cookieJar = "/tmp/cookie_{$urlInfo['host']}";
        curl_setopt($this->ch, CURLOPT_COOKIEJAR, $cookieJar);

        //如果是POST
        if ($method == 'POST') {
            //发送一个常规的POST请求，类型为：application/x-www-form-urlencoded
            curl_setopt($this->ch, CURLOPT_POST, true);
            //设置POST字段值
            $postData = $this->_parsmEncode($params, false);
            //如果有上传文件
            if ($uploadFile) {
                foreach ($uploadFile as $key => $file) {
                    if (is_array($file)) {
                        $n = 0;
                        foreach ($file as $f) {
                            //文件必需是绝对路径
                            $postData[$key . '[' . $n++ . ']'] = '@' . realpath($f);
                        }
                    } else {
                        $postData[$key] = '@' . realpath($file);
                    }
                }
            }
            //pr($postData); die;
            curl_setopt($this->ch, CURLOPT_POSTFIELDS, $postData);
        }

        //得到所有设置的信息
        $this->info['before'] = curl_getinfo($this->ch);
        //开始执行请求
        $result = curl_exec($this->ch);
        //得到报文头
        $headerSize = curl_getinfo($this->ch, CURLINFO_HEADER_SIZE);
        $this->info['header'] = substr($result, 0, $headerSize);
        //去掉报文头
        $result = substr($result, $headerSize);
        //得到所有包括服务器返回的信息
        $this->info['after'] = curl_getinfo($this->ch);
        //如果请求成功
        if ($this->getErrCode() == 0) { //&& $this->info['after']['http_code'] == 200
            return $result;
        } else {
            return false;
        }

    }


    /**
     * 私有方法:执行最终请求
     *
     * @param string $method :HTTP请求方式
     * @param string $url :请求的URL
     * @param array $params ：请求的参数，字符串
     * @param array $uploadFile :上传的文件(只有POST时才生效)
     * @param array|string $referer :引用页面
     *
     * @return bool :false 正确返回:结果内容
     */
    private function _request_String($method, $url, $params, $uploadFile = array(), $referer = '') {
        //如果是以GET方式请求则要连接到URL后面
        if ($method == 'GET') {
            $url = $this->_parseUrl($url, $params);
        }
        //设置请求的URL
        curl_setopt($this->ch, CURLOPT_URL, $url);

        curl_setopt($this->ch, CURLOPT_HTTPHEADER, $this->header);
        //设置了引用页,否则自动设置
        if ($referer) {
            curl_setopt($this->ch, CURLOPT_REFERER, $referer);
        } else {
            curl_setopt($this->ch, CURLOPT_AUTOREFERER, true);
        }
        curl_setopt($this->ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)");

        $urlInfo = parse_url($url);
        $cookieJar = "/tmp/cookie_{$urlInfo['host']}";
        curl_setopt($this->ch, CURLOPT_COOKIEJAR, $cookieJar);

        //如果是POST
        if ($method == 'POST') {
            //发送一个常规的POST请求，类型为：application/x-www-form-urlencoded
            curl_setopt($this->ch, CURLOPT_POST, true);
            //设置POST字段值
            $postData = $params;
            //如果有上传文件
            if ($uploadFile) {
                foreach ($uploadFile as $key => $file) {
                    if (is_array($file)) {
                        $n = 0;
                        foreach ($file as $f) {
                            //文件必需是绝对路径
                            $postData[$key . '[' . $n++ . ']'] = '@' . realpath($f);
                        }
                    } else {
                        $postData[$key] = '@' . realpath($file);
                    }
                }
            }
            //pr($postData); die;
            curl_setopt($this->ch, CURLOPT_POSTFIELDS, $postData);
        }

        //得到所有设置的信息
        $this->info['before'] = curl_getinfo($this->ch);
        //开始执行请求
        $result = curl_exec($this->ch);
        //得到报文头
        $headerSize = curl_getinfo($this->ch, CURLINFO_HEADER_SIZE);
        $this->info['header'] = substr($result, 0, $headerSize);
        //去掉报文头
        $result = substr($result, $headerSize);
        //得到所有包括服务器返回的信息
        $this->info['after'] = curl_getinfo($this->ch);
        //如果请求成功
        if ($this->getErrCode() == 0) { //&& $this->info['after']['http_code'] == 200
            return $result;
        } else {
            return false;
        }

    }
    /**
     * 返回解析后的URL，GET方式时会用到
     *
     * @param string $url :URL
     * @param array $params :加在URL后的参数
     *
     * @return string
     */
    private function _parseUrl($url, $params) {
        $fieldStr = $this->_parsmEncode($params);
        if ($fieldStr) {
            $url .= strstr($url, '?') === false ? '?' : '&';
            $url .= $fieldStr;
        }
        return $url;
    }

    /**
     * 对参数进行ENCODE编码
     *
     * @param array $params :参数
     * @param bool $isRetStr : true：以字符串返回 false:以数组返回
     *
     * @return string || array
     */
    private function _parsmEncode($params, $isRetStr = true) {
        $fieldStr = '';
        $spr = '';
        $result = array();
        foreach ($params as $key => $value) {
            $value = urlencode($value);
            $fieldStr .= $spr . $key . '=' . $value;
            $spr = '&';
            $result[$key] = $value;
        }
        return $isRetStr ? $fieldStr : $result;
    }

    /**
     * @param $url
     * @param $param
     * @param $cookie
     * @return mixed
     * 发送post请求
     */
    public static function doPost($url,$param,$cookie){
        $header[]= 'Cookie: '.$cookie;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($param));
        //curl_setopt($ch, CURLOPT_COOKIE, $cookie);
        curl_setopt($ch,CURLOPT_HTTPHEADER,$header);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }
}