<?php namespace YiZan\Models;

class OrderPromotion extends Base {
	protected $visible = ['id', 'discount_fee', 'promotion_name' , 'promotion_id', 'order_id', 'promotion_sn_id'];
}