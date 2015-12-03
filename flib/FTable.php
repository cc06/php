<?php

/**
 *
 * 作者: 范圣帅(fanshengshuai@gmail.com)
 *
 * 创建: 2012-08-08 10:57:22
 * vim: set expandtab sw=4 ts=4 sts=4 *
 *
 * $Id$
 */
class FTable {
    /**
     * @var array
     */
    private static $_connects = array();

    /**
     * @var string
     */
    private $_table = null;

    /**
     * @param string $table
     */
    public function setTable($table) {
        $this->_table = $table;
    }

    /**
     * @return string
     */
    public function getTable() {
        return $this->_table;
    }

    /**
     * @param array $pagerOptions
     */
    public function setPagerOptions($pagerOptions) {
        $this->pagerOptions = $pagerOptions;
    }

    /**
     * @return array
     */
    public function getPagerOptions() {
        return $this->pagerOptions;
    }

    /**
     * @param array $options
     */
    public function setOptions($options) {
        $this->options = $options;
    }

    /**
     * @return array
     */
    public function getOptions() {
        return $this->options;
    }

    /**
     * @var PDO
     */
    private $_dbh;

    /**
     * 连接数据库
     * @var
     */
    private $db;
    // 查询表达式参数
    /**
     * @var array
     */
    protected $options = array();
    /**
     * 分页配置项
     * @var array
     */
    protected $pagerOptions = array();
    /**
     * @var string
     */
    protected $table_info = null;
    // 查询表达式
    /**
     * @var string
     */
    protected $selectSql = 'SELECT%DISTINCT% %FIELD% FROM %TABLE%%JOIN%%WHERE%%GROUP%%HAVING%%ORDER%%LIMIT% %UNION%%COMMENT%';

    /**
     * 构建数据操作实例
     *
     * @param string $table
     *
     * @param null $as
     * @internal param array
     * @db_conf 连接的数据
     */
    public function __construct($table, $as = null,$db = "mumu") {
        global $_F;
        $this->db = $db;
        $this->_table = "`{$_F['db']['config']['table_pre']}{$table}`";
        if ($as) {
            $this->_table = $this->_table . " as {$as}";
        }
    }

    /**
     * 获取数据库连接
     * @param string $type
     * @return PDO
     */
    public function connect($type = 'w'){
        if ($this->db) {
            $db = $this->db;
        }
        $this->_dbh = FDB::connect($db,$type);
        return $this->_dbh;
    }



    /**
     * 设置使用缓存
     *
     * @param int $cacheTime
     *
     * @return $this
     * @internal param bool $useCache
     */
    public function cache($cacheTime = 3600) {
        if($cacheTime == 0){
            return $this;
        }
        $this->options['useCache'] = true;
        $this->options['cacheTime'] = $cacheTime;

        return $this;
    }

    /**
     * @param $fields
     *
     * @return $this
     */
    public function fields($fields) {
        $this->options['fields'] = $fields;
        return $this;
    }

