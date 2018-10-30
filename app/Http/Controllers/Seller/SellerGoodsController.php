<?php 
namespace YiZan\Http\Controllers\Seller;

use YiZan\Models\Goods;
use YiZan\Models\Seller;
use View, Input, Lang, Route, Page, Validator, Session, Response,Redirect;
/**
 * 商品
 */
class SellerGoodsController extends AuthController {
	/**
	 * 服务管理-商品列表
	 */
	public function index() {
		$args = Input::all();
		$args['type'] = $option['type'] = Goods::SELLER_GOODS;
		$result = $this->requestApi('goods.lists', $args);
		if( $result['code'] == 0 ){
			View::share('list', $result['data']['list']);
		} 
        $result_cate = $this->requestApi('goods.cate.lists',$option);    
        View::share('cate', $result_cate['data']); 
		View::share('excel',http_build_query($args));

        //获取标签分类
        $systemTag = $this->requestApi('SystemTag.getSystemTag');
        $systemTag = $systemTag['data'];
        $systemTag1 = [
            'id' => 0,
            'name' => "请选择",
            'systemTagList' => '',
        ];
        array_unshift($systemTag,$systemTag1);
        View::share('systemTag', $systemTag);

        //获取标签列表（一级）
//        $tagList = $this->requestApi('systemTagList.lists', ['status'=>1]);
//        $tagList = $tagList['data'];
//        $tagList2 = [
//            "id" => 0,
//            "pid" => 0,
//            "name" => "请选择",
//            "sort" => 100,
//            "status" => 1,
//            "level" => 0,
//            "levelname" => ""
//        ];
//        array_unshift($tagList,$tagList2);
//        View::share('systemTagListPid', $tagList);

		return $this->display();
	}

	/**
	 * 服务审核
	 */
	public function audit() {
		$post = Input::all();
        
		$args['status'] = [\YiZan\Models\Base::STATUS_NOT_BY, \YiZan\Models\Base::STATUS_AUDITING];
        
        
        switch(Input::get("status"))
        {
            case "1":
                $args['status'] = [\YiZan\Models\Base::STATUS_NOT_BY];
                break;
                
            case "2":
                $args['status'] = [\YiZan\Models\Base::STATUS_AUDITING];
                break;
            
            default:
                $args['status'] = [\YiZan\Models\Base::STATUS_NOT_BY, \YiZan\Models\Base::STATUS_AUDITING];
                break;
        }
            
		!empty($post['name']) 	?  $args['name']  	= strval($post['name']) 	: null;
		!empty($post['page']) 	?  $args['page'] 	= intval($post['page']) 	: $args['page'] = 1;
		$result = $this->requestApi('goods.lists', $args);
		if($result['code']==0)
			View::share("list",$result['data']['list']);
		$_cate = $this->getcate();
		$cate = [];
		foreach ($_cate as $key => $value) {
			$cate[$value['id']] = $value;
		}
		View::share('cate', $cate);
		return $this->display();
	}

	/**
	 * 服务审核进度
	 */
	public function auditplan() {
		$args = Input::all();
		if( isset($args['id']) ) {
			//View::share('data',$result['data']);
		}
		return $this->display();
	}

	/**
	 * 添加服务(取消)
	 */
	public function addgoods() {
		return $this->display();
	}

	/**
	 * 服务种类须知
	 */
	public function quickchoose(){
		$type = (int)Input::get('type');
		$args['name'] = Input::get('name'); 
		$args['page'] = (int)Input::get('page') > 1 ? (int)Input::get('page') : 1; 
		$result = $this->requestApi('system.goods.lists',$args); 
		if( $result['code'] == 0 ){
			View::share('list', $result['data']['list']);
		}
		if($type==0){
			$args['type'] = 1;
		} else {
			$args['type'] = 0;
		}
		View::share('args',$args);
		if($type > 0){
			return $this->display('textchoose');
		}
		return $this->display();	
	} 

