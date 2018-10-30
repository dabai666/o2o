<?php 
namespace YiZan\Http\Controllers\Seller;

use YiZan\Models\Seller;
use View, Input, Lang, Route, Page, Validator, Session, Response;
/**
 * 服务
 */
class GoodsReportController extends AuthController {
        public function index1(){
                $post = Input::all();
                !empty($post['beginDate']) ? $args['beginDate'] = strval($post['beginDate']) : null;
                !empty($post['endDate']) ? $args['endDate'] = strval($post['endDate']) : null;
                if(@$args['beginDate'] && @$args['endDate']){
                        $type = null;
                }else{
                        $type = 0;
                }
                $args['type'] = isset($post['type']) ? intval($post['type']) : $type;
                $args['numOrder'] = isset($post['numOrder']) ? intval($post['numOrder']) : 0;
                $args['priceOrder'] = isset($post['priceOrder']) ? intval($post['priceOrder']) : 0;
                $args['page'] = isset($post['page']) ? intval($post['page']) : 1;
                $result = $this->requestApi('statistics.goodsreport',$args);
                $data = $result['data']['list'];
                if($result['code']==0){
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
                View::share('args',$args);
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
	/**
	 * 服务管理-服务列表
	 */
        //备份
	public function index() {
        $post = Input::all();
        !empty($post['beginDate']) ? $args['beginDate'] = strval($post['beginDate']) : null;
        !empty($post['endDate']) ? $args['endDate'] = strval($post['endDate']) : null;
        if(@$args['beginDate'] && @$args['endDate']){
            $type = null;
        }else{
            $type = 0;
        }
        $args['type'] = isset($post['type']) ? intval($post['type']) : $type;
        $args['numOrder'] = isset($post['numOrder']) ? intval($post['numOrder']) : 0;
        $args['priceOrder'] = isset($post['priceOrder']) ? intval($post['priceOrder']) : 0;
        $args['page'] = isset($post['page']) ? intval($post['page']) : 1;
        $result = $this->requestApi('statistics.goodsreport',$args);
        if($result['code']==0){
            View::share('data',$result['data']);
        }
//         dd($result);
        View::share('args',$args);
        return $this->display();
	}

}
