<?php
namespace YiZan\Services\System;

use YiZan\Models\Goods;
use YiZan\Models\GoodsCate;
use YiZan\Models\System\Order;
use YiZan\Models\OrderGoods;
use YiZan\Utils\Time;
use DB, Lang;

class OrderCountService extends \YiZan\Services\OrderService
{
    public function sale_lists($startTime='',$endTime='',$page = 1,$pageSize = 20){
//        $filed = 'goods.id,goods.create_time,goods.name,goods.goods_sn,goods.price,goods.original_price,goods.sale_price,goods.weight,order_goods.goods_norms_id,order_goods.goods_id,order_goods.order_id,order_goods.num';
//        $filed = 'goo;
//        $filed = explode(',',$filed);
        $list = GoodsCate::select(DB::raw('sum('.env('DB_PREFIX').'order_goods.num) as totalNum,'.env('DB_PREFIX').'goods_cate.*,'.env('DB_PREFIX').'seller.name as sellerName'))//DB::raw('order_goods.num,sum(order_goods.num) as totalNum')
            ->leftJoin('goods','goods.cate_id','=','goods_cate.id')
            ->leftJoin('order_goods','order_goods.goods_id','=','goods.id')
            ->leftJoin('seller','seller.id','=','goods_cate.seller_id')
            ->groupBy('goods_cate.id')
//            ->with('goods')
            ->whereIn('order_goods.order_id',function($query){
                $query->select('id')
                    ->from('order')
                    ->whereIn('status',[
                        ORDER_STATUS_FINISH_SYSTEM,
                        ORDER_STATUS_FINISH_USER,
                        ORDER_STATUS_REFUND_FAIL,
                        ORDER_STATUS_REFUND_SUCCESS,
                        ORDER_STATUS_CANCEL_ADMIN,
                        ORDER_STATUS_USER_DELETE,
                        ORDER_STATUS_CANCEL_SELLER,
                        ORDER_STATUS_CANCEL_AUTO,
                        ORDER_STATUS_CANCEL_USER
                    ]);
            })
            ->orderBy(DB::raw('sum('.env('DB_PREFIX').'order_goods.num)'),'DESC')
            ->skip($page - 1)
            ->take($pageSize)
            ->get();
        $list = $list ? $list->toArray() : array();

        $totalCount = GoodsCate::select(DB::raw('sum('.env('DB_PREFIX').'order_goods.num) as totalNum'))//DB::raw('order_goods.num,sum(order_goods.num) as totalNum')
            ->leftJoin('goods','goods.cate_id','=','goods_cate.id')
            ->leftJoin('order_goods','order_goods.goods_id','=','goods.id')
            ->groupBy('goods_cate.id')
//            ->with('goods')
            ->whereIn('order_goods.order_id',function($query){
                $query->select('id')
                    ->from('order')
                    ->whereIn('status',[
                        ORDER_STATUS_FINISH_SYSTEM,
                        ORDER_STATUS_FINISH_USER,
                        ORDER_STATUS_REFUND_FAIL,
                        ORDER_STATUS_REFUND_SUCCESS,
                        ORDER_STATUS_CANCEL_ADMIN,
                        ORDER_STATUS_USER_DELETE,
                        ORDER_STATUS_CANCEL_SELLER,
                        ORDER_STATUS_CANCEL_AUTO,
                        ORDER_STATUS_CANCEL_USER
                    ]);
            })
//            ->orderBy(DB::raw('sum('.env('DB_PREFIX').'order_goods.num)'),'DESC')
            ->count();
        return array('list'=>$list,'totalCount'=>$totalCount);
    }

