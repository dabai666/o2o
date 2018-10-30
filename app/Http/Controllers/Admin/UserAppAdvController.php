<?php 
namespace YiZan\Http\Controllers\Admin; 

use View, Input, Form,Lang;

use YiZan\Services\System\AdvService;
use YiZan\Models\System\Adv;

/**
*广告管理
*/
class UserAppAdvController extends AuthController { 

	protected function requestApi($method, $args = [],$data = []){
		!empty($this->clietnType) ? $this->clietnType : $this->clietnType = 'buyer';
        $args['code'] = $this->clietnType;
        return parent::requestApi($method, $args,$data = []);
	} 
	/**
	 * 广告 列表
	*/
	public function index() { 
        $args = Input::all();
		//$args["code"] = "BUYER_INDEX_BANNER";
		$result = $this->requestApi('adv.lists',$args);
//        var_dump($result['data']);die;
		if( $result['code'] == 0)
			View::share('list', $result['data']['list']);
		return $this->display();
	}	
	/**
	 * 添加广告
	*/
	public function create() {
		$positions = $this->requestApi('adv.position.lists',['clientType' => 'buyer']);
        if( $positions['code'] == 0){
            foreach ($positions['data'] as $key => $value) {
                if($value['code'] == 'BUYER_INDEX_MENU'){
                    $positionsId  = $value['id'];
                }
                if($value['code'] == 'BUYER_SELLER_BANNER'){
                    $bsAdvPositionId  = $value['id'];
                }
            }
            View::share('positionsId',$positionsId);
            View::share('bsAdvPositionId',$bsAdvPositionId);
            View::share('positions', $positions['data']);
        }

        //商家分类
        $list = $this->requestApi('seller.cate.catesall');
       // print_r($list);
        if($list['code'] == 0) {
            $sellerCate[] = [
                'id' => 0,
                'name' => '请选择',
                'childs' => [],
            ];
            foreach ($list['data'] as $key => $value) {
                $sellerCate[] = [
                    'id' => $value['id'],
                    'name' => $value['name'],
                    'childs' => $value['childs'],
                ];
            }
            View::share('sellerCate', $sellerCate);
        }

        //商品
        $list = $this->requestApi('system.goods.lists');
       // print_r($list);
        if($list['code'] == 0) {
            $goods[] = [
                'id' => 0,
                'name' => '请选择'
            ];
            foreach ($list['data']['list'] as $key => $value) {
                $goods[] = [
                    'id' => $value['id'],
                    'name' => $value['name'],
                ];
            }
            View::share('service', $goods);
        }

        //文章
        $list = $this->requestApi('article.lists', $args);
        if($list['code'] == 0) {
            View::share('article', $list['data']['list']);
        }

        //品牌
        $data = $this->requestApi('ShopBrand.getList');
        if($data['code'] == 0){
            View::share('shopBrand',$data['data']);
        }
        //开通的城市列表
        $citys = $this->requestApi('city.getcitylists');
        array_unshift($citys['data'], ['id' => 0,'name' => '所有城市']);
        View::share('citys', $citys['data']);
		return $this->display('edit');
	}


