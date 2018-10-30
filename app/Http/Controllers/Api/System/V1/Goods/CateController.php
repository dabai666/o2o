<?php 
namespace YiZan\Http\Controllers\Api\System\Goods;

use YiZan\Models\Goods;
use YiZan\Models\GoodsCate;
use YiZan\Models\Order;
use YiZan\Models\OrderGoods;
use YiZan\Services\GoodsCateService;
use YiZan\Http\Controllers\Api\System\BaseController;
use Lang, Validator, DB, Time;
use YiZan\Services\SellerService;
use YiZan\Services\StatisticsService;

/**
 * 服务分类
 */
class CateController extends BaseController 
{
    /**
     * 分类列表
     */
    public function lists()
    {
        $data = GoodsCateService::getList($this->request('sellerId'), $this->request('type'));
        
		return $this->outputData($data);
    }
    /**
     * 添加分类
     */
    public function create()
    {
        $result = GoodsCateService::create
        (
            intval($this->request('tradeId')),
            intval($this->request('pid')),
            $this->request('type'),
            $this->request('name'),
            $this->request('img'),
            intval($this->request('sort')),
            intval($this->request('status')),
            intval($this->request('sellerId'))
        );
        
        return $this->output($result);
    }
    /**
     * 更新分类
     */
    public function update()
    {
        $result = GoodsCateService::update
        (
            intval($this->request('id')),
            intval($this->request('tradeId')),
            intval($this->request('pid')),
            $this->request('type'),
            $this->request('name'),
            $this->request('img'),
            intval($this->request('sort')),
            intval($this->request('status')),
            intval($this->request('sellerId'))
        );

        return $this->output($result);
    }
	    /**
     * 添加分类
     */
    public function OneselfTagCreate()
    {
        $result = GoodsCateService::OneselfCreate
        (
            intval($this->request('id')),
            intval($this->request('tradeId')),
            intval($this->request('pid')),
            $this->request('type'),
            $this->request('name'),
            $this->request('img'),
            intval($this->request('sort')),
            intval($this->request('status')),
            ONESELF_SELLER_ID
        );
        return $this->output($result);
    }
	
    /**
     * 删除分类
     */
    public function delete()
    {
        $result = GoodsCateService::delete(
            $this->request('id'), 
            intval($this->request('sellerId'))
        );
        
        return $this->output($result);
    }

    public function get()
    {
        $result = GoodsCateService::getSellerCate(intval($this->request('sellerId')),intval($this->request('id')));
        
        return $this->output($result);
    }
	public function getOneself()
    {
        $result = GoodsCateService::getSellerCate(ONESELF_SELLER_ID,intval($this->request('id')));

        return $this->output($result);
    }

    /**
     * 删除分类
     */
    public function oneselfDelete()
    {
        $result = GoodsCateService::delete(
            $this->request('id'), 
            ONESELF_SELLER_ID
        );

        return $this->output($result);
    }

    /**
     * 是否推荐
     */
    public function isWapStatus()
    {
        $result = GoodsCateService::isWapStatus(intval($this->request('id')),intval($this->request('isWapStatus')));

        return $this->output($result);
    }

    public function updatestatus()
    {
        $result = GoodsCateService::updateStatus(
            intval($this->request('id')),
            intval($this->request('status'))
        );
        return $this->output($result);
    }

