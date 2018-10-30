<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/15
 * Time: 10:22
 */
namespace YiZan\Http\Controllers\Admin;
use View, Input, Form,Lang;
/**
 *金融超市
 */
class FinanceSupermarketController extends AuthController{
    public function __construct() {
        parent::__construct();
    }

    //金融超市设置
    public function index(){
        $result = $this->requestApi('module.getInfo');
        if( $result['code'] == 0)
            View::share('data', $result['data']);
        return $this->display();
    }

    //更新操作
    public function update(){
        $args = Input::all();
        !empty($args['id']) ?   $args['id']  = intval($args['id'])  :  $args['id'] = 0;
        if($args['id'] > 0 ) {//更新操作
            $data = $this->requestApi('module.FinanceSupermarkUpdate',$args);
            if( $data['code'] == 0 ) {
                if(!empty($this->WapModuletype)){
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('WapModule/edit',[ 'id'=>$args['id'] ]));
                }else{
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('Module/index',[ 'id'=>$args['id'] ]));
                }
            }
            else {
                return $this->error($data['msg'] ? $data['msg'] : $data['msg']=Lang::get('admin.code.98004'),'',$args);
            }
        }else{//添加操作
            $data = $this->requestApi('module.FinanceSupermarkCreate',$args);
            if( $data['code'] == 0 ) {
                if(!empty($this->WapModuletype)){
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('WapModule/create'));
                }else{
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('Module/index'));
                }
            }
            else {
                return $this->error($data['msg'] ? $data['msg'] : $data['msg']=Lang::get('admin.code.98002'),'',$args);
            }
        }

    }
}