	/**
	 * 更新广告
	*/
	public function edit() {
        $args = Input::all();
		$positions = $this->requestApi('adv.position.lists',['clientType' => 'buyer']);
		if( $positions['code'] == 0){
			foreach ($positions['data'] as $key => $value) {
				if($value['code'] == 'BUYER_INDEX_MENU'){
					$positionsId  = $value['id'];
				}
                if($value['code'] == 'BUYER_SELLER_BANNER'){
                    $bsAdvPositionId  = $value['id'];
                }
			}
			View::share('positionsId',$positionsId);
            View::share('bsAdvPositionId',$bsAdvPositionId);
            View::share('positions', $positions['data']);
		}
		$result = $this->requestApi('adv.get',Input::all());
//       dd($result['data']);
//        var_dump(unserialize($result['data']['advSerialize'],true));
        $result['data'] = $result['data']['advSerialize'] ? array_merge($result['data'],unserialize($result['data']['advSerialize'])) : $result['data'];
//        dd($result['data']);
		if($result['code'] == 0 )
           View::share('data', $result['data']);
//        echo '<pre>';
//        print_r($result['data']);exit;

        //商家分类
        $list = $this->requestApi('seller.cate.catesall');
        if($list['code'] == 0) {
            $sellerCate[] = [
                'id' => 0,
                'name' => '请选择',
                'childs' => [],
            ];
            foreach ($list['data'] as $key => $value) {
                $sellerCate[] = [
                    'id' => $value['id'],
                    'name' => $value['name'],
                    'childs' => $value['childs'],
                ];
            }
            View::share('sellerCate', $sellerCate);
        }
      //  print_r($sellerCate);


        //商品
        $list = $this->requestApi('system.goods.lists');
       // print_r($list);
        if($list['code'] == 0) {
            $goods[] = [
                'id' => 0,
                'name' => '请选择'
            ];
            foreach ($list['data']['list'] as $key => $value) {
                $goods[] = [
                    'id' => $value['id'],
                    'name' => $value['name'],
                ];
            }
            View::share('service', $goods);
        }

        //文章
        $list = $this->requestApi('article.lists', $args);
        if($list['code'] == 0) {
            View::share('article', $list['data']['list']);
        }
        //品牌
        $data = $this->requestApi('ShopBrand.getList');
        if($data['code'] == 0){
            View::share('shopBrand',$data['data']);
        }
        //开通的城市列表
        $citys = $this->requestApi('city.getcitylists');
        array_unshift($citys['data'], ['id' => 0,'name' => '所有城市']);
        View::share('citys', $citys['data']);

		return $this->display();
	}
	/**
	 * 更新广告
	*/
	public function update() {
		!empty($this->clietnType) ? $url = ucfirst($this->clietnType) : $url = 'User'; 
		$args = Input::all();

		!empty($args['id']) ?   $args['id']  = intval($args['id'])  :  $args['id'] = 0;
		if($args['id'] > 0 ){//更新操作
            $update['id'] = $args['id'];
            $update['name'] = $args['name'];//广告名称
            $update['positionId'] = $args['positionId'];//广告位编号
            $update['cityId'] = $args['cityId'];//城市编号
            $update['flage'] = $args['flage'];//用于标志是单一广告或3+1广告
            $update['createTime'] = UTC_TIME;
            $update['sort'] = $args['sort'];//排序
            $update['status'] = $args['status'];//状态


            if($args['flage']==0){
                $update['sellerCateId'] = $args['sellerCateId'];//商家分类
                $update['bgColor'] = $args['bgColor'];//背景颜色
                $update['image'] = $args['image'];//单个广告的图片
                $update['type'] = $args['type'];//广告链接类型
                //链接参数
                if($args['type']==1){//商家分类
                    $update['arg'] = $args['sellerCate'];//选择商家分类的ID
                }elseif($args['type']==3){//普通商品
                    $update['arg'] = $args['sellerGoods'];//商品编号参数
                }elseif($args['type']==4){//商家
                    $update['arg'] = $args['systemSellers'];//商家编号参数
                }elseif($args['type']==5){//自定义URL
                    $update['arg'] = $args['url'];//输入的路径
                }elseif($args['type']==6){//服务商品
                    $update['arg'] = $args['serviceGoods'];//服务编号参数
                }elseif($args['type']==7){//文章
                    $update['arg'] = $args['article'];//选择的文章
                }elseif($args['type']==13){
                    $update['arg'] = $args['activityId'];//选择的文章
                }else{//其它
                    $update['arg'] = '';
                }
            }elseif($args['flage'] == 2){
                $adv_serialize = range(0,11);
                $_serialize = array();
                foreach($adv_serialize as $k){
                    if(!$args['img'.$k]){
                        return $this->error($data['msg']='请上传图片','',$args);
                    }
                    $_serialize['img'.$k] = $args['img'.$k];
                    $_serialize['brandId'.$k] = $args['brandId'.$k];
                }
                $update['advSerialize'] = $_serialize;
                $data = $this->requestApi('adv.update1',$update);
                if( $data['code'] == 0 ) {
                    if(!empty($this->WapModuletype)){
                        return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('WapModule/create'));
                    }else{
                        return $this->success($data['msg'] ? $data['msg'] : '更新成功',u('UserAppAdv/index'));
                    }
                } else {
                    return $this->error($data['msg'] ? $data['msg'] : '更新失败','',$args);
                }
            }else{ //1+3广告位
                //顶部广告位
				
                $update['image1'] = $args['image1'];
                $update['type1'] = $args['type1'];

                if ($args['type1'] == 1) {
                    $update['arg1'] = $args['sellerCate1'];
                } elseif ($args['type1'] == 3) {
                    $update['arg1'] = $args['sellerGoods1'];
                } elseif ($args['type1'] == 4) {
                    $update['arg1'] = $args['systemSellers1'];
                } elseif ($args['type1'] == 5) {
                    $update['arg1'] = $args['url1'];
                } elseif ($args['type1'] == 6) {
                    $update['arg1'] = $args['serviceGoods1'];
                } elseif ($args['type1'] == 7) {
                    $update['arg1'] = $args['article1'];
                }elseif ($args['type1'] == 13) {
                    $update['arg1'] = $args['activityId1'];
                } else {
                    $update['arg1'] = '';
                }


                //第一广告位
                $update['image2'] = $args['image2'];
                $update['type2'] = $args['type2'];

                if ($args['type2'] == 1) {
                    $update['arg2'] = $args['sellerCate2'];
                } elseif ($args['type2'] == 3) {
                    $update['arg2'] = $args['sellerGoods2'];
                } elseif ($args['type2'] == 4) {
                    $update['arg2'] = $args['systemSellers2'];
                } elseif ($args['type2'] == 5) {
                    $update['arg2'] = $args['url2'];
                } elseif ($args['type2'] == 6) {
                    $update['arg2'] = $args['serviceGoods2'];
                } elseif ($args['type2'] == 7) {
                    $update['arg2'] = $args['article2'];
                }elseif ($args['type2'] == 13) {
                    $update['arg2'] = $args['activityId2'];
                } else {
                    $update['arg2'] = '';
                }


                //第二广告位
                $update['image3'] = $args['image3'];
                $update['type3'] = $args['type3'];

                if ($args['type3'] == 1) {
                    $update['arg3'] = $args['sellerCate3'];
                } elseif ($args['type3'] == 3) {
                    $update['arg3'] = $args['sellerGoods3'];
                } elseif ($args['type3'] == 4) {
                    $update['arg3'] = $args['systemSellers3'];
                } elseif ($args['type3'] == 5) {
                    $update['arg3'] = $args['url3'];
                } elseif ($args['type3'] == 6) {
                    $update['arg3'] = $args['serviceGoods3'];
                } elseif ($args['type3'] == 7) {
                    $update['arg3'] = $args['article3'];
                }elseif ($args['type3'] == 13) {
                    $update['arg3'] = $args['activityId3'];
                } else {
                    $update['arg3'] = '';
                }

                //第三广告位
                $update['image4'] = $args['image4'];
                $update['type4'] = $args['type4'];

                if ($args['type4'] == 1) {
                    $update['arg4'] = $args['sellerCate4'];
                } elseif ($args['type4'] == 3) {
                    $update['arg4'] = $args['sellerGoods4'];
                } elseif ($args['type4'] == 4) {
                    $update['arg4'] = $args['systemSellers4'];
                } elseif ($args['type4'] == 5) {
                    $update['arg4'] = $args['url4'];
                } elseif ($args['type4'] == 6) {
                    $update['arg4'] = $args['serviceGoods4'];
                } elseif ($args['type4'] == 7) {
                    $update['arg4'] = $args['article4'];
                }elseif ($args['type4'] == 13) {
                    $update['arg4'] = $args['activityId4'];
                } else {
                    $update['arg4'] = '';
                }
                $update['title2'] = $args['title2'];
                $update['instruction2'] = $args['instruction2'];
                $update['instruction2Bg'] = $args['instruction2Bg'];
                $update['sign2'] = $args['sign2'];
                $update['mark2'] = $args['mark2'];
                $update['remarks2'] = $args['remarks2'];

                $update['title3'] = $args['title3'];
                $update['instruction3'] = $args['instruction3'];
                $update['instruction3Bg'] = $args['instruction3Bg'];
				$update['sign3'] = $args['sign3'];
                $update['mark3'] = $args['mark3'];
                $update['remarks3'] = $args['remarks3'];

                $update['title4'] = $args['title4'];
                $update['instruction4'] = $args['instruction4'];
                $update['instruction4Bg'] = $args['instruction4Bg'];
				$update['sign4'] = $args['sign4'];
                $update['mark4'] = $args['mark4'];
                $update['remarks4'] = $args['remarks4'];
            }

//            print_r($update);exit;

			$data = $this->requestApi('adv.update',$update);
			if( $data['code'] == 0 ) {
				if(!empty($this->WapModuletype)){
					return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('WapModule/edit',[ 'id'=>$args['id'] ]));
				}else{
					return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('UserAppAdv/edit',[ 'id'=>$args['id'] ]));
				}
			}
			else {
				return $this->error($data['msg'] ? $data['msg'] : $data['msg']=Lang::get('admin.code.98004'),'',$args);
			}
		}else{ //添加操作
            $insert['name'] = $args['name'];//广告名称
            $insert['positionId'] = $args['positionId'];//广告位编号
            $insert['cityId'] = $args['cityId'];//城市编号
            $insert['flage'] = (int)$args['flage'];//用于标志是单一广告或3+1广告
            $insert['createTime'] = UTC_TIME;
            $insert['sort'] = $args['sort'];//排序
            $insert['status'] = $args['status'];//状态
            if($args['flage']==0){
                $insert['sellerCateId'] = $args['sellerCateId'];//商家分类
                $insert['bgColor'] = $args['bgColor'];//背景颜色
                $insert['image'] = $args['image'];//单个广告的图片
                $insert['type'] = $args['type'];//广告链接类型
                //链接参数
                if($args['type']==1){//商家分类
                    $insert['arg'] = $args['sellerCate'];//选择商家分类的ID
                }elseif($args['type']==3){//普通商品
                    $insert['arg'] = $args['sellerGoods'];//商品编号参数
                }elseif($args['type']==4){//商家
                    $insert['arg'] = $args['systemSellers'];//商家编号参数
                }elseif($args['type']==5){//自定义URL
                    $insert['arg'] = $args['url'];//输入的路径
                }elseif($args['type']==6){//服务商品
                    $insert['arg'] = $args['serviceGoods'];//服务编号参数
                }elseif($args['type']==7){//文章
                    $insert['arg'] = $args['article'];//选择的文章
                }elseif($args['type']==13){//文章
                    $insert['arg'] = $args['activityId'];//选择的文章
                }else{//其它
                    $insert['arg'] = '';
                }
            }elseif($args['flage'] == 2){
                $adv_serialize = range(0,7);
                $_serialize = array();
                foreach($adv_serialize as $k){
                    if(!$args['img'.$k]){
                        return $this->error($data['msg']='请上传图片','',$args);
                    }
                    $_serialize['img'.$k] = $args['img'.$k];
                    $_serialize['brandId'.$k] = $args['brandId'.$k];
                }
                $insert['advSerialize'] = $_serialize;
                $data = $this->requestApi('adv.create1',$insert);
                if( $data['code'] == 0 ) {
                    if(!empty($this->WapModuletype)){
                        return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('WapModule/create'));
                    }else{
                        return $this->success($data['msg'] ? $data['msg'] : '添加成功',u('UserAppAdv/index'));
                    }
                } else {
                    return $this->error($data['msg'] ? $data['msg'] : '添加失败','',$args);
                }
            }else{  //1+3广告位
                //顶部广告位
                $insert['image1'] = $args['image1'];
                $insert['type1'] = $args['type1'];

                if ($args['type1'] == 1) {
                    $insert['arg1'] = $args['sellerCate1'];
                } elseif ($args['type1'] == 3) {
                    $insert['arg1'] = $args['sellerGoods1'];
                } elseif ($args['type1'] == 4) {
                    $insert['arg1'] = $args['systemSellers1'];
                } elseif ($args['type1'] == 5) {
                    $insert['arg1'] = $args['url1'];
                } elseif ($args['type1'] == 6) {
                    $insert['arg1'] = $args['serviceGoods1'];
                } elseif ($args['type1'] == 7) {
                    $insert['arg1'] = $args['article1'];
                }elseif ($args['type1'] == 13) {
                    $insert['arg1'] = $args['activityId1'];
                } else {
                    $insert['arg1'] = '';
                }

                //第一广告位
                $insert['image2'] = $args['image2'];
                $insert['type2'] = $args['type2'];

                if ($args['type2'] == 1) {
                    $insert['arg2'] = $args['sellerCate2'];
                } elseif ($args['type2'] == 3) {
                    $insert['arg2'] = $args['sellerGoods2'];
                } elseif ($args['type2'] == 4) {
                    $insert['arg2'] = $args['systemSellers2'];
                } elseif ($args['type2'] == 5) {
                    $insert['arg2'] = $args['url2'];
                } elseif ($args['type2'] == 6) {
                    $insert['arg2'] = $args['serviceGoods2'];
                } elseif ($args['type2'] == 7) {
                    $insert['arg2'] = $args['article2'];
                } elseif ($args['type2'] == 13) {
                    $insert['arg2'] = $args['activityId2'];
                }else {
                    $insert['arg2'] = '';
                }

                //第二广告位
                $insert['image3'] = $args['image3'];
                $insert['type3'] = $args['type3'];

                if ($args['type3'] == 1) {
                    $insert['arg3'] = $args['sellerCate3'];
                } elseif ($args['type3'] == 3) {
                    $insert['arg3'] = $args['sellerGoods3'];
                } elseif ($args['type3'] == 4) {
                    $insert['arg3'] = $args['systemSellers3'];
                } elseif ($args['type3'] == 5) {
                    $insert['arg3'] = $args['url3'];
                } elseif ($args['type3'] == 6) {
                    $insert['arg3'] = $args['serviceGoods3'];
                } elseif ($args['type3'] == 7) {
                    $insert['arg3'] = $args['article3'];
                } elseif ($args['type3'] == 13) {
                    $insert['arg3'] = $args['activityId3'];
                }else {
                    $insert['arg3'] = '';
                }

                //第三广告位
                $insert['image4'] = $args['image4'];
                $insert['type4'] = $args['type4'];

                if ($args['type4'] == 1) {
                    $insert['arg4'] = $args['sellerCate4'];
                } elseif ($args['type4'] == 3) {
                    $insert['arg4'] = $args['sellerGoods4'];
                } elseif ($args['type4'] == 4) {
                    $insert['arg4'] = $args['systemSellers4'];
                } elseif ($args['type4'] == 5) {
                    $insert['arg4'] = $args['url4'];
                } elseif ($args['type4'] == 6) {
                    $insert['arg4'] = $args['serviceGoods4'];
                } elseif ($args['type4'] == 7) {
                    $insert['arg4'] = $args['article4'];
                }elseif ($args['type4'] == 13) {
                    $insert['arg4'] = $args['activityId4'];
                } else {
                    $insert['arg4'] = '';
                }
				$update['title2'] = $args['title2'];
                $update['instruction2'] = $args['instruction2'];
                $update['instruction2Bg'] = $args['instruction2Bg'];
                $update['sign2'] = $args['sign2'];
                $update['mark2'] = $args['mark2'];
                $update['remarks2'] = $args['remarks2'];

                $update['title3'] = $args['title3'];
                $update['instruction3'] = $args['instruction3'];
                $update['instruction3Bg'] = $args['instruction3Bg'];
				$update['sign3'] = $args['sign3'];
                $update['mark3'] = $args['mark3'];
                $update['remarks3'] = $args['remarks3'];

                $update['title4'] = $args['title4'];
                $update['instruction4'] = $args['instruction4'];
                $update['instruction4Bg'] = $args['instruction4Bg'];
				$update['sign4'] = $args['sign4'];
                $update['mark4'] = $args['mark4'];
                $update['remarks4'] = $args['remarks4'];
				
            }
            $data = $this->requestApi('adv.create',$insert);
            if( $data['code'] == 0 ) {
                if(!empty($this->WapModuletype)){
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('WapModule/create'));
                }else{
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('UserAppAdv/index'));
                }
            } else {
                return $this->error($data['msg'] ? $data['msg'] : $data['msg']=Lang::get('admin.code.98002'),'',$args);
            }
