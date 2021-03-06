<?php namespace YiZan\Services\Buyer;

use YiZan\Models\Activity;
use YiZan\Models\ActivitySeller;
use YiZan\Models\Buyer\ShoppingCart;
use YiZan\Models\Goods;
use YiZan\Models\StaffServiceTime;
use YiZan\Models\Order;

use YiZan\Services\ActivityService;
use YiZan\Utils\Time;
use Lang, Validator, DB;

class ShoppingService extends \YiZan\Services\ShoppingService {
    /**
     * [save 购物车]
     * @param  [int] $userId           [会员编号]
     * @param  [int] $goodsId          [商品/服务编号]
     * @param  [int] $normsId          [规格编号]
     * @param  [int] $num              [数量] 
     * @param  [string] $serviceTime   [预约时间] 
     * @return [array]                 [返回数组]
     */
    public static function save($userId, $goodsId, $normsId, $num, $serviceTime,$shareUserId) {

    $shareUserId = $shareUserId ? $shareUserId : 0;
    $result = array(
        'code'  => self::SUCCESS,
        'data'  => null,
        'msg'   => Lang::get('api_staffwap.success.set')
    );

    if($userId <= 0) {
        $result['code'] = 50219;
        $result['data'] = self::getCartInfo($userId);
        return $result;
    }

    if($goodsId <= 0) {
        $result['code'] = 50220;
        $result['data'] = self::getCartInfo($userId);
        return $result;
    }

    $serviceTime = Time::toTime($serviceTime);

    //查询购物车是否存在商品
    $shoppingCart = ShoppingCart::where('user_id', $userId)
        ->where('goods_id', $goodsId);

    /*这段代码会导致第一条规格商品被删除	caiq
    if($normsId > 0){
        $shoppingCart->where('norms_id', $normsId);
    }*/
    $shoppingCart->where('norms_id', $normsId);
    $shoppingCart = $shoppingCart->first();

    $goods = Goods::where('id', $goodsId)->with('seller');
    if($normsId > 0){
        $goods->with(['norms' => function($query) use($normsId) {
            $query->where('id', $normsId);
        }]);
    }
    $goods = $goods->first();
    $isHasStock = true;

    if($goods->seller->store_type != 1){
        //商家是否在营业中
        $hours = Time::toDate(UTC_TIME, 'H:i');
        $week = Time::toDate(UTC_TIME, 'w');
        $serviceTimesCount = StaffServiceTime::where('seller_id', $goods->seller_id)
            ->where('week', $week)
            ->where('begin_time', '<=', $hours)
            ->where(function($query) use ($hours){
                $query->where('end_time', '>=', $hours)
                    ->orWhere('end_time', '00:00');
            })->count();

        if ($serviceTimesCount < 1) {
            $result['code'] = 60514;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }
    }

    //判断库存
    if($goods->type == 1)
    {
        if($normsId > 0){
            if($goods->norms[0]['stock'] < $num) {
                $isHasStock = false;
            }
        } else {
            if($goods->stock < $num) {
                $isHasStock = false;
            }
        }
    }

    if(!$isHasStock && $goods->type == Goods::SELLER_GOODS){
        $result['code'] = 50224;
        $result['data'] = self::getCartInfo($userId);
        return $result;
    }

    //如果是添加商品 不判断 限制条件
    if(empty($shoppingCart) || $shoppingCart['num'] <= $num){
        //判断是否限制购买数量
        if(!GoodsService::checkGoodsLimit($goods, $normsId, $userId, $num)){
            $result['code'] = 50223;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }
    }

    //如果购物车存在此商品就更新，否者就插入一条购物车数据
    if($shoppingCart){
        //如果数量为0 则删除此条购物车信息
        if($num <= 0) {
            ShoppingCart::where('id', $shoppingCart->id)
                ->delete();
        } else {
            $cartInfo = ['num' => $num];
            if($shoppingCart->type == Goods::SELLER_SERVICE){
                $cartInfo['service_time'] = $serviceTime;
            } else {
                $cartInfo['norms_id'] = $normsId;
            }
            $cartInfo['share_user_id']    = $shareUserId;
            ShoppingCart::where('id', $shoppingCart->id)
                ->update($cartInfo);
        }
    } else {//判断商品是否存在
        if($num <= 0){
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }
        $goods_data = Goods::where('id', $goodsId)
            ->with(['norms'=>function($query) use($normsId){
                $query->where('id', $normsId);
            }])
            ->first();
        if(empty($goods_data) || $goods_data->status == STATUS_DISABLED) {
            $result['code'] = 50220;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        } else {
            if(empty($goods_data->norms)){
                $result['code'] = 50221;
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
        }
        $cart_item = new ShoppingCart();
        $cart_item->user_id         = $userId;
        $cart_item->seller_id       = $goods_data->seller_id;
        $cart_item->goods_id        = $goods_data->id;
        $cart_item->norms_id        = $normsId;
        $cart_item->num             = $num;
        $cart_item->price           = $goods_data->price;
        $cart_item->type            = $goods_data->type;
        $cart_item->create_time     = UTC_TIME;
        $cart_item->service_time    = $serviceTime;
        $cart_item->share_user_id    = $shareUserId;
        $cart_item->save();
        if($cart_item->id < 0) {
            $result['code'] = 50222;
            $result['data'] = self::getCartInfo($userId);
        }
    }
    $result['data'] = self::getCartInfo($userId);
    return $result;
}

    /**
     * 2017/05/04 添加
     * @param $userId
     * @param $goodsId
     * @param $normsId
     * @param $num
     * @param $serviceTime
     * @param $shareUserId
     * @return array
     */
    public static function saveTwo($userId, $goodsId, $normsId, $num, $serviceTime,$shareUserId,$processId) {
        $act = new ActivityService();
        $act->refreshActicity();
        $shareUserId = $shareUserId ? $shareUserId : 0;
        $result = array(
            'code'  => self::SUCCESS,
            'data'  => null,
            'msg'   => Lang::get('api_staffwap.success.set')
        );

        if($userId <= 0) {
            $result['code'] = 50219;
            $result['data'] = self::getCartInfoTwo($userId);
            return $result;
        }

        if($goodsId <= 0) {
            $result['code'] = 50220;
            $result['data'] = self::getCartInfoTwo($userId);
            return $result;
        }

        $serviceTime = Time::toTime($serviceTime);

        //查询购物车是否存在商品
        $shoppingCart = ShoppingCart::where('user_id', $userId)
            ->where('goods_id', $goodsId);
        /*这段代码会导致第一条规格商品被删除	caiq
        if($normsId > 0){
            $shoppingCart->where('norms_id', $normsId);
        }*/
        if($normsId > 0){
            $shoppingCart->where('norms_id', $normsId);
        }else{
            $shoppingCart->where('norms_id', 0);
        }
        if($processId > 0){
            $shoppingCart->where('process_id',$processId);
        }else{
            $shoppingCart->where('process_id',0);
        }
        $shoppingCart = $shoppingCart->first();


        $goods = Goods::where('id', $goodsId)->with('seller');
        if($normsId > 0){
            $goods->with(['norms' => function($query) use($normsId) {
                $query->where('id', $normsId);
            }]);
        }
        $goods = $goods->first();
        $isHasStock = true;

        //验证活动start
        $activitySel = ActivitySeller::where('goods_id','=',$goodsId)->first();
        $activitySel = $activitySel ? $activitySel->toArray() : array();
        if($activitySel){
            $checkStatus = Activity::where('id','=',$activitySel['activityId'])->where('time_status','=',-1)->first();
            $checkStatus = $checkStatus ? $checkStatus->toArray() : array();
            if($checkStatus){
                $result['code'] = 50225;//该商品的活动已结束
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            }
            $checkStatus = Activity::where('id','=',$activitySel['activityId'])->where('time_status','=',0)->first();
            $checkStatus = $checkStatus ? $checkStatus->toArray() : array();
            if($checkStatus){
                $result['code'] = 50226;//该商品的活动未开始
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            }
        }
        //验证活动end
        if($goods->seller->store_type != 1){
            //商家是否在营业中
            $hours = Time::toDate(UTC_TIME, 'H:i');
            $week = Time::toDate(UTC_TIME, 'w');
            $serviceTimesCount = StaffServiceTime::where('seller_id', $goods->seller_id)
                ->where('week', $week)
                ->where('begin_time', '<=', $hours)
                ->where(function($query) use ($hours){
                    $query->where('end_time', '>=', $hours)
                        ->orWhere('end_time', '00:00');
                })->count();

            if ($serviceTimesCount < 1) {
                $result['code'] = 60514;
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            }
        }

        //判断库存
        if($goods->type == 1)
        {
            if($normsId > 0){
                if($goods->norms[0]['stock'] < $num) {
                    $isHasStock = false;
                }
            } else {
                if($goods->stock < $num) {
                    $isHasStock = false;
                }
            }
        }

        if(!$isHasStock && $goods->type == Goods::SELLER_GOODS){
            $result['code'] = 50224;
            $result['data'] = self::getCartInfoTwo($userId);
            return $result;
        }
//        var_dump($goods->toArray());die;
        //如果是添加商品 不判断 限制条件
        if(empty($shoppingCart) || $shoppingCart['num'] <= $num){
            //判断是否限制购买数量
            if(!GoodsService::checkGoodsLimit($goods, $normsId, $userId, $num)){
                $result['code'] = 50223;
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            }
        }

        //如果购物车存在此商品就更新，否者就插入一条购物车数据
        if($shoppingCart){
            //如果数量为0 则删除此条购物车信息
            if($num <= 0) {
                ShoppingCart::where('id', $shoppingCart->id)
                    ->delete();
            } else {
                $cartInfo = ['num' => $num];
                if($shoppingCart->type == Goods::SELLER_SERVICE){
                    $cartInfo['service_time'] = $serviceTime;
                } else {
                    $cartInfo['norms_id'] = ($normsId > 0) ? $normsId : 0;
                }
                $cartInfo['share_user_id']    = $shareUserId;
                $cartInfo['process_id'] = ($processId > 0) ? $processId : 0;
                ShoppingCart::where('id', $shoppingCart->id)
                    ->update($cartInfo);
            }
        } else {//判断商品是否存在
            if($num <= 0){
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            }
            $goods_data = Goods::where('id', $goodsId)
                ->with(['norms'=>function($query) use($normsId){
                    $query->where('id', $normsId);
                }])
                ->first();
            $goods = $goods_data->toArray();
//            var_dump($goods);die;
            if(empty($goods_data) || $goods_data->status == STATUS_DISABLED) {
                $result['code'] = 50220;
                $result['data'] = self::getCartInfoTwo($userId);
                return $result;
            } else {
                if(empty($goods_data->norms)){
                    $result['code'] = 50221;
                    $result['data'] = self::getCartInfoTwo($userId);
                    return $result;
                }
            }
            $goods_price = 0;
            if($goods['norms']){
                $goods_price = $goods['norms'][0]['salePrice'] > 0 ? $goods['norms'][0]['salePrice'] : $goods['norms'][0]['price'];
            }else{
                $goods_price = $goods['salePrice'] > 0 ? $goods['salePrice'] : $goods['price'];
            }

            $cart_item = new ShoppingCart();
            $cart_item->user_id         = $userId;
            $cart_item->seller_id       = $goods_data->seller_id;
            $cart_item->goods_id        = $goods_data->id;
            $cart_item->norms_id        = $normsId ? $normsId : 0;
            $cart_item->num             = $num;
            $cart_item->price           = $goods_price;
            $cart_item->type            = $goods_data->type;
            $cart_item->create_time     = UTC_TIME;
            $cart_item->service_time    = $serviceTime;
            $cart_item->share_user_id    = $shareUserId;
            $cart_item->process_id = ($processId > 0) ? $processId : 0;
            $cart_item->save();
            if($cart_item->id < 0) {
                $result['code'] = 50222;
                $result['data'] = self::getCartInfoTwo($userId);
            }
        }
        $result['data'] = self::getCartInfoTwo($userId);
        return $result;
    }
    public static function saveOne($userId, $goodsId, $normsId, $num, $serviceTime,$shareUserId,$processId) {
        $act = new ActivityService();
        $act->refreshActicity();
        $shareUserId = $shareUserId ? $shareUserId : 0;
        $result = array(
            'code'  => self::SUCCESS,
            'data'  => null,
            'msg'   => Lang::get('api_staffwap.success.set')
        );

        if($userId <= 0) {
            $result['code'] = 50219;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }

        if($goodsId <= 0) {
            $result['code'] = 50220;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }

        $serviceTime = Time::toTime($serviceTime);

        //查询购物车是否存在商品
        $shoppingCart = ShoppingCart::where('user_id', $userId)
            ->where('goods_id', $goodsId);
        /*这段代码会导致第一条规格商品被删除	caiq
        if($normsId > 0){
            $shoppingCart->where('norms_id', $normsId);
        }*/
//        if($normsId > 0){
            $shoppingCart->where('norms_id', (int)$normsId);
        /*}else{
            $shoppingCart->where('norms_id', 0);
        }*/
//        if($processId > 0){
            $shoppingCart->where('process_id',(int)$processId);
//        }
        $shoppingCart = $shoppingCart->first();

        $goods = Goods::where('id', $goodsId)->with('seller');
        if($normsId > 0){
            $goods->with(['norms' => function($query) use($normsId) {
                $query->where('id', $normsId);
            }]);
        }
        $goods = $goods->first();
        $isHasStock = true;

        //验证活动start
        $activitySel = ActivitySeller::where('goods_id','=',$goodsId)->first();
        $activitySel = $activitySel ? $activitySel->toArray() : array();
        if($activitySel){
            $checkStatus = Activity::where('id','=',$activitySel['activityId'])->where('time_status','=',-1)->first();
            $checkStatus = $checkStatus ? $checkStatus->toArray() : array();
            if($checkStatus){
                $result['code'] = 50225;//该商品的活动已结束
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
            $checkStatus = Activity::where('id','=',$activitySel['activityId'])->where('time_status','=',0)->first();
            $checkStatus = $checkStatus ? $checkStatus->toArray() : array();
            if($checkStatus){
                $result['code'] = 50226;//该商品的活动未开始
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
        }
        //验证活动end
        if($goods->seller->store_type != 1){
            //商家是否在营业中
            $hours = Time::toDate(UTC_TIME, 'H:i');
            $week = Time::toDate(UTC_TIME, 'w');
            $serviceTimesCount = StaffServiceTime::where('seller_id', $goods->seller_id)
                ->where('week', $week)
                ->where('begin_time', '<=', $hours)
                ->where(function($query) use ($hours){
                    $query->where('end_time', '>=', $hours)
                        ->orWhere('end_time', '00:00');
                })->count();

            if ($serviceTimesCount < 1) {
                $result['code'] = 60514;
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
        }

        //判断库存
        if($goods->type == 1)
        {
            if($normsId > 0){
                if($goods->norms[0]['stock'] < $num) {
                    $isHasStock = false;
                }
            } else {
                if($goods->stock < $num) {
                    $isHasStock = false;
                }
            }
        }

        if(!$isHasStock && $goods->type == Goods::SELLER_GOODS){
            $result['code'] = 50224;
            $result['data'] = self::getCartInfo($userId);
            return $result;
        }
//        var_dump($goods->toArray());die;
        //如果是添加商品 不判断 限制条件
        if(empty($shoppingCart) || $shoppingCart['num'] <= $num){
            //判断是否限制购买数量
            if(!GoodsService::checkGoodsLimit($goods, $normsId, $userId, $num)){
                $result['code'] = 50223;
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
        }

        //如果购物车存在此商品就更新，否者就插入一条购物车数据
        if($shoppingCart){
            //如果数量为0 则删除此条购物车信息
            if($num <= 0) {
                ShoppingCart::where('id', $shoppingCart->id)
                    ->delete();
            } else {
                $cartInfo = ['num' => $num];
                if($shoppingCart->type == Goods::SELLER_SERVICE){
                    $cartInfo['service_time'] = $serviceTime;
                } else {
                    $cartInfo['norms_id'] = ($normsId > 0) ? $normsId : 0;
                }
                $cartInfo['share_user_id']    = $shareUserId;
                $cartInfo['process_id'] = ($processId > 0) ? $processId : 0;
                ShoppingCart::where('id', $shoppingCart->id)
                    ->update($cartInfo);
            }
        } else {//判断商品是否存在
            if($num <= 0){
                $result['data'] = self::getCartInfo($userId);
                return $result;
            }
            $goods_data = Goods::where('id', $goodsId)
                ->with(['norms'=>function($query) use($normsId){
                    $query->where('id', $normsId);
                }])
                ->first();
            $goods = $goods_data->toArray();
//            var_dump($goods);die;
            if(empty($goods_data) || $goods_data->status == STATUS_DISABLED) {
                $result['code'] = 50220;
                $result['data'] = self::getCartInfo($userId);
                return $result;
            } else {
                if(empty($goods_data->norms)){
                    $result['code'] = 50221;
                    $result['data'] = self::getCartInfo($userId);
                    return $result;
                }
            }
            $goods_price = 0;
            if($goods['norms']){
                //$goods['norms'][0]['salePrice'] ? $goods['norms'][0]['salePrice'] :
                $goods_price =  $goods['norms'][0]['price'];
            }else{
                //$goods['salePrice'] ? $goods['salePrice'] :
                $goods_price =  $goods['price'];
            }
            $cart_item = new ShoppingCart();
            $cart_item->user_id         = $userId;
            $cart_item->seller_id       = $goods_data->seller_id;
            $cart_item->goods_id        = $goods_data->id;
            $cart_item->norms_id        = $normsId ? $normsId : 0;
            $cart_item->num             = $num;
            $cart_item->price           = $goods_price;
            $cart_item->type            = $goods_data->type;
            $cart_item->create_time     = UTC_TIME;
            $cart_item->service_time    = $serviceTime;
            $cart_item->share_user_id    = $shareUserId;
            $cart_item->process_id = ($processId > 0) ? $processId : 0;
            $cart_item->save();
            if($cart_item->id < 0) {
                $result['code'] = 50222;
                $result['data'] = self::getCartInfo($userId);
            }
        }
        $result['data'] = self::getCartInfo($userId);
        return $result;
    }

    /**
     * [delete 清空购物车]
     * @param  [type] $userId [会员ID]
     * @return [type]         [description]
     */
    public static function delete($userId, $id,$sellerId = 0,$type= 0) {
        $result = array(
            'code'  => self::SUCCESS,
            'data'  => null,
            'msg'   => Lang::get('api_staffwap.success.delete')
        );
        $res = ShoppingCart::where("user_id", $userId);
        if($id > 0){
            $res->where('id', $id);
        }
        if($sellerId > 0){
            $res->where('seller_id', $sellerId);
        }
        if($type > 0){
            $res->where('type', $type);
        }
        $res->delete(); 
        return $result;

    }

    /**
     * 2017/05/04 添加
     * [lists 查看购物车]
     * @param  [int] $userId [会员ID]
     * @param  [string] $location [购物车 选择的位置]
     * @return [type]         [description]
     */
    public static function listsTwo($userId, $location,$cityId) {
        ActivityService::refreshActicity();
        ShoppingCart::where("user_id",$userId)->where(function($query){
            $query->where('share_user_id','<>', 0)
                ->orWhere("share_user_id",'<>', "");
        })->delete();
        $list =  self::getCartInfoTwo($userId, $location,$cityId);
        return $list;
    }
    public static function lists($userId, $location,$cityId) {
        ActivityService::refreshActicity();
        ShoppingCart::where("user_id",$userId)->where(function($query){
            $query->where('share_user_id','<>', 0)
                ->orWhere("share_user_id",'<>', "");
        })->delete();
        $list =  self::getCartInfo($userId, $location,$cityId);
        return $list;
    }

    /**
     * [updateCart 更新购物车]
     * @param [int] $id     [购物车项目编号]
     * @param [int] $num    [数量] 
     * @array               [结果]
     */
    public static function updateCart($id, $num){
        $result = array(
            'code'  => self::SUCCESS,
            'data'  => null,
            'msg'   => '',
        );
        $data = ShoppingCart::where('id', $id);
        if($num <= 0){
            $data->delete();
        } else {
            $data->update(['num'=>$num]);
        }
        return $result;
    }

    /**
     * [getCartInfo 获取会员购物车信息]
     * @param [int] $userId     [会员编号]
     * @param [string] $location     [地理位置]
     * @param [array] $result   [购物车信息]
     */
    public static function getCartInfo($userId, $location = "",$cityId= "") {
        $dbPrefix = DB::getTablePrefix();
        $mapPoint = str_replace(',', ' ', $location);



        $result = ShoppingCart::join('seller', function($join){
            $join->on('shopping_cart.seller_id', '=', 'seller.id');
        })
            ->where('shopping_cart.user_id', $userId)
            ->groupBy('shopping_cart.seller_id', 'type');
        if($location){
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type,'. "ST_Contains({$dbPrefix}seller.map_pos,GeomFromText('Point({$mapPoint})')) as canService"));
        } else {
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type, 1 as canService'));
        }
        $hours = Time::toDate(UTC_TIME, 'H:i');
        $week = Time::toDate(UTC_TIME, 'w');
        $result = $result->with(['seller','seller.serviceTimesCount'=>function($query) use ($hours, $week){
            $query->where('week', $week)
                ->where('begin_time', '<=', $hours)
                ->where(function($query) use ($hours){
                    $query->where('end_time', '>=', $hours)
                        ->orWhere('end_time', '00:00');
                });
        }])->orderBy('canService', 'ACS')
            ->orderBy('shopping_cart.create_time', 'ACS')
            ->get()
            ->toArray();
        $data = [];



        foreach ($result as $key => $value) {
            $item = array();
            if($value['sellerId'] == ONESELF_SELLER_ID){
                array_push($value['seller']['businessScope'],0);
                if(in_array($cityId,$value['seller']['businessScope'])){
                    $item['canService'] = 1;
                }
            }else{
                $item['canService'] = $value['canService'];
            }
            $item['id'] = $value['sellerId'];
            $item['name'] = $value['seller']['name'];
            $item['logo'] = $value['seller']['logo'];
            $item['storeType'] = $value['seller']['storeType'];
            $item['serviceFee'] = $value['seller']['serviceFee'];
            $item['deliveryFee'] = $value['seller']['deliveryFee'];
            $item['isAvoidFee'] = $value['seller']['isAvoidFee'];
            $item['avoidFee'] = $value['seller']['avoidFee'];
            $item['canPay'] = 0;
            $item['type'] = $value['type'];
            $item['status'] = $value['seller']['status'];
            $item['countGoods'] = Goods::where('type', 1)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['countService'] = Goods::where('type', 2)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['serviceTimesCount'] = (int)$value['seller']['serviceTimesCount'];

            $seller_cart_info = ShoppingCart::join('goods', function($join){
                $join->on('shopping_cart.goods_id', '=', 'goods.id');
            })
                ->where('shopping_cart.seller_id', $value['sellerId'])
                ->where('shopping_cart.user_id', $userId)
                ->where('shopping_cart.type', $value['type'])
                ->selectRaw($dbPrefix.'shopping_cart.*, IF('.$dbPrefix.'goods.stock > 0,1,0) as nstock, '.$dbPrefix.'goods.status as nstatus')
                ->with('goods', 'goods.collect', 'norms')
                ->orderBy('nstatus', 'DESC')
                ->orderBy('nstock', 'DESC')
                ->orderBy('shopping_cart.create_time', 'ACS')
                ->get()
                ->toArray();
            $total_price = 0;
            $goods = array();
            $affectNum = 0;

            //读取活动
            $activity = ActivityService::getSellerActivity($value['sellerId']);
            //获取商品特价信息
            $activity = $activity['special'];

            if( ! function_exists('array_column'))
            {
                $saleGoodsId = \YiZan\Http\Controllers\YiZanViewController::array_column($activity, 'goodsId');
            }
            else{
                $saleGoodsId = array_column($activity, 'goodsId');
            }

            foreach ($seller_cart_info as $key1 => $value1) {
                $goods_item = array();
                $goods_item['id']           = $value1['id'];
                $goods_item['type']         = $value1['goods']['type'];
                $goods_item['goodsId']      = $value1['goodsId'];
                $goods_item['normsId']      = $value1['normsId'];
                $goods_item['name']         = $value1['goods']['name'];
                $goods_item['num']          = $value1['num'];
                $goods_item['logo']         = $value1['goods']['logo'];
                $goods_item['duration']     = $value1['goods']['duration'];
                $goods_item['status']       = $value1['goods']['status'];
                $goods_item['stock']        = $value1['goods']['stock'];
                if($value1['norms']){
                    $goods_item['stock']    = $value1['norms']['stock'];
                    $goods_item['price']    = $value1['norms']['price'];
                    $goods_item['name']     = $goods_item['name'];
                    $goods_item['normsName']     = $value1['norms']['name'];
                } else {
                    $goods_item['serviceTime'] = Time::toDate($value1['serviceTime'], 'Y-m-d H:i:s');
                    $goods_item['price']        = $value1['goods']['price'];
                }

                if($value1['goods']['collect']){
                    $goods_item['isCollect'] = 1;
                } else {
                    $goods_item['isCollect'] = 0;
                }

                $goods_item['storeType'] = $value1['storeType'];

                //获取折扣
                $goods_item['sale'] = 10;  //默认不打折

                //排除的状态
                $notStatus = [
                    ORDER_STATUS_CANCEL_USER,
                    ORDER_STATUS_CANCEL_AUTO,
                    ORDER_STATUS_CANCEL_SELLER,
                    ORDER_STATUS_CANCEL_ADMIN,
                ];

                if(in_array($value1['goodsId'], $saleGoodsId))
                {
                    $thisGoodsActivity = $activity[$value1['goodsId']];

                    //获取每天满减次数，特价次数
                    $activityCount = Order::where('user_id', $userId)->whereNotIn('status', $notStatus)->where('create_day', Time::getNowDay())->where('activity_goods_id', 'like', '%,'.$thisGoodsActivity['id'].',%')->count();
                    if( $activityCount < $thisGoodsActivity['joinNumber'] )
                    {
                        $goods_item['sale'] = $thisGoodsActivity['sale'];
                    }
                }

                if(isset($value1['norms'])){
                    if($value1['goods']['status'] && ($value1['norms']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                } else {
                    if($value1['goods']['status'] && ($value1['goods']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                }

                $goods[] = $goods_item;
            }

            //cz
            if($value['seller']['storeType'] == 1){
                $item['serviceTimesCount'] = 1;
                $item['canService'] = 1;
            }

            if($affectNum > 0 && $item['canService']){
                $item['canPay'] = 1;
            }
            $item['price'] = $total_price;
            $item['goods'] = $goods;
            $item['sendType'] = $value['seller']['sendType'];

            if($item['status']){
                $data[] = $item;
            }
        }

        return $data;
    }

    /**
     * 2017/05/04 添加
     * @param $userId
     * @param string $location
     * @param string $cityId
     * @return array
     */
    public static function getCartInfoTwo($userId, $location = "",$cityId= "") {
        $dbPrefix = DB::getTablePrefix();
        $mapPoint = str_replace(',', ' ', $location);



        $result = ShoppingCart::join('seller', function($join){
            $join->on('shopping_cart.seller_id', '=', 'seller.id');
        })
            ->where('shopping_cart.user_id', $userId)
            ->groupBy('shopping_cart.seller_id', 'type');
        if($location){
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type,'. "ST_Contains({$dbPrefix}seller.map_pos,GeomFromText('Point({$mapPoint})')) as canService"));
        } else {
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type, 1 as canService'));
        }
        $hours = Time::toDate(UTC_TIME, 'H:i');
        $week = Time::toDate(UTC_TIME, 'w');
        $result = $result->with(['seller','seller.serviceTimesCount'=>function($query) use ($hours, $week){
            $query->where('week', $week)
                ->where('begin_time', '<=', $hours)
                ->where(function($query) use ($hours){
                    $query->where('end_time', '>=', $hours)
                        ->orWhere('end_time', '00:00');
                });
        }])->orderBy('canService', 'ACS')
            ->orderBy('shopping_cart.create_time', 'ACS')
            ->get()
            ->toArray();
        $data = [];



        foreach ($result as $key => $value) {
            $item = array();
            if($value['sellerId'] == ONESELF_SELLER_ID){
                array_push($value['seller']['businessScope'],0);
                if(in_array($cityId,$value['seller']['businessScope'])){
                    $item['canService'] = 1;
                }
            }else{
                $item['canService'] = $value['canService'];
            }
            $item['id'] = $value['sellerId'];
            $item['name'] = $value['seller']['name'];
            $item['logo'] = $value['seller']['logo'];
            $item['storeType'] = $value['seller']['storeType'];
            $item['serviceFee'] = $value['seller']['serviceFee'];
            $item['deliveryFee'] = $value['seller']['deliveryFee'];
            $item['isAvoidFee'] = $value['seller']['isAvoidFee'];
            $item['avoidFee'] = $value['seller']['avoidFee'];
            $item['canPay'] = 0;
            $item['type'] = $value['type'];
            $item['status'] = $value['seller']['status'];
            $item['countGoods'] = Goods::where('type', 1)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['countService'] = Goods::where('type', 2)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['serviceTimesCount'] = (int)$value['seller']['serviceTimesCount'];

            $seller_cart_info = ShoppingCart::join('goods', function($join){
                $join->on('shopping_cart.goods_id', '=', 'goods.id');
            })
                ->where('shopping_cart.seller_id', $value['sellerId'])
                ->where('shopping_cart.user_id', $userId)
                ->where('shopping_cart.type', $value['type'])
                ->selectRaw($dbPrefix.'shopping_cart.*, IF('.$dbPrefix.'goods.stock > 0,1,0) as nstock, '.$dbPrefix.'goods.status as nstatus')
                ->with('goods', 'goods.collect', 'norms', 'goodsProcessingCharges')
                ->orderBy('nstatus', 'DESC')
                ->orderBy('nstock', 'DESC')
                ->orderBy('shopping_cart.create_time', 'ACS')
                ->get()
                ->toArray();
            $total_price = 0;
            $goods = array();
            $affectNum = 0;

            //读取活动
            $activity = ActivityService::getSellerActivity($value['sellerId']);
            //获取商品特价信息
            $activity = $activity['special'];

            if( ! function_exists('array_column'))
            {
                $saleGoodsId = \YiZan\Http\Controllers\YiZanViewController::array_column($activity, 'goodsId');
            }
            else{
                $saleGoodsId = array_column($activity, 'goodsId');
            }

            foreach ($seller_cart_info as $key1 => $value1) {
                $goods_item = array();
                $goods_item['id']           = $value1['id'];
                $goods_item['type']         = $value1['goods']['type'];
                $goods_item['goodsId']      = $value1['goodsId'];
                $goods_item['normsId']      = $value1['normsId'];
                $goods_item['name']         = $value1['goods']['name'];
                $goods_item['num']          = $value1['num'];
                $goods_item['logo']         = $value1['goods']['logo'];
                $goods_item['duration']     = $value1['goods']['duration'];
                $goods_item['status']       = $value1['goods']['status'];
                $goods_item['stock']        = $value1['goods']['stock'];
                $goods_item['model']        = $value1['goods']['model'];
                if($value1['norms']){
                    $goods_item['stock']    = $value1['norms']['stock'];
                    $goods_item['price']    = $value1['norms']['price'];
                    $goods_item['name']     = $goods_item['name'];
                    $goods_item['normsId']  = $value1['norms']['id'];
                    $goods_item['normsPrice'] = $value1['norms']['price'];
                    $goods_item['normsName']     = $value1['norms']['name'];
                } else {
                    $goods_item['serviceTime'] = Time::toDate($value1['serviceTime'], 'Y-m-d H:i:s');
                    $goods_item['price']        = $value1['goods']['salePrice'] > 0 ? $value1['goods']['salePrice'] : $value1['goods']['price'];
                }

                if($value1['goods']['collect']){
                    $goods_item['isCollect'] = 1;
                } else {
                    $goods_item['isCollect'] = 0;
                }

                $goods_item['storeType'] = $value1['storeType'];

                //获取折扣
                $goods_item['sale'] = 10;  //默认不打折

                //排除的状态
                $notStatus = [
                    ORDER_STATUS_CANCEL_USER,
                    ORDER_STATUS_CANCEL_AUTO,
                    ORDER_STATUS_CANCEL_SELLER,
                    ORDER_STATUS_CANCEL_ADMIN,
                ];

                if(in_array($value1['goodsId'], $saleGoodsId))
                {
                    $thisGoodsActivity = $activity[$value1['goodsId']];

                    //获取每天满减次数，特价次数
                    $activityCount = Order::where('user_id', $userId)->whereNotIn('status', $notStatus)->where('create_day', Time::getNowDay())->where('activity_goods_id', 'like', '%,'.$thisGoodsActivity['id'].',%')->count();
                    if( $activityCount < $thisGoodsActivity['joinNumber'] )
                    {
                        $goods_item['sale'] = $thisGoodsActivity['sale'];
                    }
                }

                if(isset($value1['norms'])){
                    if($value1['goods']['status'] && ($value1['norms']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                } else {
                    if($value1['goods']['status'] && ($value1['goods']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                }
                if(isset($value1['goodsProcessingCharges'])){
                    $goods_item['processid'] = $value1['goodsProcessingCharges']['id'];
                    $goods_item['processingName'] = $value1['goodsProcessingCharges']['name'];
                    $goods_item['processingPrice'] =  $value1['goodsProcessingCharges']['price'];
                }else{
                    $goods_item['processid'] = $value1['goodsProcessingCharges']['id'];
                    $goods_item['processingName'] = $value1['goodsProcessingCharges']['name'];
                    $goods_item['processingPrice'] =  0;
                }
                $goods[] = $goods_item;
            }

            //cz
            if($value['seller']['storeType'] == 1){
                $item['serviceTimesCount'] = 1;
                $item['canService'] = 1;
            }

            if($affectNum > 0 && $item['canService']){
                $item['canPay'] = 1;
            }
            $item['price'] = $total_price;
            $item['goods'] = $goods;
            $item['sendType'] = $value['seller']['sendType'];

            if($item['status']){
                $data[] = $item;
            }
        }

        return $data;
    }

    public static function getCartInfoOne($userId, $location = "",$cityId= "") {
        $dbPrefix = DB::getTablePrefix();
        $mapPoint = str_replace(',', ' ', $location);



        $result = ShoppingCart::join('seller', function($join){
                                $join->on('shopping_cart.seller_id', '=', 'seller.id');
                              })
                              ->where('shopping_cart.user_id', $userId)
                              ->groupBy('shopping_cart.seller_id', 'type');
        if($location){
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type,'. "ST_Contains({$dbPrefix}seller.map_pos,GeomFromText('Point({$mapPoint})')) as canService"));
        } else {
            $result->select(DB::raw('sum('.$dbPrefix.'shopping_cart.price) as price, '.$dbPrefix.'shopping_cart.seller_id as seller_id, '.$dbPrefix.'shopping_cart.type, 1 as canService'));
        }
        $hours = Time::toDate(UTC_TIME, 'H:i');
        $week = Time::toDate(UTC_TIME, 'w');
        $result = $result->with(['seller','seller.serviceTimesCount'=>function($query) use ($hours, $week){
                                $query->where('week', $week)
                                ->where('begin_time', '<=', $hours)
                                ->where(function($query) use ($hours){
                                    $query->where('end_time', '>=', $hours)
                                        ->orWhere('end_time', '00:00');
                                });
                        }])->orderBy('canService', 'ACS')
                         ->orderBy('shopping_cart.create_time', 'ACS')
                         ->get()
                         ->toArray();
        $data = [];



        foreach ($result as $key => $value) {
            $item = array();
            if($value['sellerId'] == ONESELF_SELLER_ID){
                array_push($value['seller']['businessScope'],0);
                if(in_array($cityId,$value['seller']['businessScope'])){
                    $item['canService'] = 1;
                }
            }else{
                $item['canService'] = $value['canService'];
            }
            $item['id'] = $value['sellerId'];
            $item['name'] = $value['seller']['name'];
            $item['logo'] = $value['seller']['logo'];
            $item['storeType'] = $value['seller']['storeType'];
            $item['serviceFee'] = $value['seller']['serviceFee']; 
            $item['deliveryFee'] = $value['seller']['deliveryFee'];
            $item['isAvoidFee'] = $value['seller']['isAvoidFee'];
            $item['avoidFee'] = $value['seller']['avoidFee'];
            $item['canPay'] = 0;
            $item['type'] = $value['type'];
            $item['status'] = $value['seller']['status'];
            $item['countGoods'] = Goods::where('type', 1)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['countService'] = Goods::where('type', 2)->where('seller_id', $value['sellerId'])->where('status', 1)->count('id');
            $item['serviceTimesCount'] = (int)$value['seller']['serviceTimesCount'];

            $seller_cart_info = ShoppingCart::join('goods', function($join){
                                                $join->on('shopping_cart.goods_id', '=', 'goods.id');
                                            })
                                            ->where('shopping_cart.seller_id', $value['sellerId'])
                                            ->where('shopping_cart.user_id', $userId)
                                            ->where('shopping_cart.type', $value['type'])
                                            ->selectRaw($dbPrefix.'shopping_cart.*, IF('.$dbPrefix.'goods.stock > 0,1,0) as nstock, '.$dbPrefix.'goods.status as nstatus')
                                            ->with('goods', 'goods.collect', 'norms', 'goodsProcessingCharges')
                                            ->orderBy('nstatus', 'DESC')
                                            ->orderBy('nstock', 'DESC')
                                            ->orderBy('shopping_cart.create_time', 'ACS')
                                            ->get()
                                            ->toArray();
            $total_price = 0;
            $goods = array(); 
            $affectNum = 0;

            //读取活动
            $activity = ActivityService::getSellerActivity($value['sellerId']);
            //获取商品特价信息
            $activity = $activity['special'];

            if( ! function_exists('array_column'))
            {
                $saleGoodsId = \YiZan\Http\Controllers\YiZanViewController::array_column($activity, 'goodsId');
            }
            else{
                $saleGoodsId = array_column($activity, 'goodsId');
            }

            foreach ($seller_cart_info as $key1 => $value1) {
                $goods_item = array();
                $goods_item['sellerId'] = $value1['sellerId'];
                $goods_item['id']           = $value1['id'];
                $goods_item['type']         = $value1['goods']['type'];
                $goods_item['goodsId']      = $value1['goodsId'];
                $goods_item['normsId']      = $value1['normsId'];
                $goods_item['name']         = $value1['goods']['name'];
                $goods_item['num']          = $value1['num'];
                $goods_item['logo']         = $value1['goods']['logo'];
                $goods_item['duration']     = $value1['goods']['duration'];
                $goods_item['status']       = $value1['goods']['status'];
                $goods_item['stock']        = $value1['goods']['stock'];
                if($value1['norms']){
                    $goods_item['stock']    = $value1['norms']['stock'];  
                    $goods_item['price']    = $value1['norms']['salePrice'] ? $value1['norms']['salePrice'] : $value1['norms']['price'];
                    $goods_item['name']     = $goods_item['name'];
                    $goods_item['normsId']  = $value1['norms']['id'];
                    $goods_item['normsPrice'] = $value1['norms']['price'];
                    $goods_item['normsSalePrice'] = $value1['norms']['salePrice'];
                    $goods_item['normsName']     = $value1['norms']['name'];
                } else {
                    $goods_item['serviceTime'] = Time::toDate($value1['serviceTime'], 'Y-m-d H:i:s');
                    $goods_item['price']        = $value1['goods']['salePrice'] ? $value1['goods']['salePrice'] : $value1['goods']['price'];
                }
                
                if($value1['goods']['collect']){
                    $goods_item['isCollect'] = 1;
                } else {
                    $goods_item['isCollect'] = 0;
                }

                $goods_item['storeType'] = $value1['storeType'];

                //获取折扣
                $goods_item['sale'] = 10;  //默认不打折

                //排除的状态
                $notStatus = [
                    ORDER_STATUS_CANCEL_USER,
                    ORDER_STATUS_CANCEL_AUTO,
                    ORDER_STATUS_CANCEL_SELLER,
                    ORDER_STATUS_CANCEL_ADMIN,
                ];

                if(in_array($value1['goodsId'], $saleGoodsId))
                {
                    $thisGoodsActivity = $activity[$value1['goodsId']];

                    //获取每天满减次数，特价次数
                    $activityCount = Order::where('user_id', $userId)->whereNotIn('status', $notStatus)->where('create_day', Time::getNowDay())->where('activity_goods_id', 'like', '%,'.$thisGoodsActivity['id'].',%')->count();
                    if( $activityCount < $thisGoodsActivity['joinNumber'] )
                    {
                        $goods_item['sale'] = $thisGoodsActivity['sale'];
                    }
                }

                if(isset($value1['norms'])){
                    if($value1['goods']['status'] && ($value1['norms']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                } else {
                    if($value1['goods']['status'] && ($value1['goods']['stock'] > 0 || $goods_item['type'] == 2)){
                        $total_price += $goods_item['price'] * $value1['num'] * ($goods_item['sale'] / 10);
                        $affectNum += $value1['num'];
                    }
                }
                if(isset($value1['goodsProcessingCharges'])){
                    $item['processingPrice'] = $value1['goodsProcessingCharges']['price'];
                    $goods_item['processingPrice'] =  $value1['goodsProcessingCharges']['price'];
                }else{
                    $item['processingPrice'] = 0;
                    $goods_item['processingPrice'] =  0;
                }

                $goods[] = $goods_item;
            }

            //cz
            if($value['seller']['storeType'] == 1){
                $item['serviceTimesCount'] = 1;
                $item['canService'] = 1;
            }

            if($affectNum > 0 && $item['canService']){
                $item['canPay'] = 1;
            }
            $item['price'] = $total_price;
            $item['goods'] = $goods;
            $item['sendType'] = $value['seller']['sendType'];

            if($item['status']){
                $data[] = $item;
            }
        }

        return $data;
    }


    /**
     * 根据编号获取信息
     * @param int $userId 会员编号
     * @param array $ids 购物车编号
     */
    public static function getCartList($userId, $ids) {
        $result = [
            'code' => 0,
            'data' => null,
            'msg' => ''
        ];
        $check = ShoppingCart::where('user_id', $userId)
                            ->whereIn('id', $ids);
        $checkSeller = $check->groupBy('seller_id')
                        ->select('seller_id')
                        ->get()->toArray();
        if (count($checkSeller) > 1) {
            $result['code'] = 60511;
            return $result;
        }

        $checkSeller = $check->groupBy('type')
                        ->select('type')
                        ->get()->toArray();
        if (count($checkSeller) > 1) {
            $result['code'] = 60512;
            return $result;
        }

        $checkService = $check->where('type', 2)->count();
        if ($checkService > 1) {
            $result['code'] = 60513;
            return $result;
        }

        $result['data'] = ShoppingCart::where('user_id', $userId)
                    ->whereIn('id', $ids)
                    ->with('goods', 'seller.extend', 'norms', 'goodsProcessingCharges')
                    ->orderBy("share_user_id",'DESC')
                    ->get()->toArray();
        return $result;
    }

    /**
     * 2017/05/08 添加
     * @param $userId
     * @param $ids
     * @return array
     */
    public static function getCartListTwo($userId, $ids) {
        $result = [
            'code' => 0,
            'data' => null,
            'msg' => ''
        ];
        $check = ShoppingCart::where('user_id', $userId)
            ->whereIn('id', $ids);
        $checkSeller = $check->groupBy('seller_id')
            ->select('seller_id')
            ->get()->toArray();
        if (count($checkSeller) > 1) {
            $result['code'] = 60511;
            return $result;
        }

        $checkSeller = $check->groupBy('type')
            ->select('type')
            ->get()->toArray();
        if (count($checkSeller) > 1) {
            $result['code'] = 60512;
            return $result;
        }

        $checkService = $check->where('type', 2)->count();
        if ($checkService > 1) {
            $result['code'] = 60513;
            return $result;
        }

        $result['data'] = ShoppingCart::where('user_id', $userId)
            ->whereIn('id', $ids)
            ->with('goods', 'seller.extend', 'norms', 'goodsProcessingCharges')
            ->orderBy("share_user_id",'DESC')
            ->get()->toArray();
        return $result;
    }
    /**
     * [getInfo 获取购物车信息]
     * @param  [type] $userId  [description]
     * @param  [type] $goodsId [description]
     * @return [type]          [description]
     */
    public static function getInfo($userId, $goodsId) {
        $data = ShoppingCart::where('user_id', $userId)->where('goods_id', $goodsId)->orderBy('id', 'desc')->first();
        return $data;
    }
}
