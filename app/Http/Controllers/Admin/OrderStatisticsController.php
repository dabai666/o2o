<?php 
namespace YiZan\Http\Controllers\Admin;

use YiZan\Models\OrderConfig;
use YiZan\Utils\Time;
use View, Input, Lang, Route, Page, Form;
/**
 * 订单统计
 */
class OrderStatisticsController extends AuthController {
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
		$data = $this->requestApi('order.ordercount.lists',$args);
		$data = $data['data']['list'];
		if(count($data) > 0){
			foreach($data as  $k => $v){
				if(count($v['orderGoods']) > 0){
					$totalWeight = 0;
					foreach($v['orderGoods'] as $kk => $vv){
						if($vv['goodsNormsId'] > 0){
							$weight = $this->getWeight($vv['goodsNormsId'],$v['norms']);
							$totalWeight += $vv['num']* $weight;
						}else{
							$totalWeight += $vv['num']* $v['weight'];
						}
					}
				}
				unset($data[$k]['norms']);
				unset($data[$k]['orderGoods']);
				$data[$k]['totalWeight'] = $totalWeight;
			}
		}else{
			$data = array();
		}
		View::share('list',$data);
		View::share('totalCount',count($data));
		return $this->display();

	}
	public function getWeight($normsId,$norms){

		foreach($norms as $k => $v){
			if($normsId == $v['id']){
				return $v['weight'];
				break;
			}
		}
	}
	/*
	 * 备份
	 */
	public function index1(){
		$args = array();
		$begin_time = Input::get('beginTime');
		$end_time = Input::get('endTime');
		if ($begin_time != '' && $end_time != '') {
			$args = array(
				'beginTime' => $begin_time,
				'endTime' => $end_time
			);
		}
		$data = $this->requestApi('order.ordercount.ordernum',$args);
		if($data['code'] == 0){
			View::share('data', $data['data']);
		}else if($data['code'] == 19999){
			View::share('error', 1);
			View::share('data', $data);
		    //return $this->error("时间段必须为1-15天");
		}
		return $this->display();
	}
}
