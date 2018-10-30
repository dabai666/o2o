<?php 
namespace YiZan\Services;

use YiZan\Models\Adv;
use YiZan\Models\SellerCate;
/**
 * 广告管理
 */
class AdvService extends BaseService {
	public static function getAdvByCode($code, $cityId = 0, $sellerCateId = 0){
        $city = $cityId > 0 ? [0,$cityId] : [0];
        $list = Adv::select('adv.*')
            ->join('adv_position', function($join) use($code) {
                $join->on('adv_position.id', '=', 'adv.position_id')
                    ->where('adv_position.code', '=', $code);
            })
            ->whereIn('adv.city_id', $city)
            ->where('adv.flage',0)
            ->where('adv.status',1)
            ->orderBy('adv.city_id','desc')
            ->orderBy('adv.sort','asc')
            ->orderBy('adv.id','asc');

        if ($code == 'BUYER_SELLER_BANNER') {
            $sellerCates = $sellerCateId > 0 ? [0,$sellerCateId] : [0];
            $sellerCate = SellerCate::where('id', $sellerCateId)->first();
            if ($sellerCate && $sellerCate->pid == 0) {
                $sellerChildCates = SellerCate::where('pid', $sellerCateId)->lists('id');
                if (!empty($sellerChildCates)) {
                    $sellerCates = array_merge($sellerCates, $sellerChildCates);
                }

            }
            $list->whereIn('adv.seller_cate_id', $sellerCates);
        }

        $list = $list->get()->toArray();
        foreach($list as $key => $value)
        {
            $list[$key]["icon"] = $value["image"];
            switch ($value['type']) {
                case '1' : $list[$key]["url"] = u('wap#Seller/index', ['id' => $value['arg']]);  break;
                case '2' : $list[$key]["url"] = ''; break;
                case '3' : $list[$key]["url"] = u('wap#Goods/detail', ['goodsId' => $value['arg']]); break;
                case '4' : $list[$key]["url"] = u('wap#Seller/detail', ['id' => $value['arg']]); break;
                case '5' : $list[$key]["url"] = $value['arg']; break;
                case '6' : $list[$key]["url"] = u('wap#Goods/detail', ['goodsId' => $value['arg']]); break;
                case '7' : $list[$key]["url"] = u('wap#Article/detail', ['id' => $value['arg']]); break;
                case '8' : $list[$key]["url"] = u('wap#UserCenter/signin'); break;
                case '9' : $list[$key]["url"] = u('wap#Integral/index'); break;
                case '10' : $list[$key]["url"] = u('wap#Oneself/index'); break;
                case '11' : $list[$key]["url"] = u('wap#Property/index'); break;
                case '12' : $list[$key]["url"] = u('wap#Property/livipayment'); break;
                case '13' : $list[$key]["url"] = u('wap#Activity/secsale',['activityId'=>$value['arg'],'index_flage'=>'index']);break;
            }

        }

        return $list;
	}
}