	/**
	 * 添加新服务
	 */
	public function create() {
        $brand = $this->requestApi('goods.getShopBrand');
        if(!count($brand['data'])){
            $brand['data'][0] = ['id'=>0, 'name'=>'请选择'];
        }
        View::share('brand', $brand['data']);

        $result_cate = $this->requestApi('goods.cate.lists',['type'=>Goods::SELLER_GOODS,'flage'=>true]);
        if(!count($result_cate['data']))
		{
			$result_cate['data'][0] = ['id'=>0, 'name'=>'请选择'];
		}
//        var_dump($result_cate['data']);die;
        View::share('cate', $result_cate['data']);
		//获取标签分类
		$systemTag = $this->requestApi('SystemTag.getSystemTag');
		$systemTag = $systemTag['data'];
		$systemTag1 = [
			'id' => 0,
			'name' => "请选择",
			'systemTagList' => '',
		];
		array_unshift($systemTag,$systemTag1);
		View::share('systemTag', $systemTag);

        //获取标签列表（一级）
        // $tagList = $this->requestApi('systemTagList.lists');
        // $tagList = $tagList['data'];
         $tagList2 = [
             "id" => 0,
             "pid" => 0,
             "name" => "请选择",
             "sort" => 100,
             "status" => 1,
             "level" => 0,
             "levelname" => ""
         ];
        // array_unshift($tagList,$tagList2);
        // View::share('systemTagListPid', $tagList);

        //获取标签列表（二级）
        $tagList3 = $this->requestApi('systemTagList.secondLevel');//, ['pid'=>$result_cate['data']['systemTagListPid']]
        $tagList3 = $tagList3['data'];
        array_unshift($tagList3,$tagList2);
        View::share('systemTagListId', $tagList3);

        //获取商家是否是全国店
        $seller = $this->requestApi('user.get', ['id'=>$args['sellerId']]);
        View::share('storeType', $seller['data']['storeType']);

		//【分销平台】全国店获取分销模式
		if(FANWEFX_SYSTEM && $seller['data']['storeType'] == 1)
		{
			//获取分销模式，分销通道
			$passageId = \YiZan\Http\Controllers\Admin\FxController::get_enabled_passages();
			//获取分销方案
			$schemeId = \YiZan\Http\Controllers\Admin\FxController::query_commission_schemes();

			View::share('passageId', $passageId);
			View::share('schemeId', $schemeId);
			View::share('fx', true);
		}

		return $this->display('edit');
	}

	/**
	 * 编辑服务
	 */
	public function edit() {
        $brand = $this->requestApi('goods.getShopBrand');
        if(!count($brand['data'])){
            $brand['data'][0] = ['id'=>0, 'name'=>'请选择'];
        }
        View::share('brand', $brand['data']);

        $result_cate = $this->requestApi('goods.cate.lists',['type'=>Goods::SELLER_GOODS,'flage'=>true]);
        View::share('cate', $result_cate['data']); 

		$args['goodsId'] = Input::get('id');
		$result = $this->requestApi('goods.get',$args);
//        var_dump($result['data']);die;
 		View::share('data', $result['data']);
		//获取标签分类
		$systemTag = $this->requestApi('SystemTag.getSystemTag');
		$systemTag = $systemTag['data'];
		$systemTag1 = [
			'id' => 0,
			'name' => "请选择",
			'systemTagList' => '',
		];
		array_unshift($systemTag,$systemTag1);
		View::share('systemTag', $systemTag);
		
		//通过一级标签获取标签分类
		foreach($systemTag as $key => $val){
			foreach($val['systemTagList'] as $k => $v){
				if($v['id'] == $result['data']['systemTagListPid']){
					$systemTagId = $val['id'];
					View::share('systemTagId', $systemTagId);
				}
			}
		}
		
 		//获取标签列表（一级）
        $tagList = $this->requestApi('systemTagList.lists');
        $tagList = $tagList['data'];
        $tagList2 = [ 
            "id" => 0,
            "pid" => 0,
            "name" => "请选择",
            "sort" => 100,
            "status" => 1,
            "level" => 0,
            "levelname" => ""
        ];
        array_unshift($tagList,$tagList2);
        View::share('systemTagListPid', $tagList);

        //获取标签列表（二级）
        $tagList3 = $this->requestApi('systemTagList.secondLevel', ['pid'=>$result['data']['systemTagListPid']]);
        $tagList3 = $tagList3['data'];
        array_unshift($tagList3,$tagList2);
        View::share('systemTagListId', $tagList3);
        
        //获取商家是否是全国店
        $seller = $this->requestApi('user.get', ['id'=>$args['sellerId']]);
        View::share('storeType', $seller['data']['storeType']);

        //【分销平台】全国店获取分销模式
        if(FANWEFX_SYSTEM && $seller['data']['storeType'] == 1)
        {
            //获取分销模式，分销通道
            $passageId = \YiZan\Http\Controllers\Admin\FxController::get_enabled_passages();
            //获取分销方案
            $schemeId = \YiZan\Http\Controllers\Admin\FxController::query_commission_schemes();

            View::share('passageId', $passageId);
            View::share('schemeId', $schemeId);
            View::share('fx', true);
        }
        
		return $this->display();
	}