    /**
     * where 查询条件
     *
     * @param null $conditions
     *
     * @return $this
     *
     * @example:
     *
     * $where = "uid > 10";
     * or
     * $where = array(
     *      'uid' => array('in' => '1, 2, 4'),
     *      'uid:1' => '1',
     *      'uid:2' => 'like \'%xxx%\'',  // like
     *      'uid:3' => 'gt 10',           // 大于 10
     *      'uid:4' => 'gte 10',          // 大于等于 10
     *      'uid:5' => 'lt 10',           // 小于 10
     *      'uid:6' => 'lte 10',          // 小于等于 10
     * );
     */
    public function where($conditions = null) {
        $params = array();
        if (is_string($conditions)) {
            $this->options['where'] = $conditions;
            $this->options['params'] = array();

        } elseif (is_array($conditions)) {
            $where = '';
            foreach ($conditions as $_k => $_v) {

                $tableFiled = $_k;
                if (is_array($_v)) {

                    foreach ($_v as $where_item_sub_key => $where_item_sub_value) {

                        // array("in", '(1, 2, 3)'); 内容不是数组的跳过
                        // array(array('in' => '(1, 2)'))；只解析这样的
                        if (is_numeric($where_item_sub_key)) {
                            continue;
                        }

                        $where_item_sub_key = str_replace(array('gte', 'lte', 'gt', 'lt', 'neq', 'eq','is','is not'),
                            array('>= ', '<= ', '> ', '< ', '<>', '=','is','is not'), $where_item_sub_key);

                        if (strpos(strtolower($where_item_sub_key), 'in') !== false) {
                            if (is_array($where_item_sub_value)) {
                                $where_item_sub_value = join(',', $where_item_sub_value);
                            }
                            $where[] .= "$tableFiled {$where_item_sub_key} ( " . $where_item_sub_value . " )";
                        } elseif (strpos(strtolower($where_item_sub_key), 'like') !== false) {
                            $where[] .= "$tableFiled {$where_item_sub_key} ?";

                            if (strpos($where_item_sub_value, '%') === false) {
                                $params[] = "%" . trim(str_replace(array('like', 'LIKE'), '', $where_item_sub_value)) . "%";
                            } else {
                                $params[] = trim(str_replace(array('like', 'LIKE'), '', $where_item_sub_value));
                            }
                        }else {
                            $where[] .= "$tableFiled {$where_item_sub_key} ?";
                            $params[] = $where_item_sub_value;
                        }

                        // 解析完后删除条件，剩下的条件由下面代码解析
                        unset($conditions[$_k][$where_item_sub_key]);
                    }

                    continue;
                }

                if (strpos($tableFiled, ':')) {
                    $tableFiled = substr($tableFiled, 0, strpos($tableFiled, ':'));
                }

                $__v = strtolower($_v);
                if (strpos($__v, 'like ') !== false) {
                    $where[] .= "{$_k} like ?";
                    $params[] = "%" . trim(str_replace(array('like', 'LIKE'), '', $_v)) . "%";
                } elseif (
                    strpos($_v, 'gt ') !== false || strpos($_v, 'lt ') !== false ||
                    strpos($_v, 'gte ') !== false || strpos($_v, 'lte ') !== false
                ) {
                    $opt = substr($_v, 0, strpos($_v, ' '));
                    $param = trim(substr($_v, strpos($_v, ' ')));
                    $opt = str_replace(array('gte', 'lte', 'gt', 'lt'), array('>= ', '<= ', '> ', '< '), $opt);

                    $where[] .= "{$tableFiled} $opt ?";
                    $params[] = $param;

                }elseif ($tableFiled == "str" || $tableFiled == ""){
                    $where[] .= $_v;
                }else {
                    $where[] .= "{$tableFiled} = ?";
                    $params[] = $_v;
                }
            }

            if ($where) {
                $this->options['where'] = join(' and ', $where);
                $this->options['params'] = $params;
            }
        }

        return $this;
    }

    /**
     * 排序
     *
     * @param $order
     *
     * @return $this
     */
    public function order($order) {
        if (is_array($order)) {
            $orderClause = '';
            foreach ($order as $field => $orderBy) {
                $orderClause .= $field . ' ' . $orderBy . ',';
            }
            $this->options['order_by'] = rtrim($orderClause, ',');
        } elseif ($order && is_string($order)) {
            $this->options['order_by'] = $order;
        }

        return $this;
    }

    /**
     * GROUP BY 条件
     * @param $a
     * @return $this
     */
    public function groupBy($a) {
        $this->options["group_by"] = $a;
        return $this;
    }

    /**
     * having 条件
     * @param $a
     * @return $this
     */
    public function having($a) {
        $this->options["having"] = $a;
        return $this;
    }
    /**
     * 获取一条记录
     *
     * @param null $priValue mix 主键数值
     *
     * @throws Exception
     * @internal param string $conditions
     * @internal param array $columns
     *
     * @internal param array $params
     *
     * @internal param array $param
     * @internal param \columns $array 列
     *
     * @return array || null
     */
    public function find($priValue = null) {
        global $_F;
        $retData = null;

        // 按主键查询
        if ($priValue) {
            $this->table_info = $this->getTableInfo();
            if (!$this->table_info['pri']) throw new Exception("该表没有设置主键，无法通过 find 参数查询。");
            $this->where($this->table_info['pri'] . '=\'' . $priValue . '\'');
        }

        $this->limit(1);
        $sql = $this->buildSql();

        // 缓存处理
        $cacheKey = "SQL-RESULT-{$this->_table}-{$sql}-" . ($this->options['params'] ? join('-', $this->options['params']) : '');
        if ($this->options['useCache']) {

            $cacheValue = FCache::get($cacheKey);
            if ($cacheValue) {
                $this->reset();
                return $cacheValue;
            }
        }

        if ($_F['debug'])
            $_F['debug_info']['sql'][] = array('sql' => $sql, 'params' => $this->options['params']);

        try {
            $this->connect(FDB::$DB_READ);
            $stmt = $this->_dbh->prepare($sql);
            $stmt->execute($this->options['params']);
            $retData = $stmt->fetch(PDO::FETCH_ASSOC);

        } catch (PDOException $e) {
            throw new Exception($e);
        }

        // 缓存处理
        if ($this->options['useCache'])
            FCache::set($cacheKey, $retData, $this->options['cacheTime']);

        $this->reset();
        return $retData;
    }