//            print_r($insert);exit;
		}  
	}
	/**
	 * 广告状态设置
	*/
	public function setstatus() {
		!empty($this->clietnType) ? $url = ucfirst($this->clietnType) : $url = 'User'; 
		$data = $this->requestApi('adv.setstatus', Input::all());
		if( $data['code'] == 0 ) {
			if(!empty($this->WapModuletype)){ 
				return $this->success($data['msg'] ,u('WapModule/create'), $data['data']);
			}else{
				return $this->success($data['msg'], u('UserAppAdv.index'), $data['data']);
			}
		}
		else {
			return $this->error($data['msg'], '', $data['data']);
		}
	} 
	/**
	 * 删除广告
	*/
	public function destroy() {
		!empty($this->clietnType) ? $url = ucfirst($this->clietnType) : $url = 'User';
        $args = Input::all();
        $id = (int)Input::get('id');
        if (empty($id)) {
			return $this->error(Lang::get('admin.noId'),u('UserAppAdv/index'));
		}
		$args['id']  = $id;
		$data = $this->requestApi('adv.delete',$args);
		if( $data['code'] > 0 ) {
			return $this->error($data['msg'], '');
		}
		if(!empty($this->WapModuletype)){
			return $this->success($data['msg'] ,u('WapModule/index'), $data['data']);
		}else{
			return $this->success($data['msg'], u('UserAppAdv/index'), $data['data']);
		}
	} 
	
	//获取分类
	public function getcate() {
		$result = $this->requestApi('goods.cate.lists');
		if($result['code']==0)
			$this->generateTree(0,$result['data']);

		//生成树形
		$cate = $this->_cates;
		return $cate;
	}
    //获取分类
	public function getarticle() {
		$result = $this->requestApi('article.cate.lists');
		if($result['code']==0) {
			$this->generateTree(0,$result['data']);
		}
		//生成树形
		$cate = $this->_cates;
		return $cate;
	}
}
