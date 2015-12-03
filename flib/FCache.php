<?php

/**
 * 缓存类 memcache
 * Class FCache
 */
class FCache {
    /**
     * 设置cache
     * @param $cache_key
     * @param $cache_content
     * @param int $cache_time
     * @return bool
     */
    public static function set($cache_key, $cache_content, $cache_time = 7200) {
        global $_F;
        self::connect();

        if ($_F['cache']) {
            $cache_key = $_F['domain'] . $cache_key;
            $_F['cache']->set($cache_key, $cache_content, MEMCACHE_COMPRESSED, $cache_time);
            return true;
        }else{
            return false;
        }
    }

    /**
     * 获取cache
     * @param $cache_key
     * @return mixed
     */
    public static function get($cache_key) {
        global $_F;
        self::connect();
        if ($_F["cache"]) {
            $cache_key = $_F['domain'] . $cache_key;
            return $_F['cache']->get($cache_key);
        }
        return null;
    }

    /**
     * 删除cache
     * @param $cache_key
     * @return bool
     */
    public static function delete($cache_key) {
        global $_F;
        self::connect();
        if ($_F["cache"]) {
            $cache_key = $_F['domain'] . $cache_key;
            $_F['cache']->delete($cache_key);
            return true;
        }
    }

    /**
     * 连接
     */
    public static function connect() {
        global $_F;
        try{
            $ip = FConfig::get('global.cache.ip');
            $port = FConfig::get('global.cache.port');
            $isOpen = FConfig::get('global.cache.isOpen');
            if($isOpen){
                $cache = new Memcache;
                $result = $cache->connect($ip, $port);
                if($result){
                    $_F['cache'] = $cache;
                }
                return true;
            }else{
                return false;
            }
        }catch (Exception $e){
            return false;
        }
    }

    /**
     * 清空cache
     * @return bool
     */
    public static function flush() {
        global $_F;
        self::connect();
        if ($_F["cache"]) {
            $_F['cache']->flush();
            return true;
        }
        return false;
    }
}