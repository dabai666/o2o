<?php namespace YiZan\Http\Controllers\Wap;

use View, Input, Lang, Route, Page ,Session,Log,Redirect, Cache,Response;
/**
 * 首页
 */
class BrandController extends BaseController {
    public function detail(){
        $args = Input::all();
//        $args['brandId'] = 2;
        View::share('args',$args);
        $data = $this->requestApi('Brand.detail',$args);
        $data['data']['honorImg'] = explode(',',$data['data']['honorImg']);
        View::share('brand',$data['data']);
        $data = $this->requestApi('Brand.getBrandGoods',$args);
        View::share('goods',$data['data']);
        return $this->display();
    }
}