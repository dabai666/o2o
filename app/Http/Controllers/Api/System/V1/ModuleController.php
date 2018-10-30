<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/14
 * Time: 14:52
 */
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Services\ModuleService;
use YiZan\Http\Controllers\Api\System\BaseController;
use Lang, Validator;

/**
 * 模块管理
 */
class ModuleController extends BaseController{
    /**
     * 模块列表
     */
    public function lists()
    {
        $data = ModuleService::getList();
        return $this->outputData($data);
    }

    //添加模块
    public function create(){
        $result = ModuleService::create
        (
            $this->request('name'),
            $this->request('image'),
            $this->request('type'),
            intval($this->request('sort')),
            intval($this->request('status')),
            $this->request('produce')
        );
        return $this->output($result);
    }

    public function update(){

        $result = ModuleService::update
        (
            intval($this->request('id')),
            $this->request('name'),
            $this->request('image'),
            $this->request('type'),
            intval($this->request('sort')),
            intval($this->request('status')),
            $this->request('produce')
        );
        return $this->output($result);
    }
    public function get(){
        $adv = ModuleService::getById(intval($this->request('id')));
        return $this->outputData($adv == false ? [] : $adv->toArray());
    }

    //删除模块
    public function delete(){
        $result = ModuleService::delete($this->request('id'));
        return $this->output($result);
    }
    //获取金融超市链接的信息
    public function getInfo(){
        $info = ModuleService::getInfo(1);
        return $this->outputData($info == false ? [] : $info->toArray());
    }

    //添加金融超市链接
    public function FinanceSupermarkCreate(){
        $result = ModuleService::FinanceSupermarkCreate
        (
            $this->request('url')

        );
        return $this->output($result);
    }
    //更新金融超市链接
    public function FinanceSupermarkUpdate(){
        $result = ModuleService::FinanceSupermarkUpdate
        (
            intval($this->request('id')),
            $this->request('url')

        );
        return $this->output($result);
    }
}