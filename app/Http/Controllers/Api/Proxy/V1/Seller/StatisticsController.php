<?php 
namespace YiZan\Http\Controllers\Api\Proxy\Seller;

use YiZan\Services\Proxy\SellerService;
use YiZan\Http\Controllers\Api\Proxy\BaseController;
use Lang, Validator;

/**
 * 商家营业统计
 */
class StatisticsController extends BaseController{ 

    /**
     * 获取年份
     */
    public function year(){
        $data = SellerService::getyear();
        return $this->outputData($data);
    }

    /**
     * 商家营业统计列表
     */
    public function lists()
    {
        $data = SellerService::getBusinessStatisticsList(
            $this->proxy,
            $this->request('name'),
            intval($this->request('month')),
            intval($this->request('year')),
            intval($this->request('cityId')), 
            max((int)$this->request('page'), 1), 
            max((int)$this->request('pageSize'), 20)
        );
        
        return $this->outputData($data);
    }

    /**
     * 商家营业月统计列表
     */
    public function monthlists()
    {
        $data = SellerService::getBusinessListByMonth(
            $this->proxy,
            $this->request('sellerId'),
            intval($this->request('month')),
            intval($this->request('year')),
            intval($this->request('cityId')) 
        );
        
        return $this->outputData($data);
    }

    /**
     * 商家营业天统计列表
     */
    public function daylists()
    {
        $data = SellerService::getBusinessListByDay(
            $this->proxy,
            $this->request('sellerId'),
            $this->request('day'), 
            $this->request('sn'), 
            intval($this->request('status')), 
            max((int)$this->request('page'), 1), 
            max((int)$this->request('pageSize'), 20)
        );
        
        return $this->outputData($data);
    }

    /**
     * 平台数据
     */
    public function platform(){
        $nav = intval($this->request('nav'));
        if($nav == 1){ 
            $method = 'getBusinessPlatformSelling';
        } else { 
            $method = 'getBusinessPlatformInfo';
        }
        $data = SellerService::$method(
            $this->proxy,
            intval($this->request('month')),
            intval($this->request('year')),
            intval($this->request('cityId')) 
        );
        return $this->outputData($data);
    }

}

