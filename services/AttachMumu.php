<?php

class Service_AttachMumu
{
    private $oss;
    private $bucket;

    public function __construct()
    {
        $this->oss = new Service_Oss();
        $this->bucket = 'yfb';
    }

    /**
     * @param string $conf
     *
     * @return Service_Attach
     */
    public static function getInstance($conf = 'oss')
    {
        static $oss = array();
        if (isset($oss[$conf])) {
            return $oss[$conf];
        } else {
            $oss[$conf] = new self;
            return $oss[$conf];
        }
    }

    /**
     * @return string
     */
    public function uploadAvatar()
    {
        return $this->uploadOSS('avatar', 'avatar');
    }

    public function uploadAvatarBig()
    {
        return $this->uploadOSS('avatar_big', 'avatar_big');
    }

    public function uploadOSS($input_file_field = 'pic', $save_dir = 'pic', $ext = 'jpg')
    {

        $file_path = $_FILES[$input_file_field]["tmp_name"];

        if (!$file_path) {
            FLogger::write('tmp_name为空', 'update_mumu');
            return '';
        }

        $file_md5 = md5_file($file_path);

        $_file_path_info = pathinfo($_FILES [$input_file_field]['name']);
        $file_ext = strtolower($_file_path_info['extension']);

        if (!$file_ext) {
            $this->get_extension($file_path);
        }

        if (!$file_ext) $file_ext = $ext;

        $content_type = MimeTypes::get_mimetype(strtolower($file_ext));

        $object = 'oss/' . $save_dir . '/' . date('Ym/d/His') . rand(10000, 99999) . '.' . $file_ext;

        $flag = $this->oss->upload_by_file($this->bucket, 'uploads/' . $object, $file_path, $content_type);


        if (!$flag) {
            $object = '';
        }

        $data = array(
            'object' => $object,
            'md5' => $file_md5
        );

        return $data;
    }

    public function uploadPhoto($input_file_field = 'userfile')
    {
        return $this->uploadOSS($input_file_field, 'photo');
    }

    public function getPhotoUrl($photo_url, $w = 0, $h = 0)
    {
        return $this->getThumbUrl($photo_url, $w, $h);
    }

    public function getThumbUrl($thumb_url, $w = 0, $h = 0)
    {
        global $_F;


        $ret = "";
        if (substr($thumb_url, 0, 4) == 'oss/') {

            if (strpos($thumb_url, 'ttp://')) {
                $ret = $thumb_url;
            } else {
                $ret = $_F['s_url_oss'] . '/uploads/' . $thumb_url;
            }

            if ($w > 0 && $h > 0) {
                $ret .= '@1e_' . $w . 'w_' . $h . 'h_1c_0i_1o_90Q_1x.jpg';
            }

        } else {

            if (strpos($thumb_url, 'ttp://')) {
                $ret = $thumb_url;
            } else {
                $ret = $_F['s_url'] . '/uploads/' . $thumb_url;
            }

            if ($w > 0 && $h > 0) {
                $ret .= '_' . $w . '_' . $h . '.jpg';
            }

        }

        if (!$thumb_url) {
            $ret = "";
        }

        return $ret;
    }

    public function get_extension($file)
    {
        return end(explode('.', $file));
    }

}