<?php namespace YiZan\Http\Controllers\Wap;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use View, Input, Redirect, Response, Session;

class TagController extends BaseController {
	public function __construct() {
		parent::__construct();
		View::share('nav','tag');
	}

    public function index(){
        $option = Input::all();
        $tagList = $this->requestApi('SystemTag.getSystemTag');
        $data = $tagList['data'];
        View::share('tagList',$data);//分类

        $defaultAddress = Session::get("defaultAddress");
        if(!empty($defaultAddress)){
            //判断该城市是否开通
            $is_service =  $this->requestApi('user.address.getisservice',['cityId'=>$defaultAddress['cityId']]);
        }else{
            $option['apoint'] = $defaultAddress['mapPointStr'];
        }
        View::share("cityIsService", 1);

        $goodsArgs['apoint'] = $defaultAddress['mapPointStr'];
        $goodsArgs['systemListId'] = $data[0]['id'] ? $data[0]['id'] : 0;
        $goodsArgs['type'] = $option['type'];
        $goodsArgs['page'] = $option['page'];
        $lists =  $this->requestApi('goods.goodstaglists',$goodsArgs);
        $list = $lists['data'];
file_put_contents(base_path().'/storage/logs/list.log', print_r($list, true), FILE_APPEND);
        View::share('lists',$list);
        $list = $this->requestApi('SystemTag.setBrandAndClassfy',$goodsArgs);
        if($list['code'] == 0){
            View::share('brandList',$list['data']['brandList']);
            View::share('classifyList',$list['data']['classifyList']);
        }
        return $this->display('index1');
    }
	public function index2() {
        $option = Input::all();
        $is_service = [];
        $is_service['data'] = 1;
        $defaultAddress = Session::get("defaultAddress");
        if(!empty($defaultAddress)){
            //判断该城市是否开通
            $is_service =  $this->requestApi('user.address.getisservice',['cityId'=>$defaultAddress['cityId']]);
        }else{
            $option['apoint'] = $defaultAddress['mapPointStr'];
        }
        View::share("cityIsService", $is_service['data']);

        //分类
        //用户端只查询未锁定的分类
        $args = ['status'=>1];
        $data = [];

        $data = Cache::get('tagindex');
        if(empty($data)){
            $firstLevel = array();
            $secondLevel = array();
            $threeLevel = array();
            $result = $this->requestApi('systemTag.lists1',$args);
            foreach($result['data'] as $k => $v){
                if(isset($v['tag']) && is_array($v['tag'])){
                    if(!in_array($v['tag']['id'],$firstLevel)){
                        $firstLevel[$v['tag']['id']] = $v['tag'];
                    }
                }
                if($v['pid'] == 0){
                    if(!in_array($v['id'],$secondLevel)){
                        $secondLevel[$v['id']] = $v;
                    }
                }else{
                    if(!in_array($v['id'],$threeLevel)){
                        $threeLevel[$v['id']] = array(
                            'id' => $v['id'],
                            'pid' => $v['pid'],
                            'name' => $v['name'],
                            'systemTagId'=>$v['systemTagId']
                        );
                    }
                }
            }
            foreach($threeLevel as $key => $value){
                if(!$data[$value['systemTagId']]){
                    $data[$value['systemTagId']] = $firstLevel[$value['systemTagId']];
                }
                if(!$data[$value['systemTagId']]['secondLevel'][$value['pid']]){
                    $data[$value['systemTagId']]['secondLevel'][$value['pid']] = $secondLevel[$value['pid']];
                }
            }
            $data = array_values($data);//键值从零开始
//            Cache::put('tagindex',$data,5);
        }
        if($data){
            $option['page'] = 1;
            $option['firstLevelId'] = $data[0]['id'] ? $data[0]['id'] : 0;
            $option['secondLevelId'] = -1;

            $address = Session::get("defaultAddress");
            $goodsArgs['apoint'] = $address['mapPointStr'];
            $goodsArgs['systemListId'] = $data[0]['id'] ? $data[0]['id'] : 0;
            $goodsArgs['type'] = $args['type'];
            $goodsArgs['page'] = $args['page'];
            $lists =  $this->requestApi('goods.goodstaglists',$goodsArgs);
            if($lists['code'] == 0)
            {
                View::share('lists', $lists['data']);
            }
            $result = $this->requestApi('SystemTag.setBrandAndClassfy',$goodsArgs);
            if($result['code'] == 0){
                View::share('brandList', $result['data']['brandList']);
                View::share('classifyList', $result['data']['classifyList']);
            }
        }
        View::share('data', $data);
        View::share('nav_back_url', $_SERVER["HTTP_REFERER"]);
        return $this->display('index1');
	}

