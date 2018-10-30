<?php namespace YiZan\Http\Controllers\Wap;

use Input, View;
/**
 * 物业缴费
 */
class PropertyFeeController extends AuthController {

	public function index() {
    	$args = Input::all();
    	$payitemlist = $this->requestApi('payitem.lists', $args);
        //print_r($payitemlist['data']);
		View::share('payitemlist', $payitemlist['data']);
    	$propertyfeelist = $this->requestApi('propertyfee.lists', $args);
    	//print_r($propertyfeelist);exit;
    	View::share('list', $propertyfeelist['data']);
		View::share('args', $args);
		return $this->display();
	}

	public function detail() {
		return $this->display();
	}

    public function log(){
        $args = Input::all();

        $paylists = $this->requestApi('propertyfee.paylists', $args);

        //print_r($paylists);
        View::share('list', $paylists['data']);
        View::share('args', $args);
        return $this->display();
    }
}
