<?php namespace YiZan\Http\Controllers\Wap;
use Illuminate\Support\Facades\Response;
use Input, View, Cache, Session,Request;
/**
 * 物业
 */
class PropertyController extends UserAuthController {

    public function __construct() {
        parent::__construct();
        View::share('nav','forum');
    }

    public function index() {
        $args = Input::all();
        $data = $this->requestApi('district.getdistrict', $args);
        $app_opendoor_config = $this->requestApi('config.configByCode',['code' => 'app_opendoor']);

        View::share('data', $data['data']);
        View::share('args', $args);
        View::share('user', $this->user);
        View::share('app_opendoor_config', $app_opendoor_config['data']);
        if($args['index_flage']){
            $url = "Index/index";
        }elseif (strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') === false) {
            $url = "Property/doors";
        } else {
            $url = "Unlock/index";
        }
        View::share('is_url',$url);
        return $this->display();
    }

    /**
     * 业主详细
     */
    public function detail() {
        $args = Input::all();
        $data = $this->requestApi('district.getdistrict', $args);
        //print_r($data);

        View::share('data', $data['data']);
        View::share('args', $args);
        return $this->display();
    }

    /**
     * 社区公告
     */
    public function article() {
        $args = Input::all();
        $data = $this->requestApi('district.getdistrict', $args);
        //print_r($data);
        $list = $this->requestApi('article.lists', ['sellerId'=>$data['data']['sellerId']]);
        View::share('list', $list['data']);
        View::share('args', $args);
        return $this->display();
    }

    public function articledetail() {
        $data = $this->requestApi('article.get', ['id'=>Input::get('id')]);
        //print_r($data);
        View::share('data', $data['data']);

        $result = $this->requestApi('article.read', ['id'=>Input::get('id')]);
        return $this->display();
    }

    public function brief() {
        $args = Input::all();
        $data = $this->requestApi('property.detail', $args);
        View::share('data', $data['data']);
        return $this->display();
    }

    public function applyaccess() {
        $args = Input::all();

        $result = $this->requestApi('user.applyaccess',$args);
        return Response::json($result);
    }

    public function livipayment(){
        return $this->display();
    }

    public function livelog(){
        $args = Input::all();
        $list = $this->requestApi('Live.lists',$args);
        View::share('args', $args);
        View::share('list', $list['data']);

        return $this->display();
    }

    public function typepay(){
        $args = Input::all();

        $defaultAddress = $args;
        unset($defaultAddress['type']);
        if(empty($defaultAddress)){
            $defaultAddress = Session::get("defaultAddress");
        }

        $isservice =  $this->requestApi('user.address.getisservice',['cityId'=>$defaultAddress['cityId']]);

        if($isservice['data'] == 1){
            $city = $this->requestApi('user.address.getbyid',['cityId'=>$defaultAddress['cityId']]);
            $city['data']['typepay'] = $args['type'];

            //获取缴费单位
            $company = $this->requestApi('live.getcompany',$city['data']);
            View::share('city', $city['data']);
            View::share('company', $company['data']);
        }else{
            View::share('company', '');
        }

        View::share('isservice', $isservice['data']);
        View::share('args', $args);
        return $this->display();
    }

    public function arrearage(){
        $args = Input::all();
        //获取欠费
        $arrearage = $this->requestApi('live.arrearage',$args);
        //var_dump($arrearage);exit;
        $args['balance'] = $arrearage['data']['Data']['Balances']['Balance'][0];
        $args2 = json_encode($args,true);
        $args2 = base64_encode($args2);
        View::share('arrearage', $arrearage['data']);
        View::share('args', $args);
        View::share('args2', $args2);

        return $this->display();
    }

    public function query(){
        $args = Input::all();
        $result = $this->requestApi('live.query',$args);
        return Response::json($result);
    }

    /**
     * 门禁钥匙
     */
    public function getdoorkeys() {
        $args = Input::all();
        $result = $this->requestApi('user.getdoorkeys', $args);
        return Response::json($result);

    }
    /**
     * 用户小区门禁列表
     */
    public function doors() {
        $args = Input::all();
        //小区
        $data = $this->requestApi('district.getdistrict', $args);
        View::share('data', $data['data']);
        View::share('args', $args);
        View::share('user', $this->user);
        //门禁
        $args['villagesid'] = $args['districtId'];
        $result = $this->requestApi('user.getdoorkeys', $args);
        View::share('list',$result['data']);

        return $this->display();

    }
    /*
     * 摇一摇开关
     * **/
    public function shakeswitch(){//shequwy
        $args = Input::all();
        //$shakeswitch = $args['status']=='on'?1:0;
        $result = $this->requestApi('property.shakeswitch',$args);
        return Response::json($result);
    }
}