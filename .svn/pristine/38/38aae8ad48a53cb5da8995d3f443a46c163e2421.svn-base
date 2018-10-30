<?php 
namespace YiZan\Http\Controllers\Api\Buyer;

use YiZan\Models\ShoppingCart;
use YiZan\Services\Buyer\ShoppingService;

/**
 * 购物车
 */
class ShoppingController extends BaseController {

    /**
     * 加入购物车
     */
	public function save() {
        $data = ShoppingService::save(
        	(int)$this->userId,
        	(int)$this->request('goodsId'),
        	(int)$this->request('normsId'),
        	(int)$this->request('num'),
            $this->request('serviceTime'),
            $this->request('shareUserId',0)
        );
        return $this->output($data);
    }

    /**
     * 2017/05/04 添加
     * @return mixed
     */
    public function saveTwo(){
        $data = ShoppingService::saveTwo(
            (int)$this->userId,
            (int)$this->request('goodsId'),
            (int)$this->request('normsId'),
            (int)$this->request('num'),
            $this->request('serviceTime'),
            $this->request('shareUserId',0),
            $this->request('processId',0)
        );
        return $this->output($data);
    }
    public function saveOne() {
        $data = ShoppingService::saveOne(
            (int)$this->userId,
            (int)$this->request('goodsId'),
            (int)$this->request('normsId'),
            (int)$this->request('num'),
            $this->request('serviceTime'),
            $this->request('shareUserId',0),
            $this->request('processId',0)
        );
        return $this->output($data);
    }
    /**
     * 清空购物车
     */
    public function delete() {
        $data = ShoppingService::delete(
            (int)$this->userId,
            (int)$this->request('id'),
            (int)$this->request('sellerId'),
            (int)$this->request('type')
        );
        return $this->outputData($data);
    }

    public function getCart(){
        $data = ShoppingCart::where('seller_id','=',$this->request('sellerId'))
            ->where('user_id','=',$this->userId)
            ->where('goods_id','=',$this->request('goodsId'))
            ->sum('num');
        return $this->outputData($data);
        /*$data = ShoppingService::getCart(
            (int)$this->userId,
            (int)$this->request('id'),
            (int)$this->request('sellerId')
        );*/
//        return $this->outputData($data);
    }

    /**
     * 获取购物车
     */
    public function listsTwo() {
        $data = ShoppingService::listsTwo(
            (int)$this->userId,
            $this->request('location'),
            $this->request('cityId')
        );
        return $this->outputData($data);
    }
    public function lists() {
        $data = ShoppingService::lists(
            (int)$this->userId,
            $this->request('location'),
            $this->request('cityId')
        );
        return $this->outputData($data);
    }

    /**
     * 修改购物车
     */
    public function update() {
        $data = ShoppingService::updateCart(
            (int)$this->request('id'),
            (int)$this->request('num')
            );
        return $this->outputData($data);
    }

    /**
     * 根据购物车编号获取信息
     */
    public function getCartList(){
        $data = ShoppingService::getCartList(
            $this->userId,
            (array)$this->request('ids')
        );
        return $this->output($data);
    }

    /**
     * 2017/05/08 添加
     * @return mixed
     */
    public function getCartListTwo(){
        $data = ShoppingService::getCartListTwo(
            $this->userId,
            (array)$this->request('ids')
        );
        return $this->output($data);
    }

    /**
     * 根据商品获取购物车信息
     */
    public function getInfo() {
        $data = ShoppingService::getInfo(
            $this->userId,
            $this->request('goodsId')
        );
        return $this->outputData($data);
    }
    
}