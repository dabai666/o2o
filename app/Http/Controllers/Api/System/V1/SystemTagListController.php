<?php 
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Models\SystemTagList;
use YiZan\Services\SystemTagListService;
use YiZan\Utils\Time;

class SystemTagListController extends BaseController {

	/**
	 * [lists 获取标签分类列表]
	 * @return [type] [description]
	 */
	public function lists() {
        $data = SystemTagListService::getList(
            $this->request('status')
        );
        return $this->outputData($data);
    }


    /**
     *  创建商品标签分类
     */
    public function save() {
        $result = SystemTagListService::save(
        	intval($this->request('id')),
            strval($this->request('name')),
            intval($this->request('sort')),
            intval($this->request('status')),
            intval($this->request('pid')),
            intval($this->request('systemTagId')),
            strval($this->request('img'))
        );
        return $this->output($result);
    }

    /**
     * [get 获取单个分类信息]
     * @return [type] [description]
     */
    public function get() {
    	$result = SystemTagListService::get(
        	intval($this->request('id'))
        );
        return $this->outputData($result);
    }

    /**
     * [secondLevel 通过一级分类获取二级分类]
     * @return [type] [description]
     */
    public function secondLevel() {
        $result = SystemTagListService::secondLevel(
            $this->request('pid')
        );

        return $this->outputData($result);
    }

    /**
     * 标签分类删除
     */
    public function delete() {
        $result = SystemTagListService::delete(
            $this->request('id')
        );
        return $this->output($result);
    }

    public function getTagListFirst(){
        $systemTag = SystemTagList::where('pid','=',0)->get();
        $systemTagList = $systemTag ? $systemTag->toArray() : array();
        return $this->outputData($systemTagList);
    }

    public function getTagListByPid(){
        $systemTag = new SystemTagList();
        if($this->request('pid') > 0){
            $systemTag = $systemTag->where('pid','=',$this->request('pid'))->get();
        }else{
            $systemTag = array();
        }
        $systemTagList = $systemTag ? $systemTag->toArray() : array();
        return $this->outputData($systemTagList);
    }

}