    /**
     * 获取商城数据
     */
    public function getCateList(){
        DB::connection()->enableQueryLog();
        /*$status = [ORDER_STATUS_FINISH_SYSTEM, ORDER_STATUS_FINISH_USER, ORDER_STATUS_USER_DELETE, ORDER_STATUS_SELLER_DELETE, ORDER_STATUS_ADMIN_DELETE];
        $page = $this->request('page') ? $this->request('page') : 1;
        $pageSize = $this->request('pageSize') ? $this->request('pageSize') : 20;
        $db_prefix = env('DB_PREFIX');
        $select = "sum({$db_prefix}order_goods.num) as totalNum,{$db_prefix}order_goods.goods_norms_id,sum({$db_prefix}order_goods.num * {$db_prefix}goods_norms.weight) as totalWeight,sum({$db_prefix}order_goods.num * {$db_prefix}goods_norms.sale_price) as totalPrice,{$db_prefix}goods_cate.*, {$db_prefix}goods.name";
//        $select = " {$db_prefix}order_goods.num,{$db_prefix}order_goods.goods_norms_id,{$db_prefix}goods.name,{$db_prefix}.goods_cate.* ";
        $select = "{$db_prefix}goods_cate.*,{$db_prefix}order_goods.goods_norms_id,{$db_prefix}order_goods.goods_id,{$db_prefix}order_goods.id as orderGoodsId";
        $list = GoodsCate::select(DB::raw($select))//DB::raw('order_goods.num,sum(order_goods.num) as totalNum')
        ->leftJoin('goods','goods.cate_id','=','goods_cate.id')
        ->leftJoin('order_goods','order_goods.goods_id','=','goods.id')
        ->leftJoin('goods_norms','order_goods.goods_norms_id','=','goods_norms.id')
//            ->leftJoin('seller','seller.id','=','goods_cate.seller_id')
        ->groupBy('goods.id')//goods_cate.id
//        ->with('goods')
        ->where('goods_cate.seller_id','=',ONESELF_SELLER_ID)
        ->whereIn('order_goods.order_id',function($query){
                $query->select('id')
                    ->from('order')
                    ->whereIn('status',
                        [ORDER_STATUS_FINISH_SYSTEM, ORDER_STATUS_FINISH_USER, ORDER_STATUS_USER_DELETE, ORDER_STATUS_SELLER_DELETE, ORDER_STATUS_ADMIN_DELETE]
                    );
            })
//        ->orderBy(DB::raw('sum('.env('DB_PREFIX').'order_goods.num)'),'DESC')
        ->skip($page - 1)
        ->take($pageSize)
        ->get();
        $list = $list ? $list->toArray() : array();*/
        $page = $this->request('page') ? $this->request('page') : 1;
        $pageSize = $this->request('pageSize') ? $this->request('pageSize') : 20;
        $db_prefix = env('DB_PREFIX');
        $select = "{$db_prefix}order_goods.goods_name,{$db_prefix}goods_cate.name,sum({$db_prefix}order_goods.num) as totalNum,sum({$db_prefix}order_goods.num * {$db_prefix}goods_norms.weight) as totalWeight,sum({$db_prefix}order_goods.num * {$db_prefix}order_goods.price) as totalPrice";
        $ordergoods = OrderGoods::select(DB::raw($select))
            ->leftJoin('goods','goods.id','=','order_goods.goods_id')
            ->leftJoin('goods_cate','goods_cate.id','=','goods.cate_id')
            ->leftJoin('goods_norms','goods_norms.id','=','order_goods.goods_norms_id')
            ->where('order_goods.seller_id',ONESELF_SELLER_ID)
           ->whereIn('order_goods.order_id',function($query){
               $month = $this->request('month');
               $year  = $this->request('year');
               if($month < 10){
                   $months = "0".$month."01";
                   $yearMonth = "0".$month;
               }
               $years = $year;
               $year = $year.$months;
               $start = Time::toTime($year);
               $end =  Time::toTime($years.$yearMonth.date('t', strtotime($year)));
               $query->select('id')
                   ->from('order')
                   ->whereIn('status',
                       [ORDER_STATUS_FINISH_SYSTEM, ORDER_STATUS_FINISH_USER, ORDER_STATUS_USER_DELETE, ORDER_STATUS_SELLER_DELETE, ORDER_STATUS_ADMIN_DELETE]
                   )
                   ->where('create_time','>=',$start)
                   ->where('create_time','<',$end)
               ;
           })
            ->whereIn('goods.cate_id',function($query1){
                $query1->select('id')
                    ->from('goods_cate')
                    ->where('seller_id',ONESELF_SELLER_ID);
            });
        if($this->request('cateId')){
            $ordergoods = $ordergoods->where('goods_cate.id','=',$this->request('cateId'));
        }
        $ordergoods = $ordergoods
            ->groupBy('order_goods.goods_id')
            ->skip($page - 1)
            ->take($pageSize)
            ->get();
        $result = $ordergoods ? $ordergoods->toArray() : array();
//        var_dump($result);die;
        return $this->output($result);
    }

