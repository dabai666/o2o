<?php
namespace YiZan\Http\Controllers\Admin;

use YiZan\Models\Goods;
use View, Input, Lang, Route, Page, Validator, Session, Response, Time, Redirect;
/**
 * 抢购管理
 */
class ShopBrandController extends AuthController{
    public function index(){
        $data = $this->requestApi('ShopBrand.getList');
        if($data['code'] == 0){
            View::share('list',$data['data']);
        }
        return $this->display();
    }
    public function edit(){
        $args = Input::all();
        if( !empty($args['id']) ) {
            $data = $this->requestApi('ShopBrand.getListById', ['id'=>$args['id']]);
            $data['data'][0]['honorImg'] = $data['data'][0]['honorImg'] ? explode(',',$data['data'][0]['honorImg']) : array();
            View::share('data', $data['data'][0]);
        }
        return $this->display();
    }
    public function destroy(){
        $args = Input::get();
//        var_dump($args);die;
        $data = $this->requestApi('ShopBrand.delete', ['id' => explode(',', $args['id'])]);
        $url = u('ShopBrand/index');
        if( $data['code'] > 0 ) {
            return $this->error($data['msg']?$data['msg']:$data['msg'] = Lang::get('admin.code.98006'),$url );
        }
        return $this->success($data['msg']?$data['msg']:$data['msg'] = Lang::get('admin.code.98005'), $url , $data['data']);
    }
    public function create(){
        return $this->display('edit');
    }
    public function save(){
        $args = Input::All();
        $result = $this->requestApi('ShopBrand.save', $args);
        $url = u('ShopBrand/index');
        if($result['code'] == 0){
            return $this->success($result['msg'] ? $result['msg'] : Lang::get('admin.code.98008'), $url);
        }else{
            return $this->error($result['msg'] ? $result['msg'] : Lang::get('admin.code.98009'));
        }
    }
	//查询品牌
	public function search(){
		$args = Input::All();
		$result = $this->requestApi('ShopBrand.search', $args);
		return Response::json($result);
	}
}