    /**
     * 查询操作
     *
     * @return mixed
     * @throws Exception
     */
    public function select() {
        global $_F;
        $sql = $this->buildSql();
        // 处理分页参数，放在 缓存处理 之前
        if ($this->options['page']) {
            $this->setPagerOptions(array(
                'where' => $this->options['where'],
                'params' => $this->options['params'],
                'page' => $this->options['page'],
                'limit' => $this->options['limit'],
                'group_by'=>$this->options['group_by'],
                'fields' => $this->options['fields']));
        }

        // 缓存处理
        $cacheKey = "SQL-RESULT-{$this->_table}-{$sql}-" . ($this->options['params'] ? join('-', $this->options['params']) : '');
        if ($this->options['useCache']) {

            $cacheValue = FCache::get($cacheKey);

            if ($cacheValue) {
                // 放在 return 之前，不要忘记 cache 模式也要重置
                $this->reset();
                return $cacheValue;
            }
        }

        if ($_F['debug'])
            $_F['debug_info']['sql'][] = array('sql' => $sql, 'params' => $this->options['params']);

        try {

           // $logger->append($sql);
            $db = $this->connect(FDB::$DB_READ);
         //   $stmt = $this->_dbh->prepare($sql);
            $stmt = $db->prepare($sql);
            $stmt->execute($this->options['params']);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        } catch (PDOException $e) {
            throw new Exception($e);
        }

        // 缓存处理
        if ($this->options['useCache'])
            FCache::set($cacheKey, $rows, $this->options['cacheTime']);

        // 放在 return 之前，不要忘记 cache 模式也要重置
        $this->reset();
        return $rows;
    }

    /**
     * 统计记录数目
     *
     * @return mixed
     */
    public function count() {
        $this->options['page'] = 1;

        if ($this->options['fields']) {
            $this->options['fields'] = array("COUNT({$this->options['fields'][0]}) as count");
        } else {
            $this->options['fields'] = array("COUNT(*) as count");
        }
        $result = $this->find();

        return $result['count'];
    }

    /**
     * @return string
     * @throws Exception
     */
    private function buildSql() {
        global $_F;

        $columns = null;
        if ($this->options['fields'] && is_array($this->options['fields'])) {
            $columns = implode(',', $this->options['fields']);
        } elseif ($this->options['fields'] && is_string($this->options['fields'])) {
            $columns = $this->options['fields'];
        } else {
            $columns = '*';
        }

        $sql = "SELECT $columns FROM {$this->_table}";

        if ($this->options['where']) {
            $sql .= ' WHERE ' . $this->options['where'];
        }
        /*** update by caofei 2014-09-23 兼容group by 和 order by 同时使用  ***/
        if ($this->options['group_by']) {
            $sql .= ' GROUP BY ' . $this->options['group_by'];
        }
        if ($this->options['order_by']) {
            $sql .= ' ORDER BY ' . $this->options['order_by'];
        }
      /*** update by wxw 2015-08-31 兼容having  ***/
        if ($this->options['having']) {
            $sql .= ' having ' . $this->options['having'];
        }

        if ($this->options['page'] > 0) {

            if (!$this->options['limit']) {
                throw new Exception('limit cannot be 0 when use page function, please use limit function to set it.');
            }

            $sql .= ' limit ' . (($this->options['page'] - 1) * $this->options['limit']) . ',' . $this->options['limit'];

        } elseif ($this->options['limit'] > 0) {
            $sql .= ' limit ' . $this->options['limit'];
        }
//echo($sql);
        return $sql;
    }


