<?php
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Services\ShopBrandService;

/**
 * 抢购活动
 */
class ShopBrandController extends BaseController{
    public function getList(){
        $data = ShopBrandService::getList($this->request('status'));
        return $this->outputData($data);
    }

    public function getListById(){
        $data = ShopBrandService::getListById(
            $this->request('id')
        );
        return $this->outputData($data);
    }
    public function delete(){
        $data = ShopBrandService::delete(
            $this->request('id')
        );
//        return output($data);
        return $this->outputData($data);
    }
    public function save(){
        $result = ShopBrandService::save(
            intval($this->request('id')),
            strval($this->request('name')),
            strval($this->request('introduce')),
            intval($this->request('status')),
            strval($this->request('img')),
            $this->request('url'),
            $this->request('images')
        );
        return $this->output($result);
    }
	//查找品牌
	public function search(){
		$data = ShopBrandService::search($this->request('content'));
        return $this->outputData($data);
	}
}