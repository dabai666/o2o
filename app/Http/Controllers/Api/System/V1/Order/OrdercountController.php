<?php 
namespace YiZan\Http\Controllers\Api\System\Order;

use YiZan\Services\System\OrderCountService;
use YiZan\Http\Controllers\Api\System\BaseController;

/**
 * 订单统计
 */
class OrdercountController extends BaseController 
{
    /**
     * 概况
     */
    public function total()
    {   

        $data = OrderCountService::total((int)$this->request('type'));
		return $this->outputData($data);
    }

    /**
     * [orderNum 订单数量统计]
     */
    public function ordernum() {
        $data = OrderCountService::getOrderNumTotal
        (
            $this->request('beginTime'),
            $this->request('endTime')
        ); 
        return $this->output($data);
    }
    /**
     * [orderNum 平台自营统计]
     */
    public function oneselfordernum() {
        $data = OrderCountService::goodsreport(
            ONESELF_SELLER_ID,
            $this->request('year'),
            $this->request('month'),
            (int)$this->request('numOrder'),
            (int)$this->request('priceOrder'),
            max((int)$this->request('page'), 1),
            max((int)$this->request('pageSize'), 20),
            $this->request('cateId')
        );
        return $this->outputData($data);
    }

    /**
     * [orderNum 平台自营统计]
     */
    public function revenue() {
        $data = OrderCountService::revenue(
            ONESELF_SELLER_ID,
            $this->request('year'),
            $this->request('month'),
            max((int)$this->request('page'), 1),
            max((int)$this->request('pageSize'), 20)
        );
        return $this->outputData($data);
    }
    /**
     * 订单统计[lists 订单商品斤数统计]销售*数量
     */
    public function lists() {
        $data = OrderCountService::lists
        (
            $this->request('beginTime'),
            $this->request('endTime'),
            max($this->request('page'),1),
            max($this->request('pageSize'),20)
        );
        return $this->outputData($data);
    }

    /**
     * 销售统计
     */
    public function sale_lists(){
        $data = OrderCountService::sale_lists
        (
            $this->request('beginTime'),
            $this->request('endTime'),
            max($this->request('page'),1),
            max($this->request('pageSize'),20)
        );
        return $this->outputData($data);
    }

}