    /**
     * 分页：页数
     *
     * @param $page
     *
     * @return $this
     */
    public function page($page) {
        $this->options['page'] = max(1, $page);
        return $this;
    }

    /**
     * 要取出条数
     *
     * @param $limit
     *
     * @return $this
     */
    public function limit($limit) {
        $this->options['limit'] = $limit;
        return $this;
    }

    /**
     * 插入一条记录 或更新表记录
     *
     * @param array $data
     *
     * @throws Exception
     * @internal param string $conditions
     * @internal param array $params
     *
     * @internal param array $param
     *
     * @return bool || int
     */
    public function save($data) {
        global $_F;

        $tempParams = array();
        $set = array();
        foreach ($data as $k => $v) {
            array_push($set, '`' . $k . '`' . '= ?');
            array_push($tempParams, $v);
        }

        if ($this->options['where']) {
            // 更新
            $sql = "UPDATE {$this->_table} SET " . join(', ', $set) . " WHERE {$this->options['where']}";
            $params = array_merge($tempParams, $this->options['params']);
        } else {
            // 插入
            $sql = "INSERT INTO {$this->_table} SET " . join(', ', $set);
            $params = $tempParams;
        }

        if ($_F['debug']) {
            $_F['debug_info']['sql'][] = array('sql' => $sql, 'params' => $this->options['params']);
        }

        // 捕获PDOException后 抛出Exception
        try {
            $this->connect(FDB::$DB_WRITE);
            $stmt = $this->_dbh->prepare($sql);
            $stmt->execute($params);

            $this->reset();

            return $stmt->rowCount();
        } catch (PDOException $e) {
            throw new Exception($e);
        }
    }

    /**
     * 增加一条数据
     *
     * @param $data
     *
     * @return bool
     */
    public function insert($data) {
        $this->reset();
        $this->save($data);
        return $this->_dbh->lastInsertId();
    }

    /**
     * 更新一条数据
     *
     * @param $data
     * @param $where
     *
     * @throws Exception
     * @return bool
     */
    public function update($data, $where = null) {

        if ($where) {
            $this->reset();
            $this->where($where);
        }

        if (!$this->options['where']) {
            throw new Exception("FDB update need condition.");
        }
        return $this->save($data);
    }

    /**
     * 获取刚刚写入记录的ID
     *
     * @throws Exception
     * @return int
     */
    public function lastInsertId() {

        try {
            return $this->_dbh->lastInsertId();
        } catch (PDOException $e) {
            throw new Exception($e);
        }
    }

    /**
     * 删除一条数据，需要通过where方法设置条件，参数为true为真删除
     * @return bool
     * @throws Exception
     */
    public function remove() {
        global $_F;

        // 检查条件
        if (!$this->options['where'])
            throw new Exception("FTable REMOVE function need where params. 我认为没有条件的删除是很危险的。");

        $sql = "DELETE from $this->_table WHERE {$this->options['where']}";

        if ($_F['debug'])
            $_F['debug_info']['sql'][] = array('sql' => $sql, 'params' => $this->options['params']);

        try {
            $this->connect(FDB::$DB_WRITE);
            $stmt = $this->_dbh->prepare($sql);
            $result = $stmt->execute($this->options['params']);

            $this->reset();
        } catch (PDOException $e) {
            throw new Exception($e);
        }

        return $result;
    }

    /**
     * 自增
     *
     * @param $field
     * @param int $unit
     *
     * @throws Exception
     * @internal param $conditions
     * @internal param array $params
     * @return mixed
     */
    public function increase($field, $unit = 1) {

        if (!$this->options['where']) {
            throw new Exception('FTable increase function need condition');
        }

        $sql = "UPDATE {$this->_table} SET `$field` = `$field` + $unit";
        $sql .= ' WHERE ' . $this->options['where'];

        try {
            $this->connect(FDB::$DB_WRITE);
            $stmt = $this->_dbh->prepare($sql);
            $result = $stmt->execute($this->options['params']);
        } catch (PDOException $e) {
            throw new Exception($e);
        }

        return $result;
    }

