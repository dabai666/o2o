<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/2/15
 * Time: 14:59
 */
namespace YiZan\Http\Controllers\Admin;
use View, Input, Form,Lang;

/*秒杀设置*/
class SecondKillController extends AuthController{
    public function __construct(){
        parent::__construct();
    }
    //秒杀专区
    public function index(){
        $args = array();
        $args['code'] = 'seckill_banner'; //秒杀banner
        $result = $this->requestApi('system.config.getOne',$args);
        $args['code'] = 'seckill_produce';//活动介绍
        $res = $this->requestApi('system.config.getOne',$args);

        foreach($result['code'] as $k=>$v){
                $result['code'][$k]['image']=$v['val'];
        }
        $result['code'][0]['seckill_produce'] = $res['code'][0]['val'];
        View::share('data',$result['code'][0]);
        return $this->display();
    }


    //秒杀专区设置修改
    public function edit(){
        $args = Input::all();
        $data = $this->requestApi('system.config.updateOne',$args);
        if( $data['code'] > 0 ) {
            return $this->error($data['msg'], '');
        }
        if(!empty($this->WapModuletype)){
            return $this->success($data['msg'] ,u('WapModule/index'), $data['data']);
        }else{
            return $this->success($data['msg'], u('SecondKill/index'), $data['data']);
        }
    }
}