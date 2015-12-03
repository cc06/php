<?php

/**
 * Time-stamp: <fanshengshuai 07/08/2014 17:52:49>
 */
class Controller_Admin_Ajax {
    public function getCategoryAction() {
		$parent_id = FRequest::getInt('parent_id');

		$categoryTable = new FTable('category');
		$cateList = $categoryTable->fields(array('cat_id', 'cat_name'))
			->where(array('status' => 1, 'parent_id' => $parent_id))
			->order(array('sort' => 'desc'))->select();

		FResponse::output($cateList);
    }
}
