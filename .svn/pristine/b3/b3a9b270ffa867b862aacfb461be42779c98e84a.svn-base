<?php
/**
 * Created by PhpStorm.
 * User: wjy
 * Date: 2017/5/2
 * Time: 14:48
 */
namespace YiZan\Services;
use YiZan\Models\Order;
use YiZan\Models\OrderGoods;
use YiZan\Utils\Time;
use Lang, DB;
class OrderGoodsService extends BaseService{
    /**
     * 获取分类数据
     * @return mixed
     */
    public function getClassifyList($month, $year, $activity_id = 0, $page = 1, $pageSize = 20){
        $db_prefix = env('DB_PREFIX');
        if($month < 10){
            $month = "0".$month;
        }
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
        $select = "{$db_prefix}activity.name as activityName,{$db_prefix}goods.name as goodsName,{$db_prefix}goods.sale_price as salePrice,{$db_prefix}goods.price as price,{$db_prefix}activity.start_time as startTime,{$db_prefix}activity.end_time as endTime,sum({$db_prefix}order_goods.num) as totalNum,sum({$db_prefix}order_goods.num * {$db_prefix}order_goods.price) as totalPrice,{$db_prefix}goods.total_stock as totalStock";
        $ordergoods = OrderGoods::select(DB::raw($select))
            ->leftJoin('goods','goods.id','=','order_goods.goods_id')
            ->leftJoin('activity_seller','activity_seller.goods_id','=','goods.id')
            ->leftJoin('activity','activity_seller.activity_id','=','activity.id')
            ->whereIn('order_goods.order_id',$orderIdArr)
            ->whereIn('goods.id',function($query){
                $query->select('goods_id')
                    ->from('activity_seller')
                    ->whereIn('activity_seller.activity_id',function($query1){
                        $query1->select('id')->from('activity')->where('type','=',7);
                    });
            })
        ;
        $total = OrderGoods::select(DB::raw($select))
            ->leftJoin('goods','goods.id','=','order_goods.goods_id')
            ->leftJoin('activity_seller','activity_seller.goods_id','=','goods.id')
            ->leftJoin('activity','activity_seller.activity_id','=','activity.id')
            ->whereIn('order_goods.order_id',$orderIdArr)
            ->whereIn('goods.id',function($query){
                $query->select('goods_id')
                    ->from('activity_seller')
                    ->whereIn('activity_seller.activity_id',function($query1){
                        $query1->select('id')->from('activity')->where('type','=',7);
                    });
            })
        ;
        if($activity_id > 0){
            $ordergoods = $ordergoods->where('activity.id','=',$activity_id);
            $total = $total->where('activity.id','=',$activity_id);
        }

        $totalCount = count($total->groupBy('goods.id')->select('goods.id'));
        $ordergoods = $ordergoods
            ->groupBy('goods.id')
            ->skip($page - 1)
            ->take($pageSize)
            ->get();

        $result = $ordergoods ? $ordergoods->toArray() : array();
        return ['list'=>$result,'totalCount'=>$totalCount];
//        return $result ? $result : array();
    }
}