	//获取分类
	public function getcate() {
		$result = $this->requestApi('goods.cate.lists',array('flage'=>true));
		if($result['code']==0) {
			$this->generateTree(0,$result['data']);
		}
		//生成树形
		$cate = $this->_cates;
		return $cate;
	}

	public function save() {
		$args = Input::all();
		$norms['ids'] =  $args['_id'];
		$norms['names'] =  $args['_name'];
		$norms['prices'] = $args['_price'];
		$norms['stocks'] = $args['_stock'];
        $norms['sale_price'] = $args['_salePrice'];
        $norms['weight'] = $args['_weight'];
		$args['norms'] = json_encode($norms); 
		$args['type'] = Goods::SELLER_GOODS;
        $args['_id1'] = $args['_idone'];
//        var_dump($args);
		if( $args['id'] > 0 ){
			$result = $this->requestApi('goods.update',$args);
			$msg = Lang::get('seller.code.98003');
		}
		else{
			$result = $this->requestApi('goods.create',$args);
			$msg = Lang::get('seller.code.98001');
		}

		if( $result['code'] > 0 ) {
			return $this->error($result['msg']);
		}
        $url = u('SellerGoods/index',['cateId' => $args['cateId'],'page' => $args['listPage']]);

		return $this->success($msg, $url);
	}

	public function destroy() {
		$args['id'] = explode(',', Input::get('id'));
		$result = $this->requestApi('goods.delete',$args);
		if( $result['code'] > 0 ) {
			return $this->error($result['msg']);
		}
		return $this->success(Lang::get('seller.code.98005'), u('SellerGoods/index'), $result['data']);
	}

    public function updateStatus() {
        $args = Input::all();
        $result = $this->requestApi('goods.updateStatus',$args);
        return Response::json($result);
    }

    /**
     *  通用服务
     * */
    public function goodsedit() {
        $args = Input::all();
        $brand = $this->requestApi('goods.getShopBrand');
        if(!count($brand['data'])){
            $brand['data'][0] = ['id'=>0, 'name'=>'请选择'];
        }
        View::share('brand', $brand['data']);
        $result_cate = $this->requestApi('goods.cate.lists',['type'=>1,'flage'=>true]);
        View::share('cate', $result_cate['data']);

        $result = $this->requestApi('system.goods.get', $args);
        if ($result['code'] == 0)
            View::share('data', $result['data']);
		//获取标签分类
		$systemTag = $this->requestApi('SystemTag.getSystemTag');
		$systemTag = $systemTag['data'];
		$systemTag1 = [
			'id' => 0,
			'name' => "请选择",
			'systemTagList' => '',
		];
		array_unshift($systemTag,$systemTag1);
		View::share('systemTag', $systemTag);
		
		//通过一级标签获取标签分类
		foreach($systemTag as $key => $val){
			foreach($val['systemTagList'] as $k => $v){
				if($v['id'] == $result['data']['systemTagListPid']){
					$systemTagId = $val['id'];
					View::share('systemTagId', $systemTagId);
				}
			}
		}
		
        //获取标签列表（一级）
        $tagList = $this->requestApi('systemTagList.lists');
        $tagList = $tagList['data'];
        $tagList2 = [
            "id" => 0,
            "pid" => 0,
            "name" => "请选择",
            "sort" => 100,
            "status" => 1,
            "level" => 0,
            "levelname" => ""
        ];
        array_unshift($tagList,$tagList2);
        View::share('systemTagListPid', $tagList);
        //获取标签列表（二级）
        $tagList3 = $this->requestApi('systemTagList.secondLevel', ['pid'=>$result['data']['systemTagListPid']]);
        $tagList3 = $tagList3['data'];
        array_unshift($tagList3,$tagList2);
        View::share('systemTagListId', $tagList3);


        View::share('systemgoodssave', "systemgoodssave");

        return $this->display('edit');
    }
	/**
	* 一键导入商品库 检查
	*/
	public function oneChannelCk(){
		$args = Input::all();
        $result = $this->requestApi('system.goods.oneChannelCk', $args);
        return Response::json($result);
	}
	
