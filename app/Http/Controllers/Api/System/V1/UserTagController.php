<?php 
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Services\UserTagService;
use YiZan\Utils\Time;

class UserTagController extends BaseController {
	
	/**
	 * [lists 获取标签分类列表]
	 * @return [type] [description]
	 */
	public function lists() {
        $data = UserTagService::getList(
            $this->request('status'),
            $this->request('name')
        );
        return $this->outputData($data);
    }


    /**
     *  创建商品标签分类
     */
    public function save() {
        $result = UserTagService::save(
        	intval($this->request('id')),
            strval($this->request('name')),
            intval($this->request('sort')),
            intval($this->request('status'))
        );
        return $this->output($result);
    }

    /**
     * [get 获取单个分类信息]
     * @return [type] [description]
     */
    public function get() {
    	 $result = UserTagService::get(
        	intval($this->request('id'))
        );
        return $this->output($result);
    }

    /**
     * 分类信息删除
     */
    public function delete() {
        $result = UserTagService::delete(
            $this->request('id')
        );
        return $this->output($result);
    }


}