<?php 
namespace YiZan\Http\Controllers\Api\System\System;

use YiZan\Services\System\SystemConfigService;
use YiZan\Http\Controllers\Api\System\BaseController;
use Input;
/**
 * 系统设置
 */
class ConfigController extends BaseController 
{
	/**
     * 获取配置
	 */
	public function get()
    {
        $data = SystemConfigService::getLists($this->request('groupCode'));
        return $this->outputData($data);
    }
    public function getOne(){
        $data = SystemConfigService::getListsOne($this->request('code'));

        return $this->outputCode($data);
    }

    //修改秒杀专区的设置
    public function updateOne(){
        $result = SystemConfigService::updateOne(Input::all());
        return $this->output($result);
    }

    /**
     * 修改配置
     */
    public function update() 
    {
        $result = SystemConfigService::update($this->request('configs'));
        
        return $this->output($result);
    }
}