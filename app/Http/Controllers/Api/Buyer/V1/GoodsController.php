<?php 
namespace YiZan\Http\Controllers\Api\Buyer;

use YiZan\Models\ShopBrand;
use YiZan\Models\SystemTag;
use YiZan\Models\SystemTagList;
use YiZan\Services\Buyer\GoodsService;
use YiZan\Services\Buyer\OrderService;
use YiZan\Services\GoodsCateService;

class GoodsController extends BaseController {
	public function getGoodsList()
	{
		$data = GoodsService::getGoodsList(
				$this->request('id'),
				$this->request('firstLevelId'),
				intval($this->request('BrandId')),
				intval($this->request('classifyId')),
				intval($this->request('userId')),
				intval($this->request('type'))

		);
		return $this->outputData($data);
	}
	public function getVal(){
		$data = OrderService::getVal(
				$this->userId,
				$this->request('goodsId',0),
				$this->request('normsId',0),
				$this->request('processId',0)
		);
		return $data;
	}
	public function getBrand(){
		$data = GoodsService::getSellerGoodsLists1(
				$this->userId,
				$this->request('id'),
				$this->request('name'),
				$this->request('brandId'),
				$this->request('classifyId')
		);
		$brandId = array();
		if($data){
			foreach($data as $k => $v){
				foreach($v['goods'] as $key => $value){
					$brandId[] = $value['brandId'];
				}
 			}
			$brandId = array_unique($brandId);
			$list = ShopBrand::whereIn('id',$brandId)->get()->toArray();
			array_unshift($list,array('id'=>-1,'name'=>'全部'));
		}
		return $this->outputData($list);
	}
	public function getClassify(){
		$data = GoodsService::getSellerGoodsLists1(
				$this->userId,
				$this->request('id'),
				$this->request('name'),
				$this->request('brandId'),
				$this->request('classifyId')
		);
//		var_dump($data);
		$classifyId = array();
		if($data){
			foreach($data as $k => $v){
				foreach($v['goods'] as $key => $value){
					$classifyId[] = $value['systemTagListId'];
				}
			}
			$classifyId = array_unique($classifyId);
			$list = SystemTagList::whereIn('id',$classifyId)->get()->toArray();
//			array_unshift($list,array('id'=>-1,'name'=>'全部'));
		}
		return $this->outputData($list);
	}
	/**
	 * 服务列表
	 */
	public function lists() {
		$data = GoodsService::getSellerGoodsLists( 
				$this->userId,
				$this->request('id')
			);
		return $this->outputData($data);
	}
	public function getLists2(){
		$data = GoodsService::getSellerGoodsLists1(
				$this->userId,
				$this->request('id'),
				$this->request('name'),
				$this->request('brandId'),
				$this->request('classifyId')
		);
		return $this->outputData($data);
	}
	//备份
	public function lists1() {
		$data = GoodsService::getSellerGoodsLists(
				$this->userId,
				$this->request('id')
		);
		return $this->outputData($data);
	}
    /**
     * 服务列表
     */
    public function getlists() {
        $data = GoodsService::getGoodsLists(
            $this->request('id'),
            (int)$this->request('sort'),
            max((int)$this->request('page'), 1),
            max((int)$this->request('pageSize'), 20)
        );
        return $this->outputData($data);
    }
    /**
     * 商品 DSY
     */
    public function getGoodsListsDsy() {
        $data = GoodsService::getGoodsListsDsy(
            $this->userId,
            $this->request('id'),
            $this->request('mapPoint'),
            (int)$this->request('sort'),
            max((int)$this->request('page'), 1),
            max((int)$this->request('pageSize'), 20)
        );
        return $this->outputData($data);
    }

    /**
     * 服务列表
     */
    public function setsharenum() {
        $data = GoodsService::setShareNum(
            $this->userId,
            $this->request('shareType'),
            $this->request('shareUserId'),
            $this->request('id')
        );
        return $this->outputData($data);
    }

	public function setbrowse() {
		$code = GoodsService::setBrowse((int)$this->request('goodsId'), $this->userId);
		return $this->outputCode($code);
	}

	/**
	 * 服务详细
	 */
	public function detail() {
        $data = GoodsService::getById((int)$this->request('goodsId'), $this->userId);
        if ($data && $data['status'] == STATUS_ENABLED) {
            if(isset($data['collect'])){
                unset($data['collect']);
                $data['iscollect'] = 1;
            } else {
                unset($data['collect']);
                $data['iscollect'] = 0;
            }
            $data['url'] = u('wap#Goods/appbrief',['goodsId'=>$data['id']]);
            return $this->outputData($data);
        }
		return $this->outputCode(40002);
	}

    /*
     * 服务分类
     */
    public function goodCateList() {
        return $this->outputData(GoodsCateService::wapGetList());
    }
    /*
     * 服务二级分类
     */
    public function goodCateList2()
    {
        return $this->outputData(GoodsCateService::wapGetList2((int)$this->request('cateId')));
    }
    /**
	 * 可预约时间
	 */
	public function appointday() {
		$data = GoodsService::getCanAppointHours(
				(int)$this->request('goodsId'),
				(int)$this->request('duration'),
				(int)$this->request('staffId')
			);
		if (!$data) {
			return $this->outputCode(40001);
		}
		return $this->outputData($data);
	}

	/**
	 * 获取分类商品
	 */
	public function goodstaglists() {
		//$system_tag_list_pid, $apoint, $type=1, $page, $pageSize, $systemListId, $brandId,$classifyId
		$data = GoodsService::goodsTagLists(
            intval($this->request('systemListId')),
            $this->request('apoint'),
            intval($this->request('type')),
            max((int)$this->request('page'), 1), 
            max((int)$this->request('pageSize'), 20),
				(int)$this->request('secondLevelId'),
				$this->request('brandId'),
				$this->request('classifyId')

        );
		return $this->outputData($data);
	}
}