	/**
	* 一键导入商品库 执行
	*/
	public function oneChannel(){
		$args = Input::all();
        $result = $this->requestApi('system.goods.oneChannel', $args);
        return Response::json($result);
	}
    /**
     * 保存通用服务
     */
    public function systemgoodssave() {
        $args = Input::all();
        $norms['ids'] =  $args['_id'];
        $norms['names'] =  $args['_name'];
        $norms['prices'] = $args['_price'];
        $norms['stocks'] = $args['_stock'];
        $args['norms'] = json_encode($norms);
        $args['type'] = Goods::SELLER_GOODS;
        $args['systemGoodsId'] =  $args['id'];
        $norms['sale_price'] = $args['_salePrice'];
        $norms['weight'] = $args['_weight'];
        $args['_id1'] = $args['_idone'];
        unset( $args['id']);
        $result = $this->requestApi('goods.create',$args);

        if( $result['code'] > 0 ) {
            return $this->error($result['msg']);
        }
        return $this->success("添加通用商品成功", u('SellerGoods/index'));
    }

    public function systemtagshow() {
        $args = Input::all();
        return  Redirect::to(u('SellerGoods/systemgoods',$args))->send();
    }


    /**
     *  通用服务
     * */
    public function systemgoods() {
        $args = Input::all();
        $result = $this->requestApi('system.goods.lists', $args);
        if ($result['code'] == 0){
            View::share('list', $result['data']['list']);
            $result_cate = $this->requestApi('goods.cate.lists',['type'=>Goods::SELLER_GOODS]);
            if(!count($result_cate['data']))
            {
                $result_cate['data'][0] = ['id'=>0, 'name'=>'请选择'];
            }
		}
        //获取标签分类
        $systemTag = $this->requestApi('SystemTag.getSystemTag');
        $systemTag = $systemTag['data'];
        $systemTag1 = [
            'id' => 0,
            'name' => "请选择",
            'systemTagList' => '',
        ];
        array_unshift($systemTag,$systemTag1);
        View::share('systemTag', $systemTag);

        //通过一级标签获取标签分类
        foreach($systemTag as $key => $val){
            foreach($val['systemTagList'] as $k => $v){
                if($v['id'] == $args['systemTagListPid']){
                    $systemTagId = $val['id'];
                    View::share('systemTagId', $systemTagId);
                }
            }
        }

        //获取标签列表（一级）
        $tagList = $this->requestApi('systemTagList.lists');
        $tagList = $tagList['data'];
        $tagList2 = [
            "id" => 0,
            "pid" => 0,
            "name" => "请选择",
            "sort" => 100,
            "status" => 1,
            "level" => 0,
            "levelname" => ""
        ];
        array_unshift($tagList,$tagList2);
        View::share('systemTagListPid', $tagList);

        //获取标签列表（二级）
        $tagList3 = $this->requestApi('systemTagList.secondLevel', ['pid'=>$args['systemTagListPid']]);
        $tagList3 = $tagList3['data'];
        array_unshift($tagList3,$tagList2);
        View::share('systemTagListId', $tagList3);

//        $brand = $this->requestApi('goods.getShopBrand');
//        if(!count($brand['data'])){
//            $brand['data'][0] = ['id'=>0, 'name'=>'请选择'];
//        }
//        View::share('brand', $brand['data']);
        View::share('cate', $result_cate['data']);
        View::share('args', $args);
        View::share('searchUrl', u('SellerGoods/systemgoods', $args));

        return $this->display();
    }

    //商品名检测重复
    public function goodsNameTest(){
        $args = Input::all();
        $seller = Session::get('seller');
        $args['sellerid'] = $seller['id'];
        $result = $this->requestApi('goods.nameTest', $args);
        return $result;
    }
}
