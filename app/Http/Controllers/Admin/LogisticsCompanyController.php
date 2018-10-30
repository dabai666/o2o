<?php
namespace YiZan\Http\Controllers\Admin;

use YiZan\Models\Menu;
use View, Input, Lang, Route, Page, Validator, Session, Response, Time;
/**
 * 营销管理
 */
class LogisticsCompanyController extends AuthController{
    public function index(){
        $args = Input::all();
        $data = $this->requestApi('LogisticsCompany.getList',$args);
        if($data['code'] == 0){
            View::share('list',$data['data']['list']);
        }
        return $this->display();
    }
    public function edit(){
        $args = Input::all();
        if( !empty($args['id']) ) {
            $data = $this->requestApi('LogisticsCompany.getListById', ['id'=>$args['id']]);
//            var_dump($data);die;
            View::share('data', $data['data'][0]);
        }
        return $this->display();
    }
    public function destroy(){
        $args = Input::get();
//        var_dump($args);die;
        $data = $this->requestApi('LogisticsCompany.delete', ['id' => explode(',', $args['id'])]);
        $url = u('LogisticsCompany/index');
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
        $result = $this->requestApi('LogisticsCompany.save', $args);
        $url = u('LogisticsCompany/index');
        if($result['code'] == 0){
            return $this->success($result['msg'] ? $result['msg'] : Lang::get('admin.code.98008'), $url);
        }else{
            return $this->error($result['msg'] ? $result['msg'] : Lang::get('admin.code.98009'));
        }
    }
}