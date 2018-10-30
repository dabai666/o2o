<?php
namespace YiZan\Http\Controllers\Admin;

use YiZan\Models\OrderConfig;
use YiZan\Utils\Time;
use View, Input, Lang, Route, Page, Form;
/**
 * 销售统计
 */
class SaleStatisticsController extends AuthController {
    public function index(){
        $args = array();
        $begin_time = Input::get('beginTime');
        $end_time = Input::get('endTime');
        $page = Input::get('page') ? Input::get('page') : 1;
        $pageSize = Input::get('pageSize') ? Input::get('pageSize') : 20;
        if ($begin_time != '' && $end_time != '') {
            $args = array(
                'beginTime' => $begin_time,
                'endTime' => $end_time,
                'page' => $page,
                'pageSize'=>$pageSize
            );
        }
        $data = $this->requestApi('order.ordercount.sale_lists',$args);
        View::share('list',$data['data']['list'] ? $data['data']['list'] : array());
        View::share('totalCount',$data['data']['totalCount'] ? $data['data']['totalCount'] : 0);
        return $this->display();
    }
}