    //备份
    public function index1() {
        $is_service = [];
        $is_service['data'] = 1;
        $defaultAddress = Session::get("defaultAddress");
        if(!empty($defaultAddress)){
            //判断该城市是否开通
            $is_service =  $this->requestApi('user.address.getisservice',['cityId'=>$defaultAddress['cityId']]);
        }
        View::share("cityIsService", $is_service['data']);

        //分类
        //用户端只查询未锁定的分类
        $args = ['status'=>1];
        $data = [];

        $data = Cache::get('tagindex');
        if(empty($data)){
            $result = $this->requestApi('systemTag.lists',$args);
            while (count($result['data']) > 0) {
                $value = array_shift($result['data']);
                if($value['pid'] == 0)
                {
                    //  一级分类
                    $data[$value['id']]['name'] = $value['name'];
                    $data[$value['id']]['id'] = $value['id'];
                    $data[$value['id']]['sort'] = $value['sort'];
                }
                else{
                    //二级分类
                    if($value['tag']['id'] > 0)
                    {
                        //存在二级分类标签
                        if(!$data[$value['pid']]['twoLevel'][$value['tag']['id']])
                        {
                            $data[$value['pid']]['twoLevel'][$value['tag']['id']]['name'] = $value['tag']['name'];
                        }

                        //三级分类
                        $data[$value['pid']]['twoLevel'][$value['tag']['id']]['threeLevel'][$value['id']] = $value;
                        unset($data[$value['pid']]['twoLevel'][$value['tag']['id']]['threeLevel'][$value['id']]['tag']);
                        unset($data[$value['pid']]['twoLevel'][$value['tag']['id']]['threeLevel'][$value['id']]['sort']);
                        unset($data[$value['pid']]['twoLevel'][$value['tag']['id']]['threeLevel'][$value['id']]['status']);
                        unset($data[$value['pid']]['twoLevel'][$value['tag']['id']]['threeLevel'][$value['id']]['createTime']);
                    }
                    else
                    {
                        //不存在二级分类标签
                        if(!$data[$value['pid']]['twoLevel'][0])
                        {
                            $data[$value['pid']]['twoLevel'][0]['name'] = $value['tag']['name'];
                        }
                        //三级分类
                        $data[$value['pid']]['twoLevel'][0]['threeLevel'][$value['id']] = $value;
                        unset($data[$value['pid']]['twoLevel'][0]['threeLevel'][$value['id']]['tag']);
                        unset($data[$value['pid']]['twoLevel'][0]['threeLevel'][$value['id']]['sort']);
                        unset($data[$value['pid']]['twoLevel'][0]['threeLevel'][$value['id']]['status']);
                        unset($data[$value['pid']]['twoLevel'][0]['threeLevel'][$value['id']]['createTime']);
                    }
                }
            }
            $data = arraySort($data, 'sort', 'asc');
            Cache::put('tagindex',$data,5);
        }

        View::share('data', $data);
        View::share('nav_back_url', $_SERVER["HTTP_REFERER"]);
        return $this->display();
    }

	public function goodsLists() {
		return $this->goodsListsItem('goodslists');
	}

	public function goodsListsItem($tpl='goodslistsitem') {
		$args = Input::all();
		$args['type'] = !empty($args['type']) ? $args['type'] : 1;  //1=价格 2=距离

		$tag = $this->requestApi('systemTag.checktag',['tagPid'=>$args['pid'],'tagId'=>$args['id']]);
		if($tag['code'] == 0)
		{
			View::share('tag', $tag['data']);
		}
		
        $address = Session::get("defaultAddress");
        $goodsArgs['apoint'] = $address['mapPointStr'];
		$goodsArgs['systemListId'] = $tag['data']['id'];
		$goodsArgs['type'] = $args['type'];
		$goodsArgs['page'] = $args['page'];

		$lists =  $this->requestApi('goods.goodstaglists',$goodsArgs);
		if($lists['code'] == 0)
		{
			View::share('lists', $lists['data']);
		}
		// dd($lists['data']);
		View::share('args', $args);

		return $this->display($tpl);
	}

    public function getList($tpl='item'){
        $args = Input::all();
        $args['systemListId'] = $args['firstLevelId'];
        $address = Session::get("defaultAddress");
        $args['apoint'] = $address['mapPointStr'];
        $list = $this->requestApi('SystemTag.getGoodsList',$args);
//        var_dump($list['data']);die;
        if($list['code'] == 0)
        {
            View::share('lists', $list['data']);
        }
        return $this->display($tpl);
    }

    public function getBrand($tpl='brand'){
        $args = Input::all();
        $args['systemListId'] = $args['firstLevelId'];
        $address = Session::get("defaultAddress");
        $args['apoint'] = $address['mapPointStr'];
        $result = $this->requestApi('SystemTag.setBrandAndClassfy',$args);
        View::share('brandList', $result['data']['brandList']);
        return $this->display($tpl);
    }

    public function getClassify($tpl='classify'){
        $args = Input::all();
        $args['systemListId'] = $args['firstLevelId'];
        $address = Session::get("defaultAddress");
        $args['apoint'] = $address['mapPointStr'];
        $result = $this->requestApi('SystemTag.setBrandAndClassfy',$args);
        View::share('classifyList', $result['data']['classifyList']);
        return $this->display($tpl);
    }
}
