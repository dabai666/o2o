<?php
namespace YiZan\Http\Controllers\Api\Buyer;

use Lang, Validator;
use YiZan\Models\Goods;
use YiZan\Models\ShopBrand;

/**
 * 首页底部导航
 */
class BrandController extends BaseController{
    public function detail(){
        $data = ShopBrand::where('id',$this->request('brandId'))->first();
        $data = $data ? $data->toArray() : array();
        return $this->outputData($data);
    }
    public function getBrandGoods(){
        $goods = Goods::where('brand_id',$this->request('brandId'))->where('auto_type',0)->where('status',1)->skip(0)->take(6)->get();
        $goods = $goods ? $goods->toArray() : array();
        return $this->outputData($goods);
    }
}