    /**
     * 自减
     *
     * @param $field
     * @param int $unit
     *
     * @throws Exception
     * @internal param $conditions
     * @internal param array $params
     * @return mixed
     */
    public function decrease($field, $unit = 1) {

        if (!$this->options['where']) {
            throw new Exception('FTable decrease function need condition');
        }

        $sql = 'UPDATE ' . $this->_table . " SET $field = IF($field > $unit,  $field - $unit, 0)";
        $sql .= ' WHERE ' . $this->options['where'];

        try {
            $this->connect(FDB::$DB_WRITE);
            $stmt = $this->_dbh->prepare($sql);
            $result = $stmt->execute($this->options['params']);
        } catch (PDOException $e) {
            throw new Exception($e);
        }

        return $result;
    }

    /**
     * @return bool
     * @throws Exception
     */
    public function truncate() {
        global $_F;

        if (!$_F['truncate_confirm']) {
            return false;
        }

        $sql = "TRUNCATE  $this->_table  ";
        //echo "$sql \n";
        $params = array();
        try {
            $this->connect(FDB::$DB_WRITE);
            $stmt = $this->_dbh->prepare($sql);
            $this->reset();
            return $stmt->execute($params);
        } catch (PDOException $e) {
            throw new Exception($e);
        }
    }

//    /**
//     * 开启事务
//     */
//    public function begin() {
//
//        $this->_dbh->beginTransaction();
//    }
//
//    /**
//     * 提交事务
//     */
//    public function commit() {
//
//        $this->_dbh->commit();
//    }
//
//    /**
//     * 回滚事务
//     */
//    public function rollBack() {
//
//        $this->_dbh->rollBack();
//    }

    /**
     *
     *
     */
    public function reset() {
        $this->options = null;
    }

    /**
     * 获得表结构
     * @return array|null
     * @throws Exception
     */
    private function getTableInfo() {
        $tableInfo = FCache::get($this->_table);
        if ($tableInfo) {
            return $tableInfo;
        }

        try {
            $sql = "desc $this->_table";
            $this->connect(FDB::$DB_READ);
            $stmt = $this->_dbh->prepare($sql);
            $stmt->execute();
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

            $tableInfo = array('pri' => null, 'fields' => null);
            foreach ($rows as $row) {
                if ($row['Key'] == 'PRI') {
                    $tableInfo['pri'] = $row['Field'];
                }
            }
            $tableInfo['fields'] = $rows;

            FCache::set($this->_table, $tableInfo, 8640000);

        } catch (PDOException $e) {
            FLogger::write("获取表信息失败: " . $this->_table . "\t" . $e->getMessage());
            throw new Exception("获取表信息失败。");
        }

        return $tableInfo;
    }

    /**
     * 获得分页信息
     *
     * @throws Exception
     * @return array
     */
    public function getPagerInfo() {
        global $_F;

        $this->options = $this->getPagerOptions();
        $count = $this->count();
        $pagerOptions = $this->getPagerOptions();

        if (!isset($pagerOptions['page'])) {
            if ($_F['debug']) {
                throw new Exception('使用 getPagerInfo 的时候，必须在查询方法上使用 page 参数。如：$table->page(1)->limit(20)->select();');
            } else {
                return false;
            }
        }

        return FPager::getPagerInfo($count, $pagerOptions['page'], $pagerOptions['limit']);
    }

    /**
     * LEFT JOIN
     *
     * @param      $table
     * @param      $as
     * @param null $on
     *
     * @return $this
     */
    public function leftJoin($table, $as, $on = null) {
        $this->_table = "{$this->_table} LEFT JOIN `{$table}` as {$as}";

        if ($on) $this->on($on);

        return $this;
    }

    /**
     * RIGHT JOIN
     *
     * @param      $table
     * @param      $as
     * @param null $on
     *
     * @return $this
     */
    public function rightJoin($table, $as, $on = null) {
        $this->_table = "{$this->_table} RIGHT JOIN `{$table}` as {$as}";

        if ($on) $this->on($on);

        return $this;
    }

    /**
     * INNER JOIN
     *
     * @param      $table
     * @param      $as
     * @param null $on
     *
     * @return $this
     */
    public function innerJoin($table, $as, $on = null) {
        $this->_table = "{$this->_table} INNER JOIN `{$table}` as {$as}";

        if ($on) $this->on($on);

        return $this;
    }

    public function on($condition) {
        $this->_table = "{$this->_table} on {$condition}";
        return $this;
    }

    public function countForGroupBy($count,$page,$limit){
        global $_F;
        return FPager::getPagerInfo($count,$page,$limit);
    }
}
