<?php namespace YiZan\Models;

class OrderGoods extends Base 
{
    public function goods(){
        return $this->belongsToMany('YiZan\Models\Goods', 'order_goods', 'id', 'goods_id');
    }

    public function categoods(){
        return $this->belongsTo('YiZan\Models\Goods', 'goods_id', 'id');
    }
    public function goodsNorms(){
        return $this->belongsTo('YiZan\Models\GoodsNorms', 'goods_norms_id', 'id');
    }
}
