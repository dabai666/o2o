<?php 
namespace YiZan\Http\Controllers\Api\System;

use YiZan\Services\System\AdvService;
use YiZan\Http\Controllers\Api\System\BaseController;
use Lang, Validator;

/**
 * 广告管理
 */
class AdvController extends BaseController 
{
    /**
     * 广告列表
     */
    public function lists()
    {
        $data = AdvService::getList
        (
            $this->request('code'),
            $this->request('page'),
            max((int)$this->request('pageSize'), 20)
        );
        
		return $this->outputData($data);
    }
    /**
     * 添加广告
     */
    public function create()
    {
        $result = AdvService::create
        (

            intval($this->request('cityId')),
            intval($this->request('positionId')),
            $this->request('name'),//广告名称

            $this->request('image'),
            $this->request('bgColor'),//背景颜色


            $this->request('type'),
            $this->request('arg'),
            intval($this->request('sort')),
            intval($this->request('status')),
            (int)$this->request('sellerCateId'),

            $this->request('image1'),
            $this->request('type1'),
            $this->request('arg1'),

            $this->request('image2'),
            $this->request('type2'),
            $this->request('arg2'),

            $this->request('image3'),
            $this->request('type3'),
            $this->request('arg3'),

            $this->request('image4'),
            $this->request('type4'),
            $this->request('arg4'),
            $this->request('flage'),

            $this->request('title2'),
            $this->request('instruction2'),
            $this->request('instruction2Bg'),

            $this->request('title3'),
            $this->request('instruction3'),
            $this->request('instruction3Bg'),

            $this->request('title4'),
            $this->request('instruction4'),
            $this->request('instruction4Bg'),
			
			$this->request('sign2'),
			$this->request('sign3'),
			$this->request('sign4'),
            $this->request('mark2'),
			$this->request('mark3'),
			$this->request('mark4'),
            $this->request('remarks2'),
            $this->request('remarks3'),
            $this->request('remarks4')
//            intval($this->request('cityId')),
//            intval($this->request('positionId')),
//            $this->request('name'),
//            $this->request('image'),
//            $this->request('bgColor'),
//            $this->request('type'),
//            $this->request('arg'),
//            intval($this->request('sort')),
//            intval($this->request('status')),
//            (int)$this->request('sellerCateId')
        );
        
        return $this->output($result);
    }
    /**
     * 添加4+4品牌广告
     */
    public function create1()
    {
        $result = AdvService::create1
        (
            $this->request('name'),//广告名称
            intval($this->request('cityId')),
            intval($this->request('positionId')),
            $this->request('flage'),
            intval($this->request('sort')),
            intval($this->request('status')),
            $this->request('advSerialize')
        );

        return $this->output($result);
    }
    /**
     * 获取广告
     */
    public function get()
    {
        $adv = AdvService::getById(intval($this->request('id')));
        return $this->outputData($adv == false ? [] : $adv->toArray());
    }    
    /**
     * 更新广告
     */
    public function update()
    {


        $result = AdvService::update
        (
            intval($this->request('id')),
            intval($this->request('cityId')),
            intval($this->request('positionId')),
            $this->request('name'),//广告名称

            $this->request('image'),
            $this->request('bgColor'),//背景颜色


            $this->request('type'),
            $this->request('arg'),
            intval($this->request('sort')),
            intval($this->request('status')),
            (int)$this->request('sellerCateId'),

            $this->request('image1'),
            $this->request('type1'),
            $this->request('arg1'),

            $this->request('image2'),
            $this->request('type2'),
            $this->request('arg2'),

            $this->request('image3'),
            $this->request('type3'),
            $this->request('arg3'),

            $this->request('image4'),
            $this->request('type4'),
            $this->request('arg4'),
            $this->request('flage'),

            $this->request('title2'),
            $this->request('instruction2'),
            $this->request('instruction2Bg'),

            $this->request('title3'),
            $this->request('instruction3'),
            $this->request('instruction3Bg'),
			
            $this->request('title4'),
            $this->request('instruction4'),
            $this->request('instruction4Bg'),
			
			$this->request('sign2'),
			$this->request('sign3'),
			$this->request('sign4'),
            $this->request('mark2'),
			$this->request('mark3'),
			$this->request('mark4'),
            $this->request('remarks2'),
            $this->request('remarks3'),
            $this->request('remarks4')
//            intval($this->request('id')),
//            intval($this->request('cityId')),
//            intval($this->request('positionId')),
//            $this->request('name'),
//            $this->request('image'),
//            $this->request('bgColor'),
//            $this->request('type'),
//            $this->request('arg'),
//            intval($this->request('sort')),
//            intval($this->request('status')),
//            (int)$this->request('sellerCateId')
        );
        
        return $this->output($result);
    }
    public function update1()
    {
        $result = AdvService::update1(
            intval($this->request('id')),
            $this->request('name'),//广告名称
            intval($this->request('cityId')),
            intval($this->request('positionId')),
            $this->request('flage'),
            intval($this->request('sort')),
            intval($this->request('status')),
            $this->request('advSerialize')
        );
        return $this->output($result);
    }
    /**
     * 设置状态
     */
    public function setstatus()
    {
        $result = AdvService::delete(intval($this->request('id')), intval($this->request('status')));
        
        return $this->output($result);
    }
    /**
     * 删除广告
     */
    public function delete()
    {
        $result = AdvService::delete($this->request('id'));
        return $this->output($result);
    }
    /**
     * 广告列表
     */
    public function OneselfAdvlists()
    {
        $data = AdvService::OneselfAdvlists
        (
            $this->request('code'),
            $this->request('page'),
            max((int)$this->request('pageSize'), 20)
        );

        return $this->outputData($data);
    }
}