    /**
     * @param string $startTime
     * @param string $endTime
     * @param int $page
     * @param int $pageSize
     * @return array
     * 订单统计
     */
    public function lists($startTime='',$endTime='',$page = 1,$pageSize = 20){
        $filed = 'goods.id,goods.create_time,goods.name,goods.goods_sn,goods.price,goods.original_price,goods.sale_price,goods.weight,order_goods.goods_norms_id,order_goods.goods_id,order_goods.order_id,order_goods.num';
        $filed = explode(',',$filed);
        $list = Goods::select($filed);
        if($startTime){
            $list = $list->where('create_time','>=',Time::toTime($startTime));
        }
        if($endTime){
            $list = $list->where('create_time','<',Time::toTime($endTime));
        }
        $list = $list->where('status','=',1)
            ->leftJoin('order_goods','order_goods.goods_id','=','goods.id')
            ->with('norms','orderGoods')
            ->whereIn('order_goods.order_id',function($query){
                $query->select('id')
                    ->from('order')
                    ->whereIn('status',[
                        ORDER_STATUS_FINISH_SYSTEM,
                        ORDER_STATUS_FINISH_USER,
                        ORDER_STATUS_REFUND_FAIL,
                        ORDER_STATUS_REFUND_SUCCESS,
                        ORDER_STATUS_CANCEL_ADMIN,
                        ORDER_STATUS_USER_DELETE,
                        ORDER_STATUS_CANCEL_SELLER,
                        ORDER_STATUS_CANCEL_AUTO,
                        ORDER_STATUS_CANCEL_USER
                    ]);
            })
            ->skip($page - 1)
            ->take($pageSize)
            ->get();
        $totalCount = Goods::select('goods.id');
            if($startTime){
                $totalCount = $totalCount->where('create_time','>=',Time::toTime($startTime));
            }
        if($endTime){
            $totalCount = $totalCount->where('create_time','<',Time::toTime($endTime));
        }
        $totalCount = $totalCount->where('status','=',1)
            ->leftJoin('order_goods','order_goods.goods_id','=','goods.id')
            ->whereIn('order_goods.order_id',function($query){
                $query->select('id')
                    ->from('order')
                    ->whereIn('status',[
                        ORDER_STATUS_FINISH_SYSTEM,
                        ORDER_STATUS_FINISH_USER,
                        ORDER_STATUS_REFUND_FAIL,
                        ORDER_STATUS_REFUND_SUCCESS,
                        ORDER_STATUS_CANCEL_ADMIN,
                        ORDER_STATUS_USER_DELETE,
                        ORDER_STATUS_CANCEL_SELLER,
                        ORDER_STATUS_CANCEL_AUTO,
                        ORDER_STATUS_CANCEL_USER
                    ]);
            })
            ->count();
        $list = $list ? $list->toArray() : array();
        return ["list"=>$list, "totalCount"=>$totalCount];
    }
    /**
     * [total 订单统计概况]
     * @param  [int] $type [类型 1:今天 2:昨天 3:本周 4:本月]
     * @return [type]       [description]
     */
    public static function total($type) {
        //开始时间与结束时间
        switch ($type) {
            case '2'://昨天
                $end_time = UTC_DAY;
                $begin_time = $end_time - 24 * 3600;
                break;

            case '3'://本周
                $begin_time = Time::getWeekFirstDay();
                $end_time = Time::getWeekLastDay()+1;
                break;

            case '4'://本月
                $begin_time = Time::getMonthFirstDay();
                $end_time = Time::getMonthLastDay()+1;
                break;

            default://默认今天
                $begin_time = UTC_DAY;
                $end_time = $begin_time + 24 * 3600;
                break;
        }

        $list = array();
        if ($type >= 0 && $type < 3) {//查询的时间为今天或者昨天的数据
            $result = DB::table('order')->where('create_time', '>=', $begin_time)
                ->where('create_time', '<', $end_time)
                ->select(DB::raw('count(id) as total,sum(pay_fee) as money,FROM_UNIXTIME(app_time + 8*3600,"%H") as appoint_hour'))
                ->groupBy('appoint_hour')
                ->get();

            $total_num = 0;
            $money_num = 0;
            for ($i = 0; $i <= 23; $i++) {
                $time[$i] = $i < 10 ? '0'.$i.':00' : $i.':00';
                $total[$i] = 0;
                $money[$i] = 0;
            }

            foreach ($result as $k=>$v) {
                $appHour = (int)$v->appoint_hour;
                $total[$appHour] = $v->total;
                $money[$appHour] = $v->money;
                $total_num += $v->total;
                $money_num += $v->money;
            }

        } else {//本周或本月的统计数据

            $result = DB::table('order')->where('create_time', '>=', $begin_time)
                ->where('create_time', '<', $end_time)
                ->groupBy('create_day')
                ->select(DB::raw('count(id) as total,sum(pay_fee) as money'),'create_day')
                ->get();

            $total_num = 0;
            $money_num = 0;

            $max_num = $type == 4 ? Time::toDate($begin_time,'t') : 7;
            for ($i = 0; $i < $max_num; $i++) {
                $day = $begin_time + $i * 24 * 3600;
                $time[$i] = Time::toDate($day, 'Y-m-d');
                $day_time = Time::toDate($day, 'd');
                $total[$day_time] = 0;
                $money[$day_time] = 0;
            }

            foreach ($result as $k=>$v) {
                $day = Time::toDate($v->create_day, 'd');
                $total[$day] = $v->total;
                $money[$day] = $v->money;
                $total_num += $v->total;
                $money_num += $v->money;
            }

        }
        $list = array(
            'time' => $time,
            'data' => array(
                array('name'=>'订单金额','total'=>$money_num,'val'=>$money),
                array('name'=>'订单数','total'=>$total_num,'val'=>$total),
            ),
        );
        return $list;
    }
    /**
     * [getOrderNumTotal 订单数量统计]
     * @param  [type] $beginTime [开始时间]
     * @param  [type] $endTime   [结束时间]
     * @return [type]            [description]
     */
    public static function getOrderNumTotal($beginTime, $endTime) {
        $data = array(
            'code' => 0,
            'data' => array(),
            'msg' => ''
        );
        $begin_time = !empty($beginTime) ? Time::toTime($beginTime) : UTC_DAY - 14 * 24 * 3600;
        $end_time = !empty($endTime) ? Time::toTime($endTime) + 24 * 3600 : UTC_DAY + 24 * 3600;
        $diff_day =($end_time - $begin_time) / 86400;
        if ($diff_day > 15 || $diff_day < 1) {
            $data['code'] = 19999;
            $data['msg'] = '时间段必须为1-15天';
            return $data;
        }
        $not_total_num = 0; //未成交订单初始数值
        $total_num = 0; //已成交订单初始数值

        for ($i = 0; $i < $diff_day; $i++) {
            $day = $begin_time + $i * 24 * 3600;
            $time[$i] = Time::toDate($day, 'Y-m-d');
            $day_time = Time::toDate($day, 'd');
            $total[$day_time] = 0;
            $not_total[$day_time] = 0;
        }
        //已完成订单数
        $result = DB::table('order')->where('create_time', '>=', $begin_time)
            ->where('create_time', '<', $end_time)
            ->whereIn('status', [
                ORDER_STATUS_FINISH_SYSTEM,
                ORDER_STATUS_FINISH_USER,
                ORDER_STATUS_REFUND_FAIL,
                ORDER_STATUS_REFUND_SUCCESS,
                ORDER_STATUS_CANCEL_ADMIN,
                ORDER_STATUS_USER_DELETE,
                ORDER_STATUS_CANCEL_SELLER,
                ORDER_STATUS_CANCEL_AUTO,
                ORDER_STATUS_CANCEL_USER
            ])->groupBy('create_day')
            ->select(DB::raw('count(id) as total'),'create_day')
            ->get();
        foreach ($result as $v) {
            $day = Time::toDate($v->create_day, 'd');
            $total[$day] = $v->total;
            $total_num += $v->total;
        }

        //未完成订单数
        $result = DB::table('order')->where('create_time', '>=', $begin_time)
            ->where('create_time', '<', $end_time)
            ->whereIn('status',  [
                ORDER_STATUS_BEGIN_USER,
                ORDER_STATUS_PAY_SUCCESS,
                ORDER_STATUS_PAY_DELIVERY,
                ORDER_STATUS_AFFIRM_SELLER,
                ORDER_STATUS_FINISH_STAFF,
                ORDER_STATUS_REFUND_AUDITING,
                ORDER_STATUS_CANCEL_REFUNDING,
                ORDER_STATUS_REFUND_HANDLE
            ])->groupBy('create_day')
            ->select(DB::raw('count(id) as total'),'create_day')
            ->get();
        foreach ($result as $v) {
            $day = Time::toDate($v->create_day, 'd');
            $not_total[$day] = $v->total;
            $not_total_num += $v->total;
        }
        //今日订单数
        $today_num = DB::table('order')->where('create_time', '>=', UTC_DAY)
            ->where('create_time', '<', UTC_DAY + 24 * 3600)
            ->count();
        //历史订单数
        $total_num_all = DB::table('order')->count();

        $data['data'] = array(
            'todayNum' => $today_num,
            'totalNum' => $total_num_all,
            'time' => $time,
            'data' => array(
                array('name'=>'未完成订单数','total'=>$not_total_num,'val'=>$not_total),
                array('name'=>'完成订单数','total'=>$total_num,'val'=>$total),
            ),
        );
        return $data;

    }


