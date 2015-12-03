<?php
/**
 *
 * 阿里云oss操作类
 * Created by PhpStorm.
 * User: zijunna
 * Date: 14-9-5
 * Time: 下午2:27
 *
 * //使用实例
 * //创建阿里云工具类,并上传到阿里云，生成访问地址返回
 * $aliyunUtil = new AliyunUtil();
 * echo $aliyunUtil->upload();
 *
 *
 */

require_once APP_ROOT . '/lib/aliyun-php-sdkv2-20130815/aliyun.php';
use \Aliyun\OSS\OSSClient;

class AliyunUtil {

    public $AccessKeyId = ""; //阿里云秘钥
    public $AccessKeySecret = ""; //阿里云秘钥
    public $buckeObject = array( //阿里云的bucke和域名的对应关系
        "pic.cdn" => array(
            "buckeName" => "aikanjia-img",
            "url"       => "http://res.cdn.51caijia.com",
        ),
    );
    public $client;
    private $fileName = 'FileData'; //阿里云oss对象

    /**
     * 构造方法初始化阿里云sdk
     */
    public function __construct() {
        $this->client = OSSClient::factory(array(
            'AccessKeyId'     => $this->AccessKeyId,
            'AccessKeySecret' => $this->AccessKeySecret,
            'Endpoint'        => 'http://oss-cn-qingdao-internal.aliyuncs.com',
        ));
    }

    /**
     * 获取所有的buckets
     */
    public function getBuckets() {
        $buckets = $this->client->listBuckets();
        foreach ($buckets as $bucket) {
            echo $bucket->getName() . "\n";
        }
    }

    /**
     * 上传文件到阿里云oss
     *
     * @param $saveFile         要保存到oss上的文件，包括路径 如：upload/aaa.jpg
     * @param $localFile        需要上传到oss的本地的文件，包括路径 如：tmp/aaa.jpg
     */
    public function aliyun_upload($localFile, $ossSaveFile) {
        $bucketName = $this->buckeObject["pic.cdn"]["buckeName"];
        $url = $this->buckeObject["pic.cdn"]["url"];
        if (file_exists($localFile)) {
            try {
                $this->client->putObject(array(
                    'Bucket'        => $bucketName,
                    'Key'           => $ossSaveFile,
                    'Content'       => fopen($localFile, "r"),
                    'ContentLength' => filesize($localFile),
                ));
                return $url . '/' . $ossSaveFile;
            } catch (Exception $e) {
                $fLogger = new FLogger('aliyun');
                $fLogger->append($e->getMessage());
                return "error";
            }
        } else {
            return "not file";
        }
    }

    /**
     * 下载一个阿里云上的资源
     *
     * @param $ossSaveFile
     */
    public function aliyun_download($ossSaveFile) {
        $bucketName = $this->buckeObject["pic.cdn"]["buckeName"];
        $object = $this->client->getObject(array(
            'Bucket' => $bucketName,
            'Key'    => $ossSaveFile,
        ));

        echo "Key: " . $object->getKey() . "\n";
        echo "Update Date: " . $object->getLastModified()->getTimestamp() . "\n";
        echo "Content: \n";
        echo stream_get_contents($object->getObjectContent()); // Print object's content.
    }

    /**
     * 获取list
     */
    public function getList($buckeName) {
        $objectListing = $this->client->listObjects(array(
            'Bucket' => $buckeName,
        ));
        foreach ($objectListing->getObjectSummarys() as $objectSummary) {
            echo $objectSummary->getKey();
        }
    }

    /**
     * 创建一个Bucket
     *
     * @param $name
     */
    public function createBucket($name) {
        $this->client->createBucket(array(
            'Bucket' => $name,
        ));
    }


    //====================================以下为文件上传操作=====================================


    public function setFileName($fileName = 'FileData') {
        $this->fileName = $fileName;
    }


    /**
     * 进行上传操作
     *
     * @param string $aliyunPath          //阿里云的上传目录
     * @param string $uploadFileTypeLimit //上传的文件类型限制
     * @param int    $uploadFileSizeLimit //上传的文件大小限制,大小单位为KB
     *
     * @return string
     */
    public function upload($aliyunPath = "upload/", $uploadFileTypeLimit = "img", $uploadFileSizeLimit = 3072) {
        //获取文件参数
        $error = $_FILES[$this->fileName]["error"];
        $size = $_FILES[$this->fileName]["size"];
        $name = $_FILES[$this->fileName]["name"];
        $tmp_name = $_FILES[$this->fileName]["tmp_name"];

        //获取文件后缀
        $temp_arr = explode(".", $name);
        $file_ext = array_pop($temp_arr);
        $file_ext = trim($file_ext);
        $file_ext = strtolower($file_ext);
        $type = $file_ext;

        //判断上传类型和上传文件大小
        if ($this->isNorm_uploadType($uploadFileTypeLimit, $type) == false) {

            $retData = array(
                'status' => 500,
                'msg' => "file type no norm , type : " . join(",", $this->getLimitTypeList($uploadFileTypeLimit)),
            );

            return $retData;

        } elseif ($this->isNorm_uploadSize($uploadFileSizeLimit, $size) == false) {

            $retData = array(
                'status' => 500,
                'msg' => "file size no norm , size : " . $uploadFileSizeLimit . "kb",
            );

            return $retData;

        } else {
            if ($error > 0) {

                $retData = array(
                    'status' => '10' . $error,
                    'msg' => "upload error",
                );

                return $retData;
            } else {
                //生成文件名
                $saveFileName = date('YmdHis') . '_' . rand(10000, 90000) . '.' . $file_ext;
                //调用阿里云上传文件
                $aliyunUploadInfo = $this->aliyun_upload($tmp_name, $aliyunPath . $saveFileName);

                        $fLogger = new FLogger('debug');
        $fLogger->append('uploadding...');

                $retData = array(
                    'status' => 200,
                    'url' => $aliyunUploadInfo
                );

                return $retData;
            }
        }
    }

    /**
     * 文件上传规范
     * @var array
     */
    public $limitTypeList = array(
        "img" => array(
            "png",
            "jpeg",
            "pjpeg",
            "jpg",
        ),
    );

    /**
     * 获取限制类型
     *
     * @param $typeName
     *
     * @return mixed
     */
    public function getLimitTypeList($typeName) {
        return $this->limitTypeList[$typeName];
    }

    /**
     * 检测上传的文件类型是否符合限制
     *
     * @param $uploadFileTypeLimit
     * @param $fileType
     *
     * @return bool
     */
    public function isNorm_uploadType($uploadFileTypeLimit, $fileType) {
        return in_array($fileType, $this->limitTypeList[$uploadFileTypeLimit]);
    }

    /**
     * 检测上传的文件大小是否符合限制
     *
     * @param $uploadFileSizeLimit
     * @param $fileSize
     *
     * @return bool
     */
    public function isNorm_uploadSize($uploadFileSizeLimit, $fileSize) {
        if ($fileSize <= ($uploadFileSizeLimit * 1024)) {
            return true;
        }
        return false;
    }
}
