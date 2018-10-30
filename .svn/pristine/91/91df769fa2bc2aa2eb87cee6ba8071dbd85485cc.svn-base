<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/14
 * Time: 14:45
 */
namespace YiZan\Http\Controllers\Admin;
use View, Input, Form,Lang;

/*模块设置*/
class ModuleController extends AuthController{
    public function __construct() {
        parent::__construct();
    }

    /*模块列表*/
    public function index(){
        $result = $this->requestApi('module.lists');
        if( $result['code'] == 0)
            View::share('list', $result['data']['list']);
        return $this->display();
    }

    /*
     * 模块添加
     * */
    public function create(){

        return $this->display('edit');
    }
    //编辑操作
    public function edit(){
        $result = $this->requestApi('module.get',Input::all());
        if($result['code'] == 0 )
            View::share('data', $result['data']);
        return $this->display();
    }

    /*
     * 删除模块
     * */
    public function destroy(){
        $args = Input::all();
        $id = (int)Input::get('id');
        if (empty($id)) {
            return $this->error(Lang::get('admin.noId'),u('Module/index'));
        }
        $args['id']  = $id;
        $data = $this->requestApi('module.delete',$args);
        if( $data['code'] > 0 ) {
            return $this->error($data['msg'], '');
        }
        if(!empty($this->WapModuletype)){
            return $this->success($data['msg'] ,u('WapModule/index'), $data['data']);
        }else{
            return $this->success($data['msg'], u('Module/index'), $data['data']);
        }
    }

    /*
     * 更新模块
     * */
    public function update(){
        $args = Input::all();
        !empty($args['id']) ?   $args['id']  = intval($args['id'])  :  $args['id'] = 0;
        if($args['id'] > 0 ) {//更新操作
            $data = $this->requestApi('module.update',$args);
            if( $data['code'] == 0 ) {
                if(!empty($this->WapModuletype)){
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('Module/edit',[ 'id'=>$args['id'] ]));
                }else{
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98003'),u('Module/edit',[ 'id'=>$args['id'] ]));
                }
            }
            else {
                return $this->error($data['msg'] ? $data['msg'] : $data['msg']=Lang::get('admin.code.98004'),'',$args);
            }
        }else{//添加操作
            $data = $this->requestApi('module.create',$args);
            if( $data['code'] == 0 ) {
                if(!empty($this->WapModuletype)){
                    return $this->success($data['msg'] ? $data['msg'] : $data['msg'] = Lang::get('admin.code.98001'),u('Module/create'));
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