    /**
     * 营业额
     * @param  $sellerId
     * @param  $beginDate 开始时间
     * @param  $endDate 结束时间
     * @param  $type
     */
    public function goodsreport($sellerId,$year,$month,$numOrder,$priceOrder,$page,$pageSize,$cateId=0){
        if($month < 10){
            $months = "0".$month."01";
            $yearMonth = "0".$month;
        }
        $years = $year;
        $year = $year.$months;
        $start = Time::toTime($year);
        $end =  Time::toTime($years.$yearMonth.date('t', strtotime($year)));
        $query_data = Order::where('seller_id',$sellerId)->whereRaw("is_integral_goods = 0 AND pay_status = 1 AND `create_time` BETWEEN ".$start. " AND ".$end."
							AND (status IN (".ORDER_STATUS_FINISH_SYSTEM.", ".ORDER_STATUS_FINISH_USER.")
                            OR (status = ".ORDER_STATUS_USER_DELETE." AND buyer_finish_time > 0 AND cancel_time IS NULL)
                            OR (status = ".ORDER_STATUS_SELLER_DELETE." AND auto_finish_time > 0 AND cancel_time IS NULL)
                            OR (status = ".ORDER_STATUS_ADMIN_DELETE." AND auto_finish_time > 0 AND cancel_time IS NULL))")
            ->lists('id');
        if(!empty($query_data)){
            $tablePrefix = DB::getTablePrefix();
            $query_data2 = implode(',',$query_data);
            $totalCount = DB::select("select count(mycount) as icount from (select count(*) as mycount from `{$tablePrefix}order_goods` where `order_id` in (".$query_data2.") group by `goods_id`) as pp");
            $totalCount = $totalCount[0]->icount;
            // OrderGoods::whereIn('order_goods.order_id',$query_data)->groupBy('order_goods.goods_id')->count();
            $data = OrderGoods::whereIn('order_goods.order_id',$query_data)
                ->join('goods','goods.id','=','order_goods.goods_id');
            if($cateId > 0){
                $data->where('goods.cate_id','=',$cateId);
            }
            $data ->selectRaw(
                "{$tablePrefix}order_goods.goods_id,
				{$tablePrefix}order_goods.goods_name,
				{$tablePrefix}order_goods.goods_norms,
				{$tablePrefix}order_goods.price as price,
				SUM({$tablePrefix}order_goods.num) AS num,
				SUM(num * {$tablePrefix}order_goods.price) as totleprice"
            )
                ->with('categoods.cate')
                ->skip(($page - 1) * $pageSize)
                ->take($pageSize)
                ->groupBy('order_goods.goods_id');


            if($numOrder == 1){
                $data = $data->orderBy('num','desc');
            }else if($numOrder == 2){
                $data = $data->orderBy('num','asc');
            }
            if($priceOrder == 1){
                $data = $data->orderBy('totleprice','desc');
            }else if($priceOrder == 2){
                $data = $data->orderBy('totleprice','asc');
            }
            $list = $data->get()->toArray();
        }else{
            $list = '';
            $totalCount = '';
        }

        return ["list"=>$list, "totalCount"=>$totalCount];
    }

    /**
     * 营业额
     * @param  $sellerId
     * @param  $beginDate 开始时间
     * @param  $endDate 结束时间
     * @param  $type
     */
    public function revenue($sellerId,$year,$month,$page,$pageSize){
        $result = array(
            'code'	=> self::SUCCESS,
            'data'	=> null,
            'msg'	=> ''
        );
        if($month < 10){
            $months = "0".$month."01";
            $yearMonth = "0".$month;
        }
        $years = $year;
        $year = $year.$months;
        $start = Time::toTime($year);
        $end =  Time::toTime($years.$yearMonth.date('t', strtotime($year)));

        $query_data = Order::where('seller_id',$sellerId);
        $query_data->whereRaw(
            "is_integral_goods = 0 AND pay_status = 1
			AND `create_time` BETWEEN ".$start." AND ".$end ."
			AND (status IN (".ORDER_STATUS_FINISH_SYSTEM.", ".ORDER_STATUS_FINISH_USER.")
            OR (status = ".ORDER_STATUS_USER_DELETE." AND buyer_finish_time > 0 AND cancel_time IS NULL) 
            OR (status = ".ORDER_STATUS_SELLER_DELETE." AND auto_finish_time > 0 AND cancel_time IS NULL) 
            OR (status = ".ORDER_STATUS_ADMIN_DELETE." AND auto_finish_time > 0 AND cancel_time IS NULL))
		");
        $totalCount = $query_data->count();
        $query_data->groupBy('date')->selectRaw("count(id) as num,id,status ,sum(discount_fee) as discountFee ,buyer_finish_time,cancel_time,sum(pay_fee) as total,sum(integral) as integral,FROM_UNIXTIME(create_time+8*3600,'%Y-%m-%d') as date");
        $query_data = $query_data->skip(($page - 1) * $pageSize)
            ->take($pageSize)
            ->get()
            ->toArray();
        $totalMoney = 0;
        $totalNum = 0;
        $totalCancelNum = 0;
        $totalPromotion = 0;
        $totalIntegral = 0;
        $total = [];
        foreach($query_data as $key=>$val){
            $totalMoney += $val['total'];
            $query_data[$key]['orderPromotion'] = 0;
            $query_data[$key]['cancelNum']  = 0;
            $totalNum += $val['num'];
            $totalPromotion +=   $val['discountFee'];
            $totalCancelNum += $query_data[$key]['cancelNum'];
            $totalIntegral +=$val['integral'];
        }
        $total['totalNum'] += $totalNum;
        $total['totalCancelNum'] = $totalCancelNum;
        $total['totalPromotion'] = $totalPromotion;
        $total['totalIntegral'] = $totalIntegral;
        $total['totalMoney'] = $totalMoney;

        return ["list"=>$query_data, "totalCount"=>$totalCount,'total' => $total];
    }
}