    /**
     * 获取分类数据
     * @return mixed
     */
    public function getClassifyList(){
        $page = $this->request('page') ? $this->request('page') : 1;
        $pageSize = $this->request('pageSize') ? $this->request('pageSize') : 20;
        $db_prefix = env('DB_PREFIX');

        $month = $this->request('month') ? ltrim($this->request('month'),0) : Time::toDate(UTC_TIME,'m');
        if($month < 10){
            $month = "0".$month;
        }
        $year = $this->request('year') ? $this->request('year') : Time::toDate(UTC_TIME,'Y');
        $firstday = Time::toDate(Time::toTime($year.'-'.$month),'Y-m-01');
        $lastday = Time::toTime(Time::toDate(Time::toTime("$firstday +1 month -1 day"),'Y-m-d')) + 24*3600;
        $firstday = Time::toTime($firstday);
        $order = Order::select(DB::raw($db_prefix.'order.id'))
            ->whereIn('status',[ORDER_STATUS_FINISH_SYSTEM, ORDER_STATUS_FINISH_USER, ORDER_STATUS_USER_DELETE, ORDER_STATUS_SELLER_DELETE, ORDER_STATUS_ADMIN_DELETE])
            ->where('create_time','>=',$firstday)
            ->where('create_time','<',$lastday)
            ->get();
        $order = $order ? $order->toArray() : array();
        $orderIdArr = array();
        foreach($order as $k => $v){
            $orderIdArr[] = $v['id'];
        }

        $select = "{$db_prefix}system_tag_list.id,{$db_prefix}system_tag_list.name,sum({$db_prefix}order_goods.num) as totalNum,sum({$db_prefix}order_goods.num * {$db_prefix}goods_norms.weight) as totalWeight,sum({$db_prefix}order_goods.num * {$db_prefix}order_goods.price) as totalPrice";
        $ordergoods = OrderGoods::select(DB::raw($select))
            ->leftJoin('goods','goods.id','=','order_goods.goods_id')
            ->leftJoin('system_tag_list','goods.system_tag_list_id','=','system_tag_list.id')
            ->leftJoin('goods_cate','goods_cate.id','=','goods.cate_id')
            ->leftJoin('goods_norms','goods_norms.id','=','order_goods.goods_norms_id')
//            ->where('order_goods.seller_id',ONESELF_SELLER_ID)
            ->whereIn('order_goods.order_id',$orderIdArr)
            ->whereIn('goods.cate_id',function($query1){
                $query1->select('id')
                    ->from('goods_cate');
//                    ->where('seller_id',ONESELF_SELLER_ID);
            })
            ->where('goods.auto_type','=',0)
        ;
        if($this->request('firstId') > 0){
            $ordergoods = $ordergoods->where('goods.system_tag_list_pid','=',$this->request('firstId'));
        }
        if($this->request('secondId') > 0){
            $ordergoods = $ordergoods->where('goods.system_tag_list_id','=',$this->request('secondId'));
        }
        $ordergoods = $ordergoods
//            ->where('totalNum','>',0)
            ->groupBy('system_tag_list.id')
            ->skip($page - 1)
            ->take($pageSize)
            ->get();
        $result = $ordergoods ? $ordergoods->toArray() : array();
        return $this->output($result);
    }
    public function getClassifyListDetail(){
        $result = StatisticsService::getClassifyListDetail(
            $this->request('page'),
            $this->request('pageSize'),
            $this->request('systemTagListId'),
            $this->request('month'),
            $this->request('year')
        );
        return $this->outputData($result);
    }
}