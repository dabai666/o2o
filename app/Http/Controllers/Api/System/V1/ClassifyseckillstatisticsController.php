<?php
/**
 * Created by PhpStorm.
 * User: wjy
 * Date: 2017/5/2
 * Time: 14:42
 */
namespace YiZan\Http\Controllers\Api\System;
use YiZan\Models\Activity;
use YiZan\Services\OrderGoodsService;

class ClassifyseckillstatisticsController extends BaseController{
    /**
     * 城市列表
     */
    public function getList()
    {
        $data = OrderGoodsService::getClassifyList(
            $this->request('month') ? ltrim($this->request('month'),0) : Time::toDate(UTC_TIME,'m'),
            $this->request('year') ? $this->request('year') : Time::toDate(UTC_TIME,'Y'),
            $this->request('activity_id') ? $this->request('activity_id') : 0,
            $this->request('page') ? $this->request('page') : 1,
            $this->request('pageSize') ? $this->request('pageSize') : 20
        );
        return $this->outputData($data);
    }
    public function getActivity(){
        $data = Activity::orderBy('id','desc')->get();
        return $this->outputData($